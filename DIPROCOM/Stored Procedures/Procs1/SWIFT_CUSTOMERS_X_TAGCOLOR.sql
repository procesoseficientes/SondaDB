﻿CREATE PROCEDURE [PACASA].[SWIFT_CUSTOMERS_X_TAGCOLOR]  @TagColor as varchar(255)
AS
BEGIN
	SELECT
		T0.TAG_COLOR
		,(SELECT TAG_VALUE_TEXT FROM [PACASA].SWIFT_TAGS WHERE TAG_COLOR=T0.TAG_COLOR) AS TAG_NAME
		,count(*) AS CUSTOMERS
	FROM [PACASA].SWIFT_TAG_X_CUSTOMER_NEW T0
	WHERE T0.TAG_COLOR=@TagColor
	GROUP BY T0.TAG_COLOR
END


