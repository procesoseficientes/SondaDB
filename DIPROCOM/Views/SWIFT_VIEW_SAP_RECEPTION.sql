﻿CREATE VIEW [SONDA].[SWIFT_VIEW_SAP_RECEPTION]
as 
SELECT 
    SAP_RECEPTION_ID			 AS SAP_RECEPTION_ID,
    ERP_DOC				AS ERP_DOC,
	PROVIDER_ID			AS PROVIDER_ID,
	PROVIDER_NAME		AS PROVIDER_NAME,
 	SKU 					AS SKU ,
	SKU_DESCRIPTION  		AS SKU_DESCRIPTION,
	 QTY					AS QTY 
FROM
	SWIFT_INTERFACES_ONLINE.[SONDA].ERP_VIEW_RECEPTION
