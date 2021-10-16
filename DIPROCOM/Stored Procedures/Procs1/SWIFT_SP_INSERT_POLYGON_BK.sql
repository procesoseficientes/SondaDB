-- =============================================
-- Autor:				hector.gonzalez
-- Fecha de Creacion: 	19-07-2016
-- Description:			inserta un poligono 

-- Modificacion 29-08-2016 @ Sprint θ
			-- alberto.ruiz
			-- Se agrego llamado para crear la ruta

-- Modificacion 30-08-2016 @ Sprint ι
			-- alberto.ruiz
			-- Se agrego parametro @CODE_WAREHOUSE

/*
-- Ejemplo de Ejecucion:
				--
				EXEC [DIPROCOM].[SWIFT_SP_INSERT_POLYGON]
					@POLYGON_NAME = 'RESERVACABAaaaa'
					,@POLYGON_DESCRIPTION ='Reserva de Biosfera Visis Caba'
					,@COMMENT =''
					,@LAST_UPDATE_BY ='RUDI@DIPROCOM'
					,@POLYGON_ID_PARENT = NULL
					,@POLYGON_TYPE = 'REGION'
					,@SUB_TYPE = NULL
					,@TYPE_TASK = NULL
					,@SAVE_ROUTE = 0
					,@CODE_WAREHOUSE = NULL
				--
				SELECT * FROM [DIPROCOM].[SWIFT_POLYGON] WHERE POLYGON_NAME = 'RESERVACABAaaaa'
				--
				SELECT * FROM DIPROCOM.SWIFT_ROUTES WHERE NAME_ROUTE = 'RESERVACABAaaaa'
			
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_INSERT_POLYGON_BK] (
	@POLYGON_NAME VARCHAR(250)
	,@POLYGON_DESCRIPTION VARCHAR(250)
	,@COMMENT VARCHAR(250)
	,@LAST_UPDATE_BY VARCHAR(50)
	,@POLYGON_ID_PARENT INT = NULL
	,@POLYGON_TYPE VARCHAR(250)
	,@SUB_TYPE VARCHAR(250) = NULL
	,@TYPE_TASK VARCHAR(20) = NULL
	,@SAVE_ROUTE INT = 0
	,@CODE_WAREHOUSE VARCHAR(50) = NULL
)
AS
BEGIN
	SET NOCOUNT ON;
	--	
	BEGIN TRY
		-- ------------------------------------------------------------
		-- Crear el poligono
		-- ------------------------------------------------------------
		DECLARE @ID INT
		--
		INSERT INTO [DIPROCOM].[SWIFT_POLYGON] (
			POLYGON_NAME
			,POLYGON_DESCRIPTION
			,COMMENT
			,LAST_UPDATE_BY
			,LAST_UPDATE_DATETIME
			,POLYGON_ID_PARENT
			,POLYGON_TYPE
			,SUB_TYPE
			,TYPE_TASK
			,CODE_WAREHOUSE
		) VALUES (
			@POLYGON_NAME
			,@POLYGON_DESCRIPTION
			,@COMMENT
			,@LAST_UPDATE_BY
			,GETDATE()
			,@POLYGON_ID_PARENT
			,@POLYGON_TYPE
			,@SUB_TYPE
			,@TYPE_TASK
			,@CODE_WAREHOUSE
		)
		--
		SET @ID = SCOPE_IDENTITY()

		-- ------------------------------------------------------------
		-- Crear la ruta		
		-- ------------------------------------------------------------
		IF @SAVE_ROUTE = 1 
		BEGIN
			EXEC [DIPROCOM].[SWIFT_SP_INSERT_ROUTE_FROM_POLYGON]
				@CODE_ROUTE = @ID
				,@NAME_ROUTE = @POLYGON_NAME
		END

		-- ------------------------------------------------------------
		-- Muetra el resutlado
		-- ------------------------------------------------------------
		IF @@error = 0
		BEGIN
		  SELECT
			1 AS RESULTADO
		   ,'Proceso Exitoso' MENSAJE
		   ,0 CODIGO
		   , CONVERT(VARCHAR(16), @ID)  AS DbData
		END 
		ELSE
		BEGIN
		  SELECT
			-1 AS RESULTADO
		   ,ERROR_MESSAGE() MENSAJE
		   ,@@ERROR CODIGO
			, '0' AS DbData
		END
	END TRY
	BEGIN CATCH
		DECLARE @ERROR_CODE INT
		--
		SET @ERROR_CODE = @@ERROR
		--
		SELECT
			-1 AS RESULTADO
			,CASE CAST(@ERROR_CODE AS VARCHAR)
				WHEN '2627' THEN 'No se puede guardar el poligono porque ya existe uno con ese nombre'
				ELSE ERROR_MESSAGE() 
			END MENSAJE
			,@ERROR_CODE CODIGO
			, '0' AS DbData
		--
		ROLLBACK
	END CATCH
END
