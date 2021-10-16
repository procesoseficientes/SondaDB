﻿CREATE PROC [SONDA].[SWIFT_SP_GET_PRICE_LIST_SKU_ASSIGNED]
	@CODE_PRICE_LIST VARCHAR(50)
AS	
	SELECT PS.COST, S.* 
	FROM [SONDA].SWIFT_VIEW_SKU S
		INNER JOIN [SONDA].SWIFT_VIEW_PRICE_LIST_BY_SKU PS ON S.CODE_SKU = PS.CODE_SKU
	WHERE PS.CODE_PRICE_LIST = @CODE_PRICE_LIST
	







