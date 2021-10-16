﻿CREATE PROC [DIPROCOM].[SWIFT_SP_UPDATEROUTE]
@ROUTE INT,
@NAME_ROUTE VARCHAR(50),
@GEOREFERENCE_ROUTE VARCHAR(50),
@COMMENT_ROUTE VARCHAR(MAX),
@LAST_UPDATE VARCHAR(50),
@LAST_UPDATE_BY VARCHAR(50)
AS
UPDATE SWIFT_ROUTES SET NAME_ROUTE=@NAME_ROUTE,
GEOREFERENCE_ROUTE=@GEOREFERENCE_ROUTE,COMMENT_ROUTE=@COMMENT_ROUTE,
LAST_UPDATE=GETDATE(),
LAST_UPDATE_BY=@LAST_UPDATE_BY
WHERE ROUTE = @ROUTE





