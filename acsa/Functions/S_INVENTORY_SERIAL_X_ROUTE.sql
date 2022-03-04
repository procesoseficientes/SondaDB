﻿
CREATE  FUNCTION [acsa].[S_INVENTORY_SERIAL_X_ROUTE]
(        
-- Add the parameters for the function here
@RouteId nvarchar(8) = 'PG.GUM01'
)
RETURNS TABLE 
AS
RETURN 
(
-- Add the SELECT statement with parameter references here
SELECT 
	i.SKU SKU
	,i.SERIAL_NUMBER		AS SKU_SERIE
	,''	AS SKU_PHONE
	,''		AS SKU_ICC
	,i.WAREHOUSE		AS WAREHOUSE
FROM 
 SWIFT_EXPRESS.[acsa].SWIFT_INVENTORY i 
  INNER JOIN  SWIFT_EXPRESS.[acsa].USERS u
  ON u.DEFAULT_WAREHOUSE = i.WAREHOUSE
  INNER JOIN SWIFT_EXPRESS.[acsa].SWIFT_VIEW_ALL_SKU svas
  ON i.sku  = svas.CODE_SKU
WHERE 	
u.SELLER_ROUTE=@RouteId
AND svas.HANDLE_SERIAL_NUMBER='1'
)




