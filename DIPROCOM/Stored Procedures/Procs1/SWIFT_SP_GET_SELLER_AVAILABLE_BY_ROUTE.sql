-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	28-Sep-16 @ A-TEAM Sprint 2
-- Description:			Obtiene los vendedores activos

/*
-- Ejemplo de Ejecucion:
				EXEC [DIPROCOM].[SWIFT_SP_GET_SELLER_AVAILABLE_BY_ROUTE]
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_SELLER_AVAILABLE_BY_ROUTE]
AS
BEGIN
	SELECT DISTINCT
		[S].[SELLER_CODE]
		,[S].[SELLER_NAME]
		,[S].[PHONE1]
		,[S].[PHONE2]
		,[S].[RATED_SELLER]
		,[S].[STATUS]
		,[S].[EMAIL]
		,[S].[ASSIGNED_VEHICLE_CODE]
		,[S].[ASSIGNED_DISTRIBUTION_CENTER]
		,[S].[LAST_UPDATED]
		,[S].[LAST_UPDATED_BY]
		,[R].[ROUTE]
		,[R].[CODE_ROUTE]
	FROM [DIPROCOM].[SWIFT_SELLER] S
	LEFT JOIN [DIPROCOM].[SWIFT_ROUTES] [R] ON (
		[S].[SELLER_CODE] = [R].[SELLER_CODE]
	)
	WHERE [S].[STATUS] = 'ACTIVE'
END



