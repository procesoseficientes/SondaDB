﻿

CREATE VIEW [SONDA].[SWIFT_VIEW_TAGS_BY_SKU]
AS
SELECT 'BATCH' AS [TYPE],
SKU,
B.[TAG_COLOR],
(SELECT [TAG_VALUE_TEXT] FROM [SONDA].[SWIFT_TAGS] AS A WHERE A.TAG_COLOR = B.TAG_COLOR) AS TAG_VALUE_TEXT,
B.BATCH_ID,
NULL AS SERIAL_NUMBER
FROM [SONDA].[SWIFT_TAGS_BY_BATCH] AS B


UNION ALL
SELECT 'SERIE' AS [TYPE],
SKU,
B.[TAG_COLOR],
(SELECT [TAG_VALUE_TEXT] FROM [SONDA].[SWIFT_TAGS] AS A WHERE A.TAG_COLOR = B.TAG_COLOR) AS TAG_VALUE_TEXT,
NULL AS BATCH_ID,
B.SERIAL_NUMBER
FROM [SONDA].[SWIFT_TAGS_BY_SERIE] AS B