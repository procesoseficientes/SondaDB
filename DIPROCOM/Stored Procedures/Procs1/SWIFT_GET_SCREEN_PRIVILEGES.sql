-- =============================================
-- Autor:				        rudi.garcia
-- Fecha de Creacion: 	2017-01-13 @ RebornTeam Sprint Anpassung
-- Description:			    SP que obtiene los privilegios de la pantalla

/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].[SWIFT_GET_SCREEN_PRIVILEGES]
					@USER_LOGGED = 'gerente@DIPROCOM'
          ,@PARENT_PRIVILEGE_ID = 'btnBonusForPromo'
*/
-- =============================================

CREATE PROCEDURE [PACASA].[SWIFT_GET_SCREEN_PRIVILEGES] (@USER_LOGGED VARCHAR(50)
, @PARENT_PRIVILEGE_ID VARCHAR(50))
AS

	SELECT
		[P].[ID]
		,[P].[PRIVILEGE_ID]
		,[P].[PARENT_ID]
		,[P].[NAME]
		,[P].[PRIVILEGE_TYPE]
		,[P].[DISPLAY_NAME]
		,[P].[IMAGE_URL]
		,[P].[DESCRIPTION]
		,[P].[ACTIVE]
	FROM
		[PACASA].[USERS] [U]
	INNER JOIN [PACASA].[SWIFT_ROLE] [R] ON ([R].[ROLE_ID] = [U].[USER_ROLE])
	INNER JOIN [PACASA].[SWIFT_PRIVILEGES_X_ROLE] [PR] ON ([R].[ROLE_ID] = [PR].[ROLE_ID])
	INNER JOIN [PACASA].[SWIFT_PRIVILEGES] [P] ON (
											[PR].[PRIVILEGE_ID] = [P].[ID]
											)
	WHERE
		[U].[LOGIN] = @USER_LOGGED
		AND [P].[PARENT_ID] = @PARENT_PRIVILEGE_ID
		AND [P].[PRIVILEGE_TYPE] = CAST('BO' AS VARCHAR(50)) 
		AND [P].[ACCESS] = CAST('PUBLIC' AS VARCHAR(50))
		AND [P].[IS_SCREEN] = 0
	ORDER BY
		[P].[DISPLAY_NAME];
