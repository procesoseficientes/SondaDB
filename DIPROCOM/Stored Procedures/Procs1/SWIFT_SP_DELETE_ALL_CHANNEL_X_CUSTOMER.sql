-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	09-09-2016 @ A-TEAM Sprint 1
-- Description:			SP que elimina todos los clientes del canal

/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].SWIFT_SP_DELETE_ALL_CHANNEL_X_CUSTOMER
					@CHANNEL_ID = 1
				-- 
				SELECT * FROM [PACASA].SWIFT_CHANNEL_X_CUSTOMER
*/
-- =============================================
CREATE PROCEDURE [PACASA].SWIFT_SP_DELETE_ALL_CHANNEL_X_CUSTOMER(
	@CHANNEL_ID INT
)
AS
BEGIN
	BEGIN TRY
		DELETE FROM [PACASA].SWIFT_CHANNEL_X_CUSTOMER
		WHERE CHANNEL_ID = @CHANNEL_ID
		--
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo, '0' DbData
	END TRY
	BEGIN CATCH
		SELECT  -1 as Resultado
		,ERROR_MESSAGE() Mensaje 
		,@@ERROR Codigo 
	END CATCH
END
