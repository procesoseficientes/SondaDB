-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	14-09-2016 @ A-TEAM Sprint 1
-- Description:			Funcion que obtiene el vendedor de la ruta

/*
-- Ejemplo de Ejecucion:
				-- 
				SELECT [DIPROCOM].SWIFT_FN_GET_SELLER_BY_ROUTE('RUDI@DIPROCOM')
*/
-- =============================================
CREATE FUNCTION [DIPROCOM].SWIFT_FN_GET_SELLER_BY_ROUTE
(
	@CODE_ROUTE VARCHAR(50)
)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @SELLER_CODE VARCHAR(50) = NULL
	--
	SELECT TOP 1 @SELLER_CODE = RELATED_SELLER
	FROM [DIPROCOM].USERS
	WHERE SELLER_ROUTE = @CODE_ROUTE
	--
	RETURN @SELLER_CODE

END
