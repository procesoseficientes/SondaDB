﻿CREATE PROC [PACASA].[SWIFT_UPDATE_FREQUENT_SELLER_BY_SKU]
@CODE_RELATION INT,
@FREQUENT VARCHAR(1)
AS
UPDATE [PACASA].SWIFT_SELLER_BY_SKU
SET
	[FREQUENT] = @FREQUENT
WHERE [CODE_RELATION] = @CODE_RELATION




