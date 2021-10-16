-- =============================================
-- Autor:				rudi.garcia
-- Fecha de Creacion: 	26-JUN-2018 @ G-FORCE Sprint Elefante
-- Description:			Sp que agrega el encabezado del equipo

/*
-- Ejemplo de Ejecucion:
				EXEC [DIPROCOM].[SWIFT_SP_GET_USER_FOR_TEAM_AVAILABLE] @TEAM_ID = 2
				--
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_USER_FOR_TEAM_AVAILABLE] (@TEAM_ID INT)
AS
BEGIN

	SELECT
		[U].[CORRELATIVE]
		,[U].[LOGIN]
		,[U].[NAME_USER]
	FROM
		[DIPROCOM].[USERS] [U]
	LEFT JOIN [DIPROCOM].[SWIFT_USER_BY_TEAM] [UT] ON (
											[UT].[USER_ID] = [U].[CORRELATIVE]
											AND [UT].[TEAM_ID] = @TEAM_ID
											)
	WHERE
		[UT].[USER_ID] IS NULL
		AND NOT EXISTS ( SELECT
								1
							FROM
								[DIPROCOM].[SWIFT_TEAM] [ST]
							WHERE
								[ST].[SUPERVISOR] = [U].[CORRELATIVE] );
END;