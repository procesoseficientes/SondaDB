﻿
CREATE PROCEDURE [dbo].[SWIFT_SP_GETUSEREXTERAL_FOR_CODE_ENTERPRISE]
@CODE_ENTERPRISE VARCHAR(50)
AS
SELECT * FROM dbo.SWIFT_EXTERNAL_USER WHERE CODE_ENTERPRISE=@CODE_ENTERPRISE