﻿CREATE PROCEDURE [SONDA].[SWIFT_GET_PICKING_DETAIL]
@PICKINGHEADER INT
AS
SELECT A.PICKING_DETAIL,A.CODE_SKU,A.DESCRIPTION_SKU,A.DISPATCH, A.SCANNED
FROM [SONDA].SWIFT_PICKING_DETAIL A
WHERE  A.PICKING_HEADER=@PICKINGHEADER





