
-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		09-05-2016
-- Description:			    Vista que trae los precios por paquete y escala de sku

-- Modificacion 3/13/2017 @ A-Team Sprint Ebonne
-- rodrigo.gomez
-- Se pusieron como referencias las vistas en la base de datos SAP_INTERCOMPANY

/*
-- Ejemplo de Ejecucion:
        SELECT * FROM [DIPROCOM].[ERP_PRICE_LIST_BY_SKU_PACK_SCALE]
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_PRICE_LIST_BY_SKU_PACK_SCALE]
AS

	SELECT DISTINCT
	  [CODE_PRICE_LIST] COLLATE DATABASE_DEFAULT [CODE_PRICE_LIST]
	 ,[CODE_SKU] COLLATE DATABASE_DEFAULT [CODE_SKU]
	 ,([BASEPRICE] + [VAT]) AS [COST]
	 ,[CODE_PACK_UNIT] COLLATE DATABASE_DEFAULT [CODE_PACK_UNIT]
	 ,LIMIT
	FROM OPENQUERY(DIPROCOM_SERVER,'
		SELECT 
			RTRIM(CAST(lp.Codigo_Cliente AS VARCHAR)) AS [CODE_PRICE_LIST]
			,RTRIM(lp.Codigo_Producto) AS [CODE_SKU]
			,Precio AS [BASEPRICE]
			,CASE PAGA_IMPUESTOS WHEN ''S'' THEN ROUND((Precio*0.15),6) ELSE 0 END AS [VAT]
			,RTRIM(lp.UM) AS [CODE_PACK_UNIT]
			,1 AS LIMIT 
		FROM [SONDA].[dbo].[vsLISTAS_DE_PRECIO] lp
		INNER JOIN [SONDA].[dbo].[vsMAESTRO_PRODUCTOS] mp
			ON lp.Codigo_Producto = mp.Codigo_Producto
		INNER JOIN [SONDA].[dbo].[vsUNIDADES_DE_VENTA] up
			ON up.Codigo_Producto = mp.Codigo_Producto
			AND up.UM_Origen = lp.UM
		UNION

		SELECT 
			RTRIM(CAST(lp.Codigo_Cliente AS VARCHAR)) AS [CODE_PRICE_LIST]
			,RTRIM(lp.Codigo_Producto) AS [CODE_SKU]
			,Precio AS [BASEPRICE]
			,CASE PAGA_IMPUESTOS WHEN ''S'' THEN ROUND((Precio*0.15),6) ELSE 0 END AS [VAT]
			,RTRIM(lp.UM) AS [CODE_PACK_UNIT]
			,1 AS LIMIT
		FROM [SONDA].[dbo].[vsLISTAS_DE_PRECIO_PREVENTA] lp
		INNER JOIN [SONDA].[dbo].[vsMAESTRO_PRODUCTOS_PREVENTA] mp
			ON lp.Codigo_Producto = mp.Codigo_Producto
		INNER JOIN [SONDA].[dbo].[vsUNIDADES_DE_VENTA_PREVENTA] up
			ON up.Codigo_Producto = mp.Codigo_Producto
			AND up.UM_Origen = lp.UM
	')