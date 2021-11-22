-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		15-06-2016
-- Description:			    SP para obtener a los usuarios con su ruta asociada

/*
-- Ejemplo de Ejecucion:
				--
				EXEC [PACASA].[SWIFT_SP_GET_ROUTE_AND_USER]
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_ROUTE_AND_USER]
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT
		[R].[CODE_ROUTE]
		,[R].[NAME_ROUTE]
		,[U].[LOGIN]
		,[U].[NAME_USER]
	FROM [PACASA].[USERS] [U]
	INNER JOIN [PACASA].[SWIFT_ROUTES] [R] ON (
		[U].[SELLER_ROUTE] = [R].[CODE_ROUTE]
	)
END



