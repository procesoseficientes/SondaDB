﻿
-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	21-01-2016
-- Description:			Almacena una transaccion por picking

/*
-- Ejemplo de Ejecucion:				
				--EXEC [PACASA].[SWIFT_SP_ADD_TXN_FOR_PIKING]
						@PALLET_ID = 41
						,@TASK_ID = 6184
						,@LAST_UPDATE_BY = 'OPER1@DIPROCOM'
						,@LAST_UPDATE_BY_NAME = 'FREE'
						,@CODE_SKU = '20GM'
						,@DESCRIPTION_SKU = 'DESCRIPCION'
						,@BATCH_ID = 40
						,@QTY = 1
						,@WAREHOUSE = 'WAREHOUSE_OLD'
						,@LOCATION = 'LOCATION_OLD'
						,@CATEGORY = 'PO'
						,@CATEGORY_DESCRIPTION = 'PICKING'
						,@BARCODE_SKU = 'BARCODE_SKU'
						,@COSTUMER_CODE = '001'
						,@COSTUMER_NAME = 'NOMBRE'
					--
					SELECT TOP 5 * from [PACASA].[SWIFT_TXNS] ORDER BY 1 DESC
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_ADD_TXN_FOR_PIKING]
	@PALLET_ID INT
	,@TASK_ID INT
	,@LAST_UPDATE_BY VARCHAR(50)
	,@LAST_UPDATE_BY_NAME VARCHAR(50)
	,@CODE_SKU VARCHAR(50)
	,@DESCRIPTION_SKU VARCHAR(MAX)
	,@BATCH_ID INT
	,@QTY INT
	,@WAREHOUSE VARCHAR(50)
	,@LOCATION VARCHAR(50)
	,@BARCODE_SKU VARCHAR(50)
	,@CATEGORY VARCHAR(50)
	,@CATEGORY_DESCRIPTION VARCHAR(50)
	,@COSTUMER_CODE VARCHAR(50)
	,@COSTUMER_NAME VARCHAR(250)
	,@ID INT = NULL OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;
	
	BEGIN TRAN
	BEGIN TRY
		INSERT INTO [PACASA].[SWIFT_TXNS](
			[TASK_SOURCE_ID]
			,[TXN_TYPE]
			,[TXN_DESCRIPTION]
			,[TXN_CATEGORY]
			,[TXN_CREATED_STAMP]
			,[TXN_OPERATOR_ID]
			,[TXN_OPERATOR_NAME]
			,[TXN_CODE_SKU]
			,[TXN_DESCRIPTION_SKU]
			,[TXN_QTY]
			,[TXN_SOURCE_CODE_WAREHOUSE]
			,[TXN_SOURCE_CODE_LOCATION]
			,[TXN_SOURCE_PALLET_ID]
			,[TXN_BARCODE_SKU]
			,[TXN_COSTUMER_CODE]
			,[TXN_COSTUMER_NAME]
		) 
		VALUES (
			@TASK_ID
			,'PICKING'
			,@CATEGORY_DESCRIPTION
			,@CATEGORY
			,GETDATE()
			,@LAST_UPDATE_BY
			,@LAST_UPDATE_BY_NAME
			,@CODE_SKU
			,@DESCRIPTION_SKU
			,@QTY
			,@WAREHOUSE
			,@LOCATION
			,@PALLET_ID
			,@BARCODE_SKU
			,@COSTUMER_CODE
			,@COSTUMER_NAME
		)
		--	   
		SELECT @ID = SCOPE_IDENTITY()
		SELECT @ID AS ID

		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		DECLARE @ERROR VARCHAR(1000)= ERROR_MESSAGE()
		RAISERROR (@ERROR,16,1)
	END CATCH
END
