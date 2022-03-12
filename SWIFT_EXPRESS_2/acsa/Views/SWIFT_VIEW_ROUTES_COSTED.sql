﻿CREATE VIEW [SONDA].[SWIFT_VIEW_ROUTES_COSTED]
AS
  SELECT 
	A.VEHICULE_ID, 
	B.PLATE_VEHICLE AS PLATES, 
	B.NAME_CLASSIFICATION AS VEHICULE_TYPE,
	B.BRAND,
	A.ROUTED_DATETIME AS ROUNDTRIP_DATE,
	A.CONSUMMED_GAS,
	A.INDIRECT_COST,
	A.ROUTE_ID,
	A.ACCUMULATED_KMS,
	A.ACCUMULATED_COSTS
	FROM 
		[SONDA].SWIFT_ROUTES_COSTED A, 
		[SONDA].[SWIFT_VIEW_VEHICLES] B
	WHERE
		A.VEHICULE_ID = B.CODE_VEHICLE