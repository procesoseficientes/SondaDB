﻿CREATE PROCEDURE [SONDA].[SWIFT_DELETE_DETAIL]
@RECEPTION_DETAIL_TEMP INT
AS
DELETE SWIFT_TEMP_RECEPTION_DETAIL WHERE RECEPTION_DETAIL_TEMP = @RECEPTION_DETAIL_TEMP