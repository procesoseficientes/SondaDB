-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		09-Aug-17 @ Nexus Team Sprint Banjo-Kazooie
-- Description:			    Ajuste por intercompany

/*
-- Ejemplo de Ejecucion:
        SELECT * FROM [DIPROCOM].[ERP_VIEW_RECEPTION]
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_VIEW_RECEPTION]
AS
SELECT
  *
FROM OPENQUERY(ERPSERVER, 'SELECT 
    CAST( poD.DocEntry as varchar) + CAST(poD.LineNum as varchar)			 AS SAP_RECEPTION_ID,
    poD.DocEntry				AS ERP_DOC,
	po.CardCode			AS PROVIDER_ID,
	PO.CardName		AS PROVIDER_NAME,
 	pod.ItemCode 					AS SKU ,
	pod.dscription  		AS SKU_DESCRIPTION,
	pod.Quantity					AS QTY 
	,PO.[U_MasterIDProvider] [MASTER_ID_PROVIDER]
	,PO.[U_OwnerProvider] [OWNER]
FROM
	SAP_INTERCOMPANY.dbo.por1 POD 
	INNER JOIN SAP_INTERCOMPANY.dbo.OPOR   PO ON po.DocEntry = pod.DocEntry
	where 
--po.DocStatus=''O''  and 
  po.DocType=''I''	')