﻿CREATE PROC [acsa].[SWIFT_SP_CREATE_TAG_BY_BATCH]
@SKU VARCHAR(50),
@BATCH_ID VARCHAR(150),
@TAG_COLOR VARCHAR(8)
AS
INSERT INTO [acsa].[SWIFT_TAGS_BY_BATCH]
           ([SKU]
           ,[BATCH_ID]
           ,[TAG_COLOR])
     VALUES
           (@SKU
           ,@BATCH_ID
           ,@TAG_COLOR)





