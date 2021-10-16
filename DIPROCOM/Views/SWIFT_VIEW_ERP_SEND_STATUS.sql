﻿CREATE VIEW [DIPROCOM].[SWIFT_VIEW_ERP_SEND_STATUS]
AS
SELECT DISTINCT
	 A.HEADER_REFERENCE
	,CASE 
            WHEN A.TXN_TYPE = 'PICKING'
               THEN 'Picking'
            WHEN A.TXN_TYPE = 'PUTAWAY'
               THEN 'Recepción'
	END AS 'TXN_TYPE'
	,CASE 
            WHEN A.TXN_TYPE = 'PICKING'
               THEN A.SAP_REFERENCE
            WHEN A.TXN_TYPE = 'PUTAWAY'
               THEN (SELECT B.REFERENCE FROM [DIPROCOM].[SWIFT_RECEPTION_HEADER] AS B WHERE B.RECEPTION_HEADER = A.HEADER_REFERENCE)
	END AS 'SAP_REFERENCE'
	,CASE 
            WHEN A.TXN_TYPE = 'PICKING'
               THEN (SELECT[NAME_CUSTOMER] FROM [DIPROCOM].[SWIFT_VIEW_ALL_COSTUMER] WHERE [CODE_CUSTOMER] = (SELECT [CODE_CLIENT] FROM [DIPROCOM].[SWIFT_PICKING_HEADER] AS C WHERE C.PICKING_HEADER = A.HEADER_REFERENCE))
            WHEN A.TXN_TYPE = 'PUTAWAY'
               THEN (SELECT[NAME_PROVIDER] FROM [DIPROCOM].[SWIFT_VIEW_ALL_PROVIDERS] WHERE [CODE_PROVIDER] = (SELECT [CODE_PROVIDER] FROM [DIPROCOM].[SWIFT_RECEPTION_HEADER] AS D WHERE D.RECEPTION_HEADER = A.HEADER_REFERENCE))
	END AS 'PROVIDER/CUSTOMER'
	,CASE 
            WHEN A.TXN_TYPE = 'PICKING'
               THEN (SELECT E.LAST_UPDATE FROM [DIPROCOM].[SWIFT_PICKING_HEADER] AS E WHERE E.PICKING_HEADER = A.HEADER_REFERENCE)
            WHEN A.TXN_TYPE = 'PUTAWAY'
               THEN (SELECT F.LAST_UPDATE FROM [DIPROCOM].[SWIFT_RECEPTION_HEADER] AS F WHERE F.RECEPTION_HEADER = A.HEADER_REFERENCE)
	END AS 'DOCUMENT_DATE'
	,CASE 
            WHEN A.TXN_IS_POSTED_ERP IS NULL
               THEN 0
			WHEN A.TXN_IS_POSTED_ERP IS NOT NULL
               THEN A.TXN_IS_POSTED_ERP
	END AS 'TXN_IS_POSTED_ERP'
	,[TXN_ATTEMPTED_WITH_ERROR]
	,[TXN_POSTED_RESPONSE]
FROM [DIPROCOM].[SWIFT_TXNS] AS A WHERE 
	(A.SAP_REFERENCE != 'N/A' OR A.SAP_REFERENCE != 0)  
	AND A.SAP_REFERENCE IS NOT NULL
	AND (A.TXN_TYPE = 'PICKING' OR A.TXN_TYPE = 'PUTAWAY')




