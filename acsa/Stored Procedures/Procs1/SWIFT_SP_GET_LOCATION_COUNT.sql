﻿CREATE PROC [acsa].[SWIFT_SP_GET_LOCATION_COUNT]
@WAREHOUSE VARCHAR(50)
AS
SELECT * FROM [acsa].SWIFT_VIEW_ALL_LOCATIONS WHERE CODE_WAREHOUSE = @WAREHOUSE 
--AND LOCATION NOT IN
--(SELECT LOCATION FROM [acsa].SWIFT_CYCLE_COUNT_DETAIL WHERE COUNT_STATUS='PENDING'  AND LOCATION IS NOT NULL)
