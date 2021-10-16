-- =============================================
-- Autor:	alejandro.ochoa
-- Fecha de Creacion: 	2018-07-02 @Diprocom
-- Description:	 Se cambia la tabla por una vista que lee directamente el inventario al ERP, 
-- por peticion del Cliente que en cada inicio de ruta se lea el inventario del ERP en ese momento.

/*
-- Ejemplo de Ejecucion:
		SELECT * FROM [diprocom].[SWIFT_INVENTORY]
*/
-- =============================================
CREATE VIEW	diprocom.SWIFT_INVENTORY
AS

	SELECT ROW_NUMBER() OVER (ORDER BY [WAREHOUSE],[SKU]) AS [INVENTORY],
	   [SERIAL_NUMBER] ,
       [WAREHOUSE] ,
       [LOCATION] ,
       [SKU] ,
       [SKU_DESCRIPTION] ,
       [ON_HAND] ,
       [BATCH_ID] ,
       [LAST_UPDATE] ,
       [LAST_UPDATE_BY] ,
       [TXN_ID] ,
       [IS_SCANNED] ,
       [RELOCATED_DATE] ,
	   NULL AS [PALLET_ID],
	   NULL AS [OWNER],
	   NULL AS [OWNER_ID],
       [CODE_PACK_UNIT_STOCK] 
	FROM [SWIFT_INTERFACES_ONLINE].[diprocom].[ERP_VIEW_INVENTORY]
	WHERE [WAREHOUSE] NOT IN ('\')


