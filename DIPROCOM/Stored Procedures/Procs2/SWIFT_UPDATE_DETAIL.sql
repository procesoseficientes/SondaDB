﻿CREATE PROCEDURE [DIPROCOM].[SWIFT_UPDATE_DETAIL]
@RECEPTION_DETAIL_TEMP INT,
@CODESKU VARCHAR(50),
@DESCRIPTION_SKU VARCHAR(50),
@EXPECTED FLOAT
AS
UPDATE SWIFT_TEMP_RECEPTION_DETAIL SET CODE_SKU = @CODESKU, DESCRIPTION_SKU = @DESCRIPTION_SKU,
EXPECTED = @EXPECTED,DIFFERENCE = @EXPECTED - 0
WHERE RECEPTION_DETAIL_TEMP = @RECEPTION_DETAIL_TEMP





