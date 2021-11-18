-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	28-Sep-16 @ A-TEAM Sprint 2
-- Description:			Inserta la frecuencia

/*
-- Ejemplo de Ejecucion:
				EXEC [acsa].[SWIFT_SP_INSERT_FREQUENCY_BY_POLYGON]
					@SUNDAY = 0
					,@MONDAY = 0
					,@TUESDAY = 1
					,@WEDNESDAY = 0
					,@THURSDAY = 0
					,@FRIDAY = 0
					,@SATURDAY = 0
					,@FRECUENCY_WEEKS = 1
					,@LAST_WEEK_VISITED = '20160925'
					,@LAST_UPDATED_BY = 'generente@DIPROCOM'
					,@CODE_ROUTE = 'RUDI@DIPROCOM'
					,@TYPE_TASK = 'PRESALE'
					,@POLYGON_ID = 66
				-- 
				SELECT * FROM [acsa].[SWIFT_FREQUENCY] WHERE CODE_ROUTE= 'RUDI@DIPROCOM' AND TYPE_TASK = 'PRESALE'
*/
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_INSERT_FREQUENCY_BY_POLYGON_BK] (
	@SUNDAY AS INT
	,@MONDAY AS INT
	,@TUESDAY AS INT
	,@WEDNESDAY AS INT
	,@THURSDAY AS INT
	,@FRIDAY AS INT
	,@SATURDAY AS INT
	,@FRECUENCY_WEEKS AS INT
	,@LAST_WEEK_VISITED AS DATE
	,@LAST_UPDATED_BY AS NVARCHAR(25)
	,@CODE_ROUTE AS VARCHAR(50)
	,@TYPE_TASK AS VARCHAR(20)
	,@POLYGON_ID INT
)
AS
	BEGIN
		BEGIN TRY
			DECLARE
				@ID INT
				,@CODE_FRECUENCY AS VARCHAR(100)
				,@ID_FREQUENCY INT
		
			-- ------------------------------------------------------------------------------------
			-- Genera la llave unica de la frecuencia
			-- ------------------------------------------------------------------------------------
			SELECT
				@CODE_FRECUENCY = @TYPE_TASK + @CODE_ROUTE
				+ CAST(@SUNDAY AS VARCHAR) + CAST(@MONDAY AS VARCHAR)
				+ CAST(@TUESDAY AS VARCHAR) + CAST(@WEDNESDAY AS VARCHAR)
				+ CAST(@THURSDAY AS VARCHAR) + CAST(@FRIDAY AS VARCHAR)
				+ CAST(@SATURDAY AS VARCHAR) + CAST(@FRECUENCY_WEEKS AS VARCHAR);
			--
			PRINT '@CODE_FRECUENCY: ' + @CODE_FRECUENCY
		
			-- ------------------------------------------------------------------------------------
			-- Inserta o actualiza la frecuencia
			-- ------------------------------------------------------------------------------------
			MERGE [acsa].[SWIFT_FREQUENCY] [F]
			USING
				(
					SELECT
						@CODE_FRECUENCY AS [CODE_FRECUENCY]
				) AS [NF]
			ON [F].[CODE_FREQUENCY] = [NF].[CODE_FRECUENCY]
			WHEN MATCHED THEN
				UPDATE SET
							[F].[SUNDAY] = @SUNDAY
							,[F].[MONDAY] = @MONDAY
							,[F].[TUESDAY] = @TUESDAY
							,[F].[WEDNESDAY] = @WEDNESDAY
							,[F].[THURSDAY] = @THURSDAY
							,[F].[FRIDAY] = @FRIDAY
							,[F].[SATURDAY] = @SATURDAY
							,[F].[FREQUENCY_WEEKS] = @FRECUENCY_WEEKS
							,[F].[LAST_WEEK_VISITED] = @LAST_WEEK_VISITED
							,[F].[LAST_UPDATED] = GETDATE()
							,[F].[LAST_UPDATED_BY] = @LAST_UPDATED_BY
			WHEN NOT MATCHED THEN
				INSERT
						(
							[CODE_FREQUENCY]
							,[SUNDAY]
							,[MONDAY]
							,[TUESDAY]
							,[WEDNESDAY]
							,[THURSDAY]
							,[FRIDAY]
							,[SATURDAY]
							,[FREQUENCY_WEEKS]
							,[LAST_WEEK_VISITED]
							,[LAST_UPDATED]
							,[LAST_UPDATED_BY]
							,[CODE_ROUTE]
							,[TYPE_TASK]
						)
				VALUES	(
							@CODE_FRECUENCY
							,@SUNDAY
							,@MONDAY
							,@TUESDAY
							,@WEDNESDAY
							,@THURSDAY
							,@FRIDAY
							,@SATURDAY
							,@FRECUENCY_WEEKS
							,@LAST_WEEK_VISITED
							,GETDATE()
							,@LAST_UPDATED_BY
							,@CODE_ROUTE
							,@TYPE_TASK
						);
			--
			SELECT TOP 1 @ID_FREQUENCY = [F].ID_FREQUENCY
			FROM [acsa].[SWIFT_FREQUENCY] [F]
			WHERE [F].[CODE_FREQUENCY] = @CODE_FRECUENCY
			--
			PRINT '@ID_FREQUENCY: ' + CAST(@ID_FREQUENCY AS VARCHAR)
			
			-- ------------------------------------------------------------------------------------
			-- Agrega los clientes a la frecuencia
			-- ------------------------------------------------------------------------------------
			INSERT INTO [acsa].[SWIFT_FREQUENCY_X_CUSTOMER]
			(
				[ID_FREQUENCY]
				,[CODE_CUSTOMER]
				,[PRIORITY]
			)
			SELECT
				@ID_FREQUENCY
				,[PC].[CODE_CUSTOMER]
				,1
			FROM [acsa].[SWIFT_POLYGON_X_CUSTOMER] PC
			LEFT JOIN [acsa].[SWIFT_FREQUENCY_X_CUSTOMER] FC ON (
				[FC].[ID_FREQUENCY] = @ID_FREQUENCY
				AND [FC].[CODE_CUSTOMER] = [PC].[CODE_CUSTOMER]
			)
			WHERE [PC].[POLYGON_ID] = @POLYGON_ID
				AND [FC].[CODE_CUSTOMER] IS NULL

			-- ------------------------------------------------------------------------------------
			-- Agrega propuesta de clientes
			-- ------------------------------------------------------------------------------------
			MERGE [acsa].[SWIFT_CUSTOMER_FREQUENCY] [CF]
			USING
				(
					SELECT 
						[PC].[POLYGON_ID]						
						,[PC].[CODE_CUSTOMER]						
						,@SUNDAY [SUNDAY]
						,@MONDAY [MONDAY]
						,@TUESDAY [TUESDAY]
						,@WEDNESDAY [WEDNESDAY]
						,@THURSDAY [THURSDAY]
						,@FRIDAY [FRIDAY]
						,@SATURDAY [SATURDAY]
						,@FRECUENCY_WEEKS [FREQUENCY_WEEKS]
					FROM [acsa].[SWIFT_POLYGON_X_CUSTOMER] PC 
					WHERE [PC].[POLYGON_ID] = @POLYGON_ID
				) [PC]
			ON (
				[CF].[CODE_CUSTOMER] = [PC].[CODE_CUSTOMER]
			)
			WHEN MATCHED THEN
				UPDATE SET
					[CF].[SUNDAY] = [PC].[SUNDAY]
					,[CF].[MONDAY] = [PC].[MONDAY]
					,[CF].[TUESDAY] = [PC].[TUESDAY]
					,[CF].[WEDNESDAY] = [PC].[WEDNESDAY]
					,[CF].[THURSDAY] = [PC].[THURSDAY]
					,[CF].[FRIDAY] = [PC].[FRIDAY]
					,[CF].[SATURDAY] = [PC].[SATURDAY]
					,[CF].[FREQUENCY_WEEKS] = [PC].[FREQUENCY_WEEKS]
					,[CF].[LAST_UPDATED] = GETDATE()
					,[CF].[LAST_UPDATED_BY] = @LAST_UPDATED_BY
			WHEN NOT MATCHED THEN
				INSERT
				(
					[CODE_CUSTOMER]
					,[SUNDAY]
					,[MONDAY]
					,[TUESDAY]
					,[WEDNESDAY]
					,[THURSDAY]
					,[FRIDAY]
					,[SATURDAY]
					,[FREQUENCY_WEEKS]
					,[LAST_DATE_VISITED]
					,[LAST_UPDATED]
					,[LAST_UPDATED_BY]
				)
				VALUES(
					[PC].[CODE_CUSTOMER]
					,[PC].[SUNDAY]
					,[PC].[MONDAY]
					,[PC].[TUESDAY]
					,[PC].[WEDNESDAY]
					,[PC].[THURSDAY]
					,[PC].[FRIDAY]
					,[PC].[SATURDAY]
					,[PC].[FREQUENCY_WEEKS]
					,GETDATE()
					,GETDATE()
					,@LAST_UPDATED_BY
				);
			
			-- ------------------------------------------------------------------------------------
			-- Marca los clientes del poligono como viejos con tareas
			-- ------------------------------------------------------------------------------------
			UPDATE [PC]
			SET
				IS_NEW = 0
				,HAS_PROPOSAL = 1
				,HAS_FREQUENCY = 1
			FROM [acsa].[SWIFT_POLYGON_X_CUSTOMER] PC
			WHERE [PC].[POLYGON_ID] = @POLYGON_ID

			-- ------------------------------------------------------------------------------------
			-- muestra el resultado
			-- ------------------------------------------------------------------------------------
			SELECT
				1 AS [Resultado]
				,'Proceso Exitoso' [Mensaje]
				,0 [Codigo]
				,CAST(@ID_FREQUENCY AS VARCHAR) [DbData];
		END TRY
		BEGIN CATCH
			SELECT
				-1 AS [Resultado]
				,ERROR_MESSAGE() [Mensaje]
				,@@ERROR [Codigo]; 
		END CATCH;
	END;



