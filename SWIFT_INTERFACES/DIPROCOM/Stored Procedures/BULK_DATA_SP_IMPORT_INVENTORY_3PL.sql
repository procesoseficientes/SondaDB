-- =============================================
-- Autor:				X.Y
-- Fecha de Creacion: 	29-02-2017
-- Description:			SP que importa inventario

/*
-- Ejemplo de Ejecucion:
				-- 
				EXEC [DIPROCOM].[BULK_DATA_SP_IMPORT_INVENTORY_3PL]
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[BULK_DATA_SP_IMPORT_INVENTORY_3PL]
AS
BEGIN
	SET NOCOUNT ON;
	--

	----------------------------------------------------------
	-- ELIMINA EL INVENTARIO SINCRONIZADO
	----------------------------------------------------------
	DELETE FROM [SWIFT_EXPRESS].[DIPROCOM].[SWIFT_INVENTORY]
    WHERE LOCATION='3PL_SONDA' 
			AND LAST_UPDATE_BY='PROCESO AUTOMATICO'

	----------------------------------------------------------
	-- SINCRONIZA EL INVENTARIO SINCRONIZADO
	----------------------------------------------------------
	INSERT INTO [SWIFT_EXPRESS].[DIPROCOM].[SWIFT_INVENTORY] 
	 SELECT
	   [SERIAL_NUMBER]
      ,[WAREHOUSE]
      ,[LOCATION]
      ,SKU --RTRIM(LTRIM(REPLACE([SKU],'MELLEGA','')))SKU
      ,[SKU_DESCRIPTION]
      ,[ON_HAND]
      ,[BATCH_ID]
      ,[LAST_UPDATE]
      ,[LAST_UPDATE_BY]
      ,[TXN_ID]
      ,[IS_SCANNED]
      ,[RELOCATED_DATE]
      ,[PALLET_ID]
	  FROM  [SWIFT_INTERFACES].[DIPROCOM].[OP_WMS_3PL_VIEW_INVENTORY_FOR_SONDA]
END