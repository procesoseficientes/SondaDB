﻿CREATE PROCEDURE [SONDA].[SWIFT_DELETE_TEMP]
@HEADER_NUMBER_TEMP INT
AS
EXEC [SONDA].SWIFT_INSERT_IN_TRANSAXION_AND_TASK
DELETE [SONDA].SWIFT_TEMP_RECEPTION_HEADER --WHERE RECEPTION_HEADER = @HEADER_NUMBER_TEMP
DELETE [SONDA].SWIFT_TEMP_RECEPTION_DETAIL --WHERE RECEPTION_HEADER = @HEADER_NUMBER_TEMP
 










