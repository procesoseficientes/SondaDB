--ALTER VIEW DIPROCOM.ERP_VIEW_ORDER_SERIE_DETAIL
--AS
--SELECT
--  *
--FROM OPENQUERY(ERPSERVER, 'SELECT     [bd_viscosa2008].dbo.OSRN.SysNumber, [bd_viscosa2008].dbo.OSRN.MnfSerial, [bd_viscosa2008].dbo.OSRN.ItemCode
--                                                    FROM          [bd_viscosa2008].dbo.PDN1 INNER JOIN
--                                                                           [bd_viscosa2008].dbo.OPDN ON [BD_prueba_viscosa].dbo.PDN1.DocEntry = [bd_viscosa2008].dbo.OPDN.DocEntry INNER JOIN
--                                                                           [bd_viscosa2008].dbo.OITL ON [BD_prueba_viscosa].dbo.PDN1.ItemCode = [bd_viscosa2008].dbo.OITL.ItemCode AND [bd_viscosa2008].dbo.PDN1.DocEntry = [bd_viscosa2008].dbo.OITL.DocEntry AND 
--                                                                           [bd_viscosa2008].dbo.PDN1.LineNum = [bd_viscosa2008].dbo.OITL.DocLine INNER JOIN
--                                                                           [bd_viscosa2008].dbo.ITL1 ON [BD_prueba_viscosa].dbo.OITL.LogEntry = [bd_viscosa2008].dbo.ITL1.LogEntry INNER JOIN
--                                                                           [bd_viscosa2008].dbo.OSRN ON [BD_prueba_viscosa].dbo.ITL1.MdAbsEntry = [bd_viscosa2008].dbo.OSRN.AbsEntry
--                                                    WHERE      ([bd_viscosa2008].dbo.OITL.DocType = 20) AND ([bd_viscosa2008].dbo.OITL.ManagedBy = 10000045) ')
--GO

CREATE VIEW [DIPROCOM].[ERP_VIEW_PICKING]
AS
SELECT
  SAP_PICKING_ID
 ,ERP_DOC
 ,CUSTOMER_ID
 ,CUSTOMER_NAME
 ,SKU
 ,SKU_DESCRIPTION
 ,QTY
FROM OPENQUERY(ERPSERVER, 'SELECT     CAST(POD.DocEntry AS VARCHAR) + CAST(POD.LineNum AS VARCHAR) AS SAP_PICKING_ID, POD.DocEntry AS ERP_DOC, PO.CardCode AS CUSTOMER_ID, PO.CardName AS CUSTOMER_NAME, 
                      POD.ItemCode AS SKU, POD.Dscription AS SKU_DESCRIPTION, POD.Quantity AS QTY
FROM         bd_viscosa2008.dbo.RDR1 AS POD INNER JOIN
                      bd_viscosa2008.dbo.ORDR AS PO ON PO.DocEntry = POD.DocEntry
WHERE     (PO.DocType = ''I'') ')