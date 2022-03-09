
-- =============================================
--  Autor:		joel.delcompare
-- Fecha de Creacion: 	2016-04-14 02:12:43
-- Description:		Obtiene las unidades de medida que maneja el ERP

-- Modificacion 3/13/2017 @ A-Team Sprint Ebonne
-- rodrigo.gomez
-- Se pusieron como referencias las vistas en la base de datos SAP_INTERCOMPANY

-- Modificacion 4/20/2017 @ A-Team Sprint Hondo
-- rodrigo.gomez
-- Se agregaron las columnas MasterID, OwnerID y Owner

/*
-- Ejemplo de Ejecucion:
USE SWIFT_INTERFACES_ONLINE
GO

SELECT
  CODE_PACK_UNIT
 ,DESCRIPTION_PACK_UNIT
 ,LAST_UPDATE
 ,LAST_UPDATE_BY
 ,UM_ENTRY
FROM [DIPROCOM].ERP_PACK_UNIT;
GO
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_PACK_UNIT]
AS
	SELECT DISTINCT
	  [CODE_PACK_UNIT]
	 ,MAX([DESCRIPTION_PACK_UNIT]) [DESCRIPTION_PACK_UNIT]
	 ,GETDATE() [LAST_UPDATE]
	 ,'BULK_DATA' [LAST_UPDATE_BY]
	 ,ROW_NUMBER() OVER(ORDER BY [CODE_PACK_UNIT] ASC) [UM_ENTRY]
	FROM OPENQUERY([DIPROCOM_SERVER], '
		SELECT DISTINCT
			RTRIM(UM_Origen) CODE_PACK_UNIT
			,MIN(RTRIM(Nombre_UM_O)) DESCRIPTION_PACK_UNIT
			,RTRIM(UM_Origen) UM_ENTRY   
		FROM [SONDA].[dbo].[vsUNIDADES_DE_VENTA] um
		INNER JOIN [SONDA].[dbo].[vsMAESTRO_PRODUCTOS] sku 
			ON um.Codigo_Producto = sku.Codigo_Producto
		GROUP BY UM_Origen
		UNION
		SELECT DISTINCT
			RTRIM(UM_Destino) CODE_PACK_UNIT
			,MIN(RTRIM(Nombre_UM_D)) DESCRIPTION_PACK_UNIT
			,RTRIM(UM_Destino) UM_ENTRY   
		FROM [SONDA].[dbo].[vsUNIDADES_DE_VENTA] um
		INNER JOIN [SONDA].[dbo].[vsMAESTRO_PRODUCTOS] sku 
			ON um.Codigo_Producto = sku.Codigo_Producto
		GROUP BY UM_Destino

		UNION
		SELECT DISTINCT
			RTRIM(UM_Origen) CODE_PACK_UNIT
			,MIN(RTRIM(Nombre_UM_O)) DESCRIPTION_PACK_UNIT
			,RTRIM(UM_Origen) UM_ENTRY   
		FROM [SONDA].[dbo].[vsUNIDADES_DE_VENTA_PREVENTA] um
		INNER JOIN [SONDA].[dbo].[vsMAESTRO_PRODUCTOS_PREVENTA] sku 
			ON um.Codigo_Producto = sku.Codigo_Producto
		WHERE Nombre_UM_O IS NOT NULL
		GROUP BY UM_Origen
		UNION
		SELECT DISTINCT
			RTRIM(UM_Destino) CODE_PACK_UNIT
			,MIN(RTRIM(Nombre_UM_D)) DESCRIPTION_PACK_UNIT
			,RTRIM(UM_Destino) UM_ENTRY   
		FROM [SONDA].[dbo].[vsUNIDADES_DE_VENTA_PREVENTA] um
		INNER JOIN [SONDA].[dbo].[vsMAESTRO_PRODUCTOS_PREVENTA] sku 
			ON um.Codigo_Producto = sku.Codigo_Producto
		WHERE Nombre_UM_D IS NOT NULL
		GROUP BY UM_Destino
   ') GROUP BY [CODE_PACK_UNIT];