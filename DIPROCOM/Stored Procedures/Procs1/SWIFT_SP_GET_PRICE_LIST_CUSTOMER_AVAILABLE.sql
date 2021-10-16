﻿CREATE PROC [DIPROCOM].[SWIFT_SP_GET_PRICE_LIST_CUSTOMER_AVAILABLE]
	@CODE_PRICE_LIST VARCHAR(50)
AS
	SELECT *
		, ISNULL((SELECT P.NAME_PRICE_LIST
					FROM DIPROCOM.SWIFT_VIEW_PRICE_LIST_BY_CUSTOMER PC1
							INNER JOIN DIPROCOM.SWIFT_VIEW_PRICE_LIST P ON PC1.CODE_PRICE_LIST = P.CODE_PRICE_LIST					
					WHERE C.CODE_CUSTOMER = CODE_CUSTOMER ), '') AS PRICE_LIST_ASSIGNED
	FROM DIPROCOM.SWIFT_VIEW_ALL_COSTUMER C
	WHERE NOT EXISTS(SELECT 1
					FROM DIPROCOM.SWIFT_VIEW_PRICE_LIST_BY_CUSTOMER PC
					WHERE C.CODE_CUSTOMER = PC.CODE_CUSTOMER
					AND PC.CODE_PRICE_LIST = @CODE_PRICE_LIST
	)







