-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		05-Jan-17 @ A-Team Sprint Balder
-- Description:			    Funcion que obtiene el ID del codigo de ruta

/*
-- Ejemplo de Ejecucion:
        SELECT [DIPROCOM].[SWIFT_FN_GET_ROUTE_ID_FROM_CODE_ROUTE]('RUDI@DIPROCOM')
*/
-- =============================================
CREATE FUNCTION [DIPROCOM].[SWIFT_FN_GET_ROUTE_ID_FROM_CODE_ROUTE]
(
	@CODE_ROUTE VARCHAR(50)
)
RETURNS INT
AS
BEGIN
	DECLARE @ROUTE INT
	--
	SELECT @ROUTE = [R].[ROUTE]
	FROM [DIPROCOM].[SWIFT_ROUTES] [R]
	WHERE [R].[CODE_ROUTE] = @CODE_ROUTE
	--
	RETURN @ROUTE
END



