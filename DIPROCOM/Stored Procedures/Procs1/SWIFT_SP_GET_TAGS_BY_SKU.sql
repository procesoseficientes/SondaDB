﻿CREATE PROC [DIPROCOM].[SWIFT_SP_GET_TAGS_BY_SKU]
@SKU VARCHAR(50),
@BATCH VARCHAR(50)
AS
SELECT 'BATCH' AS [TYPE],
SKU,
B.[TAG_COLOR],
(SELECT [TAG_VALUE_TEXT] FROM [DIPROCOM].[SWIFT_TAGS] AS A WHERE A.TAG_COLOR = B.TAG_COLOR) AS TAG_VALUE_TEXT,
B.BATCH_ID,
NULL AS SERIAL_NUMBER
FROM [DIPROCOM].[SWIFT_TAGS_BY_BATCH] AS B
WHERE [SKU] = @SKU AND [BATCH_ID] = @BATCH

UNION ALL
SELECT 'SERIE' AS [TYPE],
SKU,
B.[TAG_COLOR],
(SELECT [TAG_VALUE_TEXT] FROM [DIPROCOM].[SWIFT_TAGS] AS A WHERE A.TAG_COLOR = B.TAG_COLOR) AS TAG_VALUE_TEXT,
NULL AS BATCH_ID,
B.SERIAL_NUMBER
FROM [DIPROCOM].[SWIFT_TAGS_BY_SERIE] AS B

WHERE [SKU] = @SKU




