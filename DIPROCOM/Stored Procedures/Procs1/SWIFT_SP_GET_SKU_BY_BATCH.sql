﻿CREATE PROC [PACASA].[SWIFT_SP_GET_SKU_BY_BATCH]
@BATCH_ID VARCHAR(150)
AS
SELECT DISTINCT
	[SKU],
	[SKU_DESCRIPTION]
FROM [PACASA].[SWIFT_INVENTORY]
WHERE [BATCH_ID] = @BATCH_ID




