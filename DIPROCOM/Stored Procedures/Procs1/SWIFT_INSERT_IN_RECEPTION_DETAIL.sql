﻿CREATE PROCEDURE [PACASA].[SWIFT_INSERT_IN_RECEPTION_DETAIL]
@RECEPTION_HEADER INT
AS
INSERT INTO [PACASA].SWIFT_RECEPTION_DETAIL(RECEPTION_HEADER,CODE_SKU,DESCRIPTION_SKU,EXPECTED,SCANNED,RESULT,LAST_UPDATE,DIFFERENCE)
SELECT RECEPTION_HEADER,CODE_SKU,DESCRIPTION_SKU,EXPECTED,SCANNED,RESULT,LAST_UPDATE,DIFFERENCE FROM SWIFT_TEMP_RECEPTION_DETAIL WHERE RECEPTION_HEADER=@RECEPTION_HEADER





