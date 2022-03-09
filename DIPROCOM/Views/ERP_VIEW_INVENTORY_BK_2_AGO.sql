

-- =============================================
-- Autor:				ppablo.loukota
-- Fecha de Creacion: 	16-12-2015
-- Description:			Vista que obtiene detalles de bodegas 

-- Modificacion 3/14/2017 @ A-Team Sprint Ebonne
					-- diego.as
					-- Se modifica para que apunte a la BD SAP_INTERCOMPANY

/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [DIPROCOM].[ERP_VIEW_INVENTORY]
*/
-- =============================================

CREATE VIEW [DIPROCOM].[ERP_VIEW_INVENTORY_BK_2_AGO]
AS 
	SELECT * FROM OPENQUERY (DIPROCOM_SERVER,'
		SELECT   
			CAST(NULL AS varchar)             AS SERIAL_NUMBER
			,RTRIM(inv.Codigo_Bodega)  COLLATE database_default  AS WAREHOUSE
			,RTRIM(inv.Codigo_Bodega)  COLLATE database_default  AS LOCATION
			,RTRIM(inv.Codigo_Producto)  COLLATE database_default AS SKU
			,RTRIM(sku.Nombre) COLLATE database_default  AS SKU_DESCRIPTION
			,SUM(ISNULL(inv.Cantidad,0))     AS ON_HAND
			,NULL             AS BATCH_ID
			,GETDATE()        AS LAST_UPDATE
			,''BULK_DATA''    AS LAST_UPDATE_BY
			,9999             AS TXN_ID
			,0                AS IS_SCANNED
			,NULL             AS RELOCATED_DATE
			,RTRIM(UM) COLLATE database_default AS CODE_PACK_UNIT_STOCK
		FROM [SONDA].[dbo].[vsINVENTARIO] inv
		INNER JOIN [SONDA].[dbo].[vsMAESTRO_PRODUCTOS] sku
			ON inv.Codigo_Producto = sku. Codigo_Producto
		GROUP BY inv.Codigo_Bodega, inv.Codigo_Producto, sku.Nombre, inv.UM
	')