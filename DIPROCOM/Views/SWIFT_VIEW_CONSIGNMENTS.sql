﻿CREATE VIEW [SONDA].[SWIFT_VIEW_CONSIGNMENTS]
AS
SELECT
	  A.CONSIGNMENT_ID
	, A.[CUSTOMER_ID]
	, A.[DATE_CREATE]
	, A.[DOC_DATE]
	, A.[DUE_DATE]
	, A.[STATUS]
	, A.[GPS_URL]
	, B.SKU
	, C.DESCRIPTION_SKU
	, B.PRICE
	, B.QTY
	, B.TOTAL_LINE
	,(SELECT SUM(QTY) FROM [SONDA].[SWIFT_CONSIGNMENT_DETAIL] WHERE CONSIGNMENT_ID IN (SELECT CONSIGNMENT_ID FROM [SONDA].[SWIFT_CONSIGNMENT_HEADER] WHERE CUSTOMER_ID = A.CUSTOMER_ID)) SKU_TOTAL
	--, (SELECT SUM(TOTAL_LINE) FROM [SONDA].[SWIFT_CONSIGNMENT_DETAIL] AS Z WHERE Z.CONSIGNMENT_ID = A.CONSIGNMENT_ID GROUP BY Z.SKU) AS TOTAL 	
FROM [SONDA].[SWIFT_CONSIGNMENT_HEADER] AS A
LEFT OUTER JOIN [SONDA].[SWIFT_CONSIGNMENT_DETAIL] AS B
ON A.CONSIGNMENT_ID = B.CONSIGNMENT_ID
LEFT OUTER JOIN [SONDA].[SWIFT_VIEW_ALL_SKU] AS C
ON B.SKU = C.CODE_SKU

