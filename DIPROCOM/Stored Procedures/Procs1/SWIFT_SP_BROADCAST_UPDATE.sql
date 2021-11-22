-- =============================================
-- Autor:				alberto.ruiz	
-- Fecha de Creacion: 	03-12-2015
-- Description:			Se actualiza el estado del broadcast de un destinatario

/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].[SWIFT_SP_BROADCAST_UPDATE] @CODE_BROADCAST = '',@ADDRESSEE = '' ,@STATUS = 'RECEIVED'
				--
				SELECT * FROM [PACASA].[SWIFT_PENDING_BROADCAST]
				--
				SELECT * FROM [PACASA].[SWIFT_ROUTES] WHERE IS_ACTIVE_ROUTE = 1
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_BROADCAST_UPDATE]
	@CODE_BROADCAST VARCHAR(150)
	,@ADDRESSEE VARCHAR(50)
	,@STATUS VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
    --
	UPDATE [PACASA].[SWIFT_PENDING_BROADCAST]
	SET STATUS = @STATUS
	WHERE CODE_BROADCAST = @CODE_BROADCAST
		AND ADDRESS = @ADDRESSEE

END


