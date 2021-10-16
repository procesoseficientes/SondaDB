﻿
CREATE VIEW [DIPROCOM].[SWIFT_VIEW_SAP_SELLERS]
AS
SELECT     
	BO.SELLER_CODE AS SELLER_CODE, 
	BO.SELLER_NAME COLLATE SQL_Latin1_General_CP1_CI_AS  AS SELLER_NAME, 
	SD.ASSIGNED_VEHICLE_CODE , 
	SD.ASSIGNED_DISTRIBUTION_CENTER
FROM          SWIFT_INTERFACES.DIPROCOM.[ERP_VIEW_SELLER]  AS BO LEFT OUTER JOIN
                      DIPROCOM.SWIFT_SELLER_CONFIGURATIONS AS SD ON BO.SELLER_CODE = SD.CODE_SELLER
--ORDER BY SELLER_NAME









