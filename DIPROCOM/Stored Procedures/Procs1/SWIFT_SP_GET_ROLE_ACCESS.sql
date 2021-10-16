-- =============================================
-- Autor:				Yaqueline Canahui
-- Fecha de Creacion: 	09-Aug-2018 @ G-FORCE Sprint Hormiga
-- Description:			SP que obtiene accesos para permisos a roles.

/*
-- Ejemplo de Ejecucion:
				EXEC [DIPROCOM].[SWIFT_SP_GET_ROLE]
				--
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_ROLE_ACCESS]
(@LOGIN_ID VARCHAR(50),@PRIVILEGE_ID VARCHAR(50))
AS
BEGIN

	SELECT COUNT(1) TIENE_ACCESO FROM DIPROCOM.SWIFT_PRIVILEGES A
	INNER JOIN DIPROCOM.SWIFT_PRIVILEGES_X_ROLE B
	ON A.ID=B.PRIVILEGE_ID
	INNER JOIN DIPROCOM.USERS C
	ON b.ROLE_ID = C.USER_ROLE
	WHERE A.PRIVILEGE_ID = @PRIVILEGE_ID
	AND C.LOGIN=@LOGIN_ID

END