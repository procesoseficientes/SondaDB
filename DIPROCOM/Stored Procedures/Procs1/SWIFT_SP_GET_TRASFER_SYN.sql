﻿CREATE PROC [DIPROCOM].SWIFT_SP_GET_TRASFER_SYN
@Login VARCHAR(50)
AS

UPDATE  [DIPROCOM].[SWIFT_TRANSFER_HEADER] SET
[STATUS] = 'EN_SINCRONIZACION'
WHERE [STATUS] IN ('PENDIENTE', 'EN_SINCRONIZACION')
AND SELLER_CODE = (SELECT TOP 1 RELATED_SELLER FROM [DIPROCOM].USERS 
WHERE [LOGIN] = @Login)

SELECT * 
FROM [DIPROCOM].[SWIFT_TRANSFER_HEADER]
WHERE [STATUS] IN ('PENDIENTE', 'EN_SINCRONIZACION')
AND SELLER_CODE = (SELECT TOP 1 RELATED_SELLER FROM [DIPROCOM].USERS 
WHERE [LOGIN] = @Login)
--AND B.SKU NOT IN( (SELECT COUNT_SKU FROM [DIPROCOM].SWIFT_CYCLE_COUNT_DETAIL WHERE COUNT_STATUS='PENDING'  AND COUNT_SKU IS NOT NULL) )