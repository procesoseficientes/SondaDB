CREATE FUNCTION [SONDA].[SWIFT_FUNCTION_GET_SAP_PICKING]
(	
	@pERP_DOC varchar(25)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * 
		FROM [SONDA].SWIFT_VIEW_SAP_PICKING WHERE
		ERP_DOC = @pERP_DOC
--	select *from openquery ([SONDA]SERVER,'SELECT     CAST(POD.DocEntry AS VARCHAR) + CAST(POD.LineNum AS VARCHAR) AS SAP_PICKING_ID, POD.DocEntry AS ERP_DOC, PO.CardCode AS CUSTOMER_ID, PO.CardName AS CUSTOMER_NAME, 
--                      POD.ItemCode AS SKU, POD.Dscription AS SKU_DESCRIPTION, POD.Quantity AS QTY
--FROM         [Me_Llega_DB].dbo.RDR1 AS POD INNER JOIN
--                      [Me_Llega_DB].dbo.ORDR AS PO ON PO.DocEntry = POD.DocEntry
--WHERE     (PO.DocType = ''I'')  AND
--		POD.DocEntry = '''.@pERP_DOC.'''') 
)