﻿-- =============================================
-- Autor:				rodrigo.gomez
-- Fecha de Creacion: 	12/29/2016 @ A-TEAM Sprint  Balder
-- Description:			obtiene las bodegas de acceso no asignadas al usuario, filtrar con la tabla SWIFT_WAREHOUSE_BY_USER_WITH_ACCESS

/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].[SWIFT_SP_GET_UNASSIGNED_ACCESS_WAREHOUSE_BY_LOGIN]
					@LOGIN = 'gerente@DIPROCOM'
					,@DISTRIBUTION_CENTER_ID = 1
				--
				SELECT * FROM [PACASA].[SWIFT_WAREHOUSE_BY_USER_WITH_ACCESS] WHERE [USER_CORRELATIVE] = 3
				SELECT * FROM [PACASA].[SWIFT_WAREHOUSE_X_DISTRIBUTION_CENTER] WHERE [DISTRIBUTION_CENTER_ID] = 1
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_UNASSIGNED_ACCESS_WAREHOUSE_BY_LOGIN](
	@LOGIN VARCHAR(50) = NULL
	,@DISTRIBUTION_CENTER_ID INT
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	DECLARE @CORRELATIVE INT
	--
	SELECT @CORRELATIVE = CORRELATIVE FROM [PACASA].[USERS] WHERE [LOGIN] = @LOGIN
	
	SELECT [SW].[WAREHOUSE]
			,[SW].[CODE_WAREHOUSE]
			,[SW].[DESCRIPTION_WAREHOUSE]
			,[SW].[WEATHER_WAREHOUSE]
			,[SW].[STATUS_WAREHOUSE]
			,[SW].[LAST_UPDATE]
			,[SW].[LAST_UPDATE_BY]
			,[SW].[IS_EXTERNAL]
			,[SW].[BARCODE_WAREHOUSE]
			,[SW].[SHORT_DESCRIPTION_WAREHOUSE]
			,[SW].[TYPE_WAREHOUSE]
			,[SW].[ERP_WAREHOUSE]
			,[SW].[ADDRESS_WAREHOUSE]
			,[SW].[GPS_WAREHOUSE]
	FROM [PACASA].[SWIFT_WAREHOUSES] [SW] 
	INNER JOIN [PACASA].[SWIFT_WAREHOUSE_X_DISTRIBUTION_CENTER] [WDC] ON (
		[WDC].[CODE_WAREHOUSE] = [SW].[CODE_WAREHOUSE]
	)
	LEFT JOIN [PACASA].[SWIFT_WAREHOUSE_BY_USER_WITH_ACCESS] [WUA] ON (
		[WUA].[CODE_WAREHOUSE] = [SW].[CODE_WAREHOUSE]
		AND [WUA].[USER_CORRELATIVE] = @CORRELATIVE
	)
	WHERE [WDC].[DISTRIBUTION_CENTER_ID] = @DISTRIBUTION_CENTER_ID
		AND [WUA].[USER_CORRELATIVE] IS NULL

END
