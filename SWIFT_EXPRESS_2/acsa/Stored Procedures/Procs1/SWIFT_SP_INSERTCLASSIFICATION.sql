﻿CREATE PROC [SONDA].[SWIFT_SP_INSERTCLASSIFICATION]
@GROUP_CLASSIFICATION VARCHAR(50),
@NAME_CLASSIFICATION VARCHAR(50),
@PRIORITY_CLASSIFICATION INT,
@VALUE_TEXT_CLASSIFICATION VARCHAR(50),
@LAST_UPDATE VARCHAR(50),
@LAST_UPDATE_BY VARCHAR(50),
@INTERFACE VARCHAR(50)
AS
INSERT INTO SWIFT_CLASSIFICATION (GROUP_CLASSIFICATION,NAME_CLASSIFICATION,PRIORITY_CLASSIFICATION,
VALUE_TEXT_CLASSIFICATION,LAST_UPDATE,LAST_UPDATE_BY,MPC01) VALUES (@GROUP_CLASSIFICATION,
@NAME_CLASSIFICATION,
@PRIORITY_CLASSIFICATION,
@VALUE_TEXT_CLASSIFICATION,
GETDATE(),
@LAST_UPDATE_BY, @INTERFACE)