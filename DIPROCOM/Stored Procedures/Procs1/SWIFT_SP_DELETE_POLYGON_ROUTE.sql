﻿CREATE PROC [DIPROCOM].[SWIFT_SP_DELETE_POLYGON_ROUTE]
@CODE_ROUTE VARCHAR(50)
AS
DELETE FROM [DIPROCOM].[SWIFT_POLYGON_X_ROUTE]
      WHERE CODE_ROUTE = @CODE_ROUTE





