﻿create PROCEDURE [acsa].[SWIFT_DELETE_DETAIL_PICKING]
@PICKING_DETAIL_TEMP INT
AS
DELETE SWIFT_TEMP_PICKING_DETAIL WHERE PICKING_DETAIL = @PICKING_DETAIL_TEMP




