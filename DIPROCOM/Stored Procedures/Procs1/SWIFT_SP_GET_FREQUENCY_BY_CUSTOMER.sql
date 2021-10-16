﻿CREATE PROC [SONDA].[SWIFT_SP_GET_FREQUENCY_BY_CUSTOMER]
@CODE_CUSTOMER VARCHAR(100)
AS
SELECT 
	SUNDAY,
	MONDAY,
	TUESDAY,
	WEDNESDAY,
	THURSDAY,
	FRIDAY,
	SATURDAY 
FROM 
	[SONDA].SWIFT_CUSTOMER_FREQUENCY
WHERE
	CODE_CUSTOMER = @CODE_CUSTOMER




