﻿CREATE PROC [PACASA].[SWIFT_UPDATE_PICKING_HEADER_FF_STATUS]
@PICKING_HEADER INT
AS
UPDATE SWIFT_PICKING_HEADER
SET FF_STATUS = 'NO_STOCK'
WHERE PICKING_HEADER = @PICKING_HEADER




