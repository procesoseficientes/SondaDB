﻿CREATE PROCEDURE [SONDA].[SWIFT_SP_DELETE_INVOICE_DRAFT]
@PICKING_HEADER INT
AS
	DELETE [SONDA].[SONDA_POS_INVOICE_HEADER] WHERE SOURCE_CODE = @PICKING_HEADER AND INVOICE_ID < 1