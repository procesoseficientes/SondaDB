﻿CREATE PROC [PACASA].[SWIFT_SP_GET_SBO_POS]
@DOC_ENTRY VARCHAR(50),
@ITEMCODE VARCHAR(50)
AS
SELECT 
	T.TASK_SOURCE_ID AS TransactionId
	, SAP_REFERENCE AS DocEntry
	, t.TXN_CODE_SKU AS ItemCode
	, 0 AS LineNum
	, T.TXN_SERIE
	, TS.Txn_Serie  as TxnSerie
FROM [PACASA].SWIFT_TXNS T
	INNER JOIN [PACASA].SWIFT_TXNS_SERIES TS ON (T.TXN_ID = TS.TXN_ID AND T.TXN_CODE_SKU = TS.TXN_CODE_SKU)
WHERE SAP_REFERENCE = @DOC_ENTRY
AND T.TXN_CODE_SKU = @ITEMCODE
AND T.TXN_TYPE='PUTAWAY'



