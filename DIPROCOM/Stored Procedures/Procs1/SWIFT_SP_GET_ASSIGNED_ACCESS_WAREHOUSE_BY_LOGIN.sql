﻿-- =============================================
-- Autor:				rodrigo.gomez
-- Fecha de Creacion: 	12/29/2016 @ A-TEAM Sprint  Balder
-- Description:			obtiene las bodegas de acceso ya asignadas al usuario en la tabla SWIFT_WAREHOUSE_BY_USER_WITH_ACCESS

/*
-- Ejemplo de Ejecucion:
				EXEC [acsa].[SWIFT_SP_GET_ASSIGNED_ACCESS_WAREHOUSE_BY_LOGIN]
					@LOGIN = 'rudi@DIPROCOM'
*/
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_GET_ASSIGNED_ACCESS_WAREHOUSE_BY_LOGIN](
	@LOGIN VARCHAR(50) = NULL
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	DECLARE @CORRELATIVE INT = (SELECT CORRELATIVE FROM [acsa].[USERS] WHERE [LOGIN] = @LOGIN)

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
	FROM [acsa].[SWIFT_WAREHOUSES] [SW]
		INNER JOIN [acsa].[SWIFT_WAREHOUSE_BY_USER_WITH_ACCESS] [SWUA] ON [SWUA].[CODE_WAREHOUSE] = [SW].[CODE_WAREHOUSE]
	WHERE [SWUA].[USER_CORRELATIVE] = @CORRELATIVE

END
