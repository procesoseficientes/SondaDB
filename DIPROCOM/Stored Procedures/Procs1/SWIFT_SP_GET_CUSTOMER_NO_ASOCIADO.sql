﻿
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_CUSTOMER_NO_ASOCIADO]	
@CUSTOMER INTEGER,
@CODE_CUSTOMER INTEGER,
@NAME_CUSTOMER VARCHAR
AS
SELECT *
 FROM [SWIFT_EXPRESS].[DIPROCOM].[SWIFT_CUSTOMERS_NEW] AS CLIENTE
 WHERE  NOT EXISTS 
 (SELECT  1 
 from  [SWIFT_EXPRESS].[DIPROCOM].[SWIFT_FREQUENCY_X_CUSTOMER] AS FRECUENCIA
 WHERE    CLIENTE.CODE_CUSTOMER=@CODE_CUSTOMER  )


