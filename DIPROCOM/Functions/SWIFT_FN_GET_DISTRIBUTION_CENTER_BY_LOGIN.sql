﻿-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		09-May-17 @ A-Team Sprint Issa 
-- Description:			    Funcion que obtiene el ID del centro de distribucion asociado al usuario

/*
-- Ejemplo de Ejecucion:
        SELECT [DIPROCOM].[SWIFT_FN_GET_DISTRIBUTION_CENTER_BY_LOGIN]('ALBERTO@DIPROCOM')
*/
-- =============================================
CREATE FUNCTION [DIPROCOM].[SWIFT_FN_GET_DISTRIBUTION_CENTER_BY_LOGIN]
(
	@LOGIN VARCHAR(50)
)
RETURNS INT
AS
BEGIN
	DECLARE @DISTRIBUTION_CENTER_ID INT
	--
	SELECT @DISTRIBUTION_CENTER_ID = [U].[DISTRIBUTION_CENTER_ID]
	FROM [DIPROCOM].[USERS] [U]
	WHERE [U].[LOGIN] = @LOGIN
	--
	RETURN @DISTRIBUTION_CENTER_ID
END


