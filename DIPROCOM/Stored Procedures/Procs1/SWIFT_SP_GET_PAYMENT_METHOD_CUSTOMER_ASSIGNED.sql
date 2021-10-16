﻿CREATE PROC [SONDA].[SWIFT_SP_GET_PAYMENT_METHOD_CUSTOMER_ASSIGNED]
	@CODE_PAYMENT VARCHAR(50)
AS	
	SELECT C.*
	FROM [SONDA].[SWIFT_PAYMENT_METHODS_BY_CUSTOMER] PC
		INNER JOIN [SONDA].SWIFT_VIEW_CUSTOMERS C ON C.CODE_CUSTOMER = PC.CODE_CUSTOMER
	WHERE PC.CODE_PAYMENT = @CODE_PAYMENT





