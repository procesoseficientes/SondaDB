﻿CREATE VIEW  [acsa].[SWIFT_VIEW_SBO_PURCHASE_SERIE_DETAIL]  
AS 
SELECT     t.TXN_ID AS Transaction_id, t.SAP_REFERENCE AS Doc_Entry, t.TXN_CODE_SKU AS Item_Code, ISNULL(po.Line_Num, - 1) AS Line_Num, t.TXN_SERIE
FROM         (SELECT     t.TXN_ID, t.MANIFEST_SOURCE, t.SAP_REFERENCE, t.TASK_SOURCE_ID, t.TXN_TYPE, t.TXN_DESCRIPTION, t.TXN_CATEGORY, t.TXN_CREATED_STAMP, t.TXN_OPERATOR_ID, 
                                              t.TXN_OPERATOR_NAME, t.TXN_CODE_SKU, t.TXN_DESCRIPTION_SKU, t.TXN_QTY, t.HEADER_REFERENCE, t.TXN_ATTEMPTED_WITH_ERROR, t.TXN_IS_POSTED_ERP, 
                                              t.TXN_POSTED_ERP, t.TXN_POSTED_RESPONSE, s.TXN_SERIE
                       FROM          [acsa].SWIFT_TXNS AS t INNER JOIN
                                              [acsa].SWIFT_TXNS_SERIES AS s ON t.TXN_ID = s.TXN_ID AND t.TXN_CODE_SKU = s.TXN_CODE_SKU) AS t LEFT OUTER JOIN
                      [$(SWIFT_INTERFACES)].[acsa].[ERP_VIEW_PURCHASE_SERIE_DETAIL]  AS po ON t.TXN_CODE_SKU COLLATE SQL_Latin1_General_CP1_CI_AS = po.Item_Code AND t.SAP_REFERENCE = po.Doc_Entry
WHERE     (t.TXN_CATEGORY = 'PO') AND (ISNULL(t.TXN_IS_POSTED_ERP, 0) = 0)









