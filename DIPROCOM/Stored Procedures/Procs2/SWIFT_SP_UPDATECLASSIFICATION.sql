﻿CREATE PROC [SONDA].[SWIFT_SP_UPDATECLASSIFICATION]
@CLASSIFICATION int,
@GROUP_CLASSIFICATION VARCHAR(50),
@NAME_CLASSIFICATION VARCHAR(50),
@PRIORITY_CLASSIFICATION INT,
@VALUE_TEXT_CLASSIFICATION VARCHAR(50),
@LAST_UPDATE VARCHAR(50),
@LAST_UPDATE_BY VARCHAR(50),
@INTERFACE VARCHAR(50)
AS
UPDATE SWIFT_CLASSIFICATION SET GROUP_CLASSIFICATION=@GROUP_CLASSIFICATION,
NAME_CLASSIFICATION=@NAME_CLASSIFICATION,PRIORITY_CLASSIFICATION=@PRIORITY_CLASSIFICATION,
VALUE_TEXT_CLASSIFICATION=@VALUE_TEXT_CLASSIFICATION,
LAST_UPDATE=GETDATE(),
LAST_UPDATE_BY=@LAST_UPDATE_BY,
MPC01 = @INTERFACE
WHERE CLASSIFICATION = @CLASSIFICATION





