﻿CREATE PROC [SONDA].[SWIFT_SP_GET_TAGS_FOR_LOOKUP]
@BATCH_ID VARCHAR(150)
AS
--SELECT * FROM [SONDA].[SWIFT_TAGS_BY_BATCH] 
SELECT * 
	FROM [SONDA].[SWIFT_TAGS]
	WHERE TAG_COLOR NOT IN (SELECT TAG_COLOR FROM [SONDA].[SWIFT_TAGS_BY_BATCH] WHERE BATCH_ID = @BATCH_ID)




