

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

CREATE VIEW [DIPROCOM].[ERP_VIEW_INVENTORY]
AS 
SELECT * FROM OPENQUERY ([SAP_INTERCOMPANY],'
SELECT   
	CAST(NULL AS varchar)             AS SERIAL_NUMBER
	,[WHS].U_MasterId  COLLATE database_default  AS WAREHOUSE
	,[WHS].U_MasterId  COLLATE database_default  AS LOCATION
	,[OITMS].[U_MasterId]  COLLATE database_default AS SKU
	,[OITMS].[ItemName] COLLATE database_default  AS SKU_DESCRIPTION
	,SUM(ISNULL(OITWS.[OnHand],0))     AS ON_HAND
	,NULL             AS BATCH_ID
	,GETDATE()        AS LAST_UPDATE
	,''BULK_DATA''    AS LAST_UPDATE_BY
	,9999             AS TXN_ID
	,0                AS IS_SCANNED
	,NULL             AS RELOCATED_DATE
FROM [SAP_INTERCOMPANY].[dbo].[OITW] AS OITWS 
	INNER JOIN [SAP_INTERCOMPANY].[dbo].[OITM] AS OITMS ON OITMS.[ItemCode] = OITWS.[ItemCode]
	INNER JOIN [SAP_INTERCOMPANY].[dbo].[OWHS] AS WHS ON (OITWS.[WhsCode] = WHS.[WhsCode] 
													  AND OITMS.SOURCE=OITMS.U_Owner COLLATE DATABASE_DEFAULT 
													  AND WHS.U_Owner = OITMS.U_Owner COLLATE DATABASE_DEFAULT)
WHERE ISNULL(OITMS.[U_MasterId],'''') <> '''' AND ISNULL([WHS].U_MasterId, '''') <> ''''
GROUP BY [WHS].U_MasterId, [OITMS].[U_MasterId], [OITMS].[ItemName]
 ')




