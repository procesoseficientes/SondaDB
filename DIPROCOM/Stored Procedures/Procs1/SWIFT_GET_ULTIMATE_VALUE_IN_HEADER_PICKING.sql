﻿create PROCEDURE [acsa].[SWIFT_GET_ULTIMATE_VALUE_IN_HEADER_PICKING]
@HEADER_NUMBER_TEMP_PICKING INT
AS
DECLARE @HEADERNUMBERPICKING INT
--OBTENER EL ULTIMO VALOR
SELECT TOP 1 @HEADERNUMBERPICKING  = PICKING_HEADER FROM SWIFT_PICKING_HEADER ORDER BY PICKING_HEADER DESC
print '@@HEADER_NUMBER_TEMP_PICKING' print @HEADER_NUMBER_TEMP_PICKING
--ACTUALIZAR EL REGISTRO
UPDATE SWIFT_PICKING_DETAIL SET PICKING_HEADER = @HEADERNUMBERPICKING WHERE PICKING_HEADER = @HEADER_NUMBER_TEMP_PICKING





