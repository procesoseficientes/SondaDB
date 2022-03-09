﻿

-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	10-05-2016
-- Description:			Vista que obtiene los precios por sku

-- Modificacion 3/13/2017 @ A-Team Sprint Ebonne
-- rodrigo.gomez
-- Se pusieron como referencias las vistas en la base de datos SAP_INTERCOMPANY

-- Modificacion 4/21/2017 @ A-Team Sprint Hondo
-- rodrigo.gomez
-- Se agregaron las referencias a las columnas MasterId

/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [DIPROCOM].[ERP_PRICE_LIST_BY_SKU]
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_SKU_SALE_PACK_UNIT]
AS
	SELECT DISTINCT
	 [CODE_SKU] COLLATE DATABASE_DEFAULT [CODE_SKU]
	 ,[CODE_PACK_UNIT] COLLATE DATABASE_DEFAULT [CODE_PACK_UNIT]
	FROM OPENQUERY(DIPROCOM_SERVER,'
		SELECT
			RTRIM(CAST(Codigo_Cliente AS VARCHAR)) AS [CODE_PRICE_LIST]
			,RTRIM(lp.Codigo_Producto) AS [CODE_SKU]
			,Precio AS [BASEPRICE]
			,CASE PAGA_IMPUESTOS WHEN ''S'' THEN ROUND((Precio*0.15),6) ELSE 0 END AS [VAT]
			,RTRIM(UM_Origen) AS [CODE_PACK_UNIT]
			,RTRIM(UM_Origen) AS [UM_ENTRY] 
		FROM [SONDA].[dbo].[vsLISTAS_DE_PRECIO] lp 
		INNER JOIN [SONDA].[dbo].[vsUNIDADES_DE_VENTA] uv
			ON lp.Codigo_Producto = uv.Codigo_Producto
				AND lp.UM = uv.UM_Origen
		INNER JOIN [SONDA].[dbo].[vsMAESTRO_PRODUCTOS] mp
			ON lp.Codigo_Producto = mp.Codigo_Producto

	') WHERE [CODE_PRICE_LIST] IS NOT NULL