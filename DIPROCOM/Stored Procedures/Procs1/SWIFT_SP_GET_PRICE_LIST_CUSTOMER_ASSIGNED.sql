﻿CREATE PROC [DIPROCOM].[SWIFT_SP_GET_PRICE_LIST_CUSTOMER_ASSIGNED]
	@CODE_PRICE_LIST VARCHAR(50)
AS	
	SELECT TOP 100 C.*
	FROM [DIPROCOM].SWIFT_VIEW_PRICE_LIST_BY_CUSTOMER PC
		INNER JOIN [DIPROCOM].SWIFT_VIEW_CUSTOMERS C ON C.CODE_CUSTOMER = PC.CODE_CUSTOMER
	WHERE PC.CODE_PRICE_LIST = @CODE_PRICE_LIST
