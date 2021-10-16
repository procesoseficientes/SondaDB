﻿CREATE PROC [SONDA].[SWIFT_SP_INSERT_PICKING_DETAIL_FF]
@PICKING_HEADER INT,
@CODE_SKU VARCHAR(50),
@DESCRIPTION_SKU VARCHAR(MAX),
@DISPATCH FLOAT
AS
INSERT INTO [SONDA].SWIFT_PICKING_DETAIL(
	PICKING_HEADER,
	CODE_SKU,
	DESCRIPTION_SKU,
	DISPATCH,
	SCANNED,
	LAST_UPDATE,
	[DIFFERENCE])
VALUES
	(@PICKING_HEADER,
	@CODE_SKU,
	@DESCRIPTION_SKU,
	@DISPATCH,
	0,
	GETDATE(),
	@DISPATCH)









