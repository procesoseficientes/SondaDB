﻿-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		13-07-2016 @ Sprint  ζ
-- Description:			    SP que obtiene el conductor y vehiculo de un manifiesto

/*
-- Ejemplo de Ejecucion:
		--
		EXEC [acsa].[SWIFT_SP_GET_DRIVER_AND_VEHICLE_BY_MANIFEST]
			@MANIFEST_HEADER = 3071
			,@DISTRIBUTION_CENTER_ID = 6
*/
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_GET_DRIVER_AND_VEHICLE_BY_MANIFEST] (
	@MANIFEST_HEADER INT
	,@DISTRIBUTION_CENTER_ID INT
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT TOP 1
		[D].[CODE_DRIVER]
		,[D].[NAME_DRIVER]
		,[D].[LICENSE_DRIVER]
		,[V].[CODE_VEHICLE]
		,[V].[PLATE_VEHICLE]
		,[acsa].[SWIFT_FN_GET_LOGO_IMG_FROM_DISTRIBUTION_CENTER](@DISTRIBUTION_CENTER_ID) [LOGO_IMG]
	FROM [acsa].[SWIFT_MANIFEST_HEADER] [MH]
	INNER JOIN [acsa].[SWIFT_DRIVERS] [D] ON (
		[D].[CODE_DRIVER] = [MH].[CODE_DRIVER]
	)
	INNER JOIN [acsa].[SWIFT_VEHICLES] [V]ON (
		[V].[CODE_VEHICLE] = [MH].[CODE_VEHICLE]
	)
	WHERE [MH].[MANIFEST_HEADER] = @MANIFEST_HEADER
END



