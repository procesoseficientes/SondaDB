﻿CREATE VIEW [DIPROCOM].[SWIFT_VIEW_POLYGON_X_ROUTE]
AS
SELECT 
	 B.CODE_ROUTE
	,B.NAME_ROUTE
	,B.GEOREFERENCE_ROUTE
	,A.POSITION
	,A.LATITUDE
	,A.LONGITUDE 
FROM [DIPROCOM].[SWIFT_POLYGON_X_ROUTE] AS A
	LEFT OUTER JOIN [DIPROCOM].[SWIFT_ROUTES] AS B
	ON A.CODE_ROUTE = B.CODE_ROUTE



