﻿
-- ============================================
-- Autor:				diego.as
-- Fecha de Creacion: 	13-10-2016 @ A-TEAM Sprint 2
-- Description:			SP que almacena el Detalle de la 
-- 						Trazabilidad de los Documentos de Consignacion

  -- MODIFICADO: 28-11-2016
  --        diego.as
  --        Se agregan parametros HANDLE_SERIAL y SERIAL_NUMBER

/*
-- Ejemplo de Ejecucion:
		--
		EXEC [SONDA].[SONDA_SP_INSERT_TRACEABILITY_CONSIGMENT]
			@CONSIGNMENT_ID = 26
			,@DOC_SERIE = 'Serie Consignación'
			,@DOC_NUM = '7'
			,@CODE_SKU = '10002'
			,@QTY_SKU = '14'
			,@ACTION = 'PAID'
			,@DOC_SERIE_TARGET = 'Seria Prueba hector'
			,@DOC_NUM_TARGET = 173
			,@DATE_TRANSACTION = '2016/10/13 19:00:53'
			,@POSTED_BY = 'RUDI@DIPROCOM'
			--
			SELECT * FROM [SONDA].[SONDA_HISTORICAL_TRACEABILITY_CONSIGNMENT]
*/
-- =============================================
CREATE PROCEDURE [SONDA].[SONDA_SP_INSERT_TRACEABILITY_CONSIGMENT]
(
	@CONSIGNMENT_ID INT
	,@DOC_SERIE VARCHAR(50)
	,@DOC_NUM INT
	,@CODE_SKU VARCHAR(250)
	,@QTY_SKU INT
	,@ACTION VARCHAR(50)
	,@DOC_SERIE_TARGET VARCHAR(50)
	,@DOC_NUM_TARGET INT
	,@DATE_TRANSACTION DATETIME
	,@POSTED_BY VARCHAR(50)
  ,@HANDLE_SERIAL INT = 0
  ,@SERIAL_NUMBER VARCHAR(150) = NULL
) AS
BEGIN
	--
	BEGIN TRY
		DECLARE @EXIST INT = 0
		--
  SELECT @HANDLE_SERIAL = CASE WHEN @HANDLE_SERIAL IS NULL THEN 0 ELSE @HANDLE_SERIAL END

		IF(@HANDLE_SERIAL = 0) BEGIN
		SELECT @EXIST = 1 FROM [SONDA].[SONDA_HISTORICAL_TRACEABILITY_CONSIGNMENT] AS H
		WHERE [H].[CONSIGNMENT_ID] = @CONSIGNMENT_ID AND [H].[DOC_SERIE] = @DOC_SERIE AND H.DOC_NUM = @DOC_NUM
		AND [H].[CODE_SKU] = @CODE_SKU AND H.QTY_SKU = @QTY_SKU AND [H].[ACTION] = @ACTION AND [H].[DOC_SERIE_TARGET] = @DOC_SERIE_TARGET
		AND [H].[DOC_NUM_TARGET] = @DOC_NUM_TARGET AND [H].[DATE_TRANSACTION] = @DATE_TRANSACTION AND [H].[POSTED_BY] = @POSTED_BY
		END
		--
		IF(@EXIST = 0) BEGIN
			INSERT INTO [SONDA].[SONDA_HISTORICAL_TRACEABILITY_CONSIGNMENT](
			[CONSIGNMENT_ID] 
			,[DOC_SERIE]
			,[DOC_NUM]
			,[CODE_SKU] 
			,[QTY_SKU]
			,[ACTION]
			,[DOC_SERIE_TARGET]
			,[DOC_NUM_TARGET]
			,[DATE_TRANSACTION]
			,[POSTED_DATETIME]
			,[POSTED_BY]
			,[IS_POSTED]
      ,[HANDLE_SERIAL]
      ,[SERIAL_NUMBER]
		) VALUES (
			@CONSIGNMENT_ID
			,@DOC_SERIE
			,@DOC_NUM
			,@CODE_SKU
			,@QTY_SKU
			,@ACTION
			,@DOC_SERIE_TARGET
			,@DOC_NUM_TARGET
			,@DATE_TRANSACTION
			,GETDATE()
			,@POSTED_BY
			,1
			,@HANDLE_SERIAL
			,@SERIAL_NUMBER
		)
		END
		--
	END TRY
	BEGIN CATCH
		DECLARE @ERROR VARCHAR(MAX)
		SET @ERROR = ERROR_MESSAGE()
		RAISERROR(@ERROR,16,1)
	END CATCH
	--
END


