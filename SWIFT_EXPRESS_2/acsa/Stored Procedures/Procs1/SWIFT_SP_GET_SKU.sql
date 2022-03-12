﻿CREATE PROC [SONDA].[SWIFT_SP_GET_SKU]
@SKU varchar(50),
@WAREHOUSE varchar(50)
AS
SELECT *  FROM  [SONDA].SWIFT_VIEW_PRESALE_SKU svps
  WHERE svps.WAREHOUSE = @WAREHOUSE AND svps.SKU = @SKU