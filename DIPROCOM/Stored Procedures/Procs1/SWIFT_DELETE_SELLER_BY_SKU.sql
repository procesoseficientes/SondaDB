﻿CREATE PROC [DIPROCOM].[SWIFT_DELETE_SELLER_BY_SKU]
@SKU_CODE NVARCHAR(40),
@SELLER_CODE NVARCHAR(40)
AS
DELETE FROM DIPROCOM.SWIFT_SELLER_BY_SKU 
WHERE CODE_SELLER = @SELLER_CODE AND CODE_SKU = @SKU_CODE



