
-- =============================================
-- Autor:				        hector.gonzalez
-- Fecha de Creacion: 	2017-01-13 TeamErgon Sprint 1
-- Description:			    Vista que trae el detalle de las recepciones de sap


-- Modificación: pablo.aguilar
-- Fecha de Creacion: 	2017-01-18 Team ERGON - Sprint ERGON 1
-- Description:	 Se agrega al select el campo OBJECT_TYPE

-- Modificacion 09-Aug-17 @ Nexus Team Sprint Banjo-Kazooie
-- alberto.ruiz
-- Ajuste por intercompany


/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [SONDA].[ERP_VIEW_RECEPTION_DOCUMENT_DETAIL]
					
*/
-- =============================================
CREATE VIEW [SONDA].[ERP_VIEW_RECEPTION_DOCUMENT_DETAIL]
AS

SELECT
  *
FROM OPENQUERY([ERPSERVER], 'SELECT 
		CAST( poD.DocEntry as varchar)  AS SAP_RECEPTION_ID --DOC_ENTRY
		,po.DocNum AS ERP_DOC --DOC_NUM
		,po.CardCode AS PROVIDER_ID
		,po.CardName AS PROVIDER_NAME
 		,pod.ItemCode AS SKU
		,pod.dscription AS SKU_DESCRIPTION
		,pod.OpenQty AS QTY
    ,pod.ObjType as OBJECT_TYPE
		,pod.LineNum AS LINE_NUM
		,CASE ISNULL(PO.COMMENTS,'''')
			WHEN '''' THEN ''N/A''
			ELSE PO.COMMENTS
		END AS COMMENTS
		,POD.[U_MasterIdSKU] [MASTER_ID_SKU]
		,POD.[U_Owner] [OWNER_SKU]
		,POD.[U_Owner] [OWNER]
		,POD.[WhsCode] [ERP_WAREHOUSE_CODE]
	FROM [SAP_INTERCOMPANY].dbo.por1 POD
	inner join [SAP_INTERCOMPANY].DBO.OPOR PO ON (po.DocEntry = pod.DocEntry AND [POD].[U_Owner] = [PO].[U_Owner])
	where 
		po.DocStatus=''O''
		AND po.DocType=''I''
		AND pod.OpenQty > 0 ')