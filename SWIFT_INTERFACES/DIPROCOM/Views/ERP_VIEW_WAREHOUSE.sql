﻿
CREATE VIEW [DIPROCOM].[ERP_VIEW_WAREHOUSE]
AS
SELECT
  [CODE_WAREHOUSE]
 ,[DESCRIPTION_WAREHOUSE]
 ,[WEATHER_WAREHOUSE]
 ,[STATUS_WAREHOUSE]
 ,[LAST_UPDATE]
 ,[LAST_UPDATE_BY]
 ,[IS_EXTERNAL]
FROM [DIPROCOM].[SWIFT_ERP_WAREHOUSE]