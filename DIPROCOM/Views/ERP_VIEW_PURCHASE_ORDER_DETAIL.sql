CREATE VIEW [DIPROCOM].[ERP_VIEW_PURCHASE_ORDER_DETAIL]
AS
SELECT
  *
FROM OPENQUERY(ERPSERVER, 'SELECT     
 po.ItemCode,
 po.DocEntry,
 po.ObjType, 
 po.LineNum  Line_Num, 
 ISNULL(po.WhsCode, ''01'') AS Warehouse_Code, 
                      ''ST'' AS Sales_Unit
                      FROM         
                      bd_viscosa2008.dbo.POR1 AS po   ')