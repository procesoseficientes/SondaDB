﻿CREATE PROCEDURE [acsa].[SWIFT_UPDATE_DETAIL_PICKING]
@PICKING_DETAIL_TEMP INT,
@CODESKU VARCHAR(50),
@DESCRIPTION_SKU VARCHAR(50),
@DISPATCH FLOAT
AS
UPDATE SWIFT_TEMP_PICKING_DETAIL SET CODE_SKU = @CODESKU, DESCRIPTION_SKU = @DESCRIPTION_SKU,
DISPATCH = @DISPATCH,DIFFERENCE = @DISPATCH - 0
WHERE PICKING_DETAIL = @PICKING_DETAIL_TEMP









