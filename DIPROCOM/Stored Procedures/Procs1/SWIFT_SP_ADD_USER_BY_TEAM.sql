-- =============================================
-- Autor:				rudi.garcia
-- Fecha de Creacion: 	26-JUN-2018 @ G-FORCE Sprint Elefante
-- Description:			Sp que agrega los usuarios al equipo

/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].[SWIFT_SP_ADD_USER_BY_TEAM]
					  @TEAM_ID = 1          
				-- 
				SELECT * FROM [PACASA].[SWIFT_TEAM]
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_ADD_USER_BY_TEAM] (
		@TEAM_ID INT
		,@XML XML
		,@LOGIN_ID VARCHAR(50)
	)
AS
BEGIN
	BEGIN TRY
    --
		DECLARE	@USERS TABLE (
				[CORRELATIVE] INT
				,[LOGIN] VARCHAR(50)
			);
    --
		INSERT	INTO @USERS
				(
					[CORRELATIVE]
					,[LOGIN]
				)
		SELECT
			[x].[Rec].[query]('./CORRELATIVE').[value]('.', 'int')
			,[x].[Rec].[query]('./LOGIN').[value]('.', 'varchar(50)')
		FROM
			@XML.[nodes]('ArrayOfUsuario/Usuario') AS [x] ([Rec]);

		IF EXISTS ( SELECT TOP 1
						1
					FROM
						@USERS [U]
					JOIN [PACASA].[SWIFT_TEAM] [UT] ON [U].[CORRELATIVE] = [UT].[SUPERVISOR] )
		BEGIN
			SELECT
				-1 AS [Resultado]
				,'No se puede agregar el usuario asignado como supervisor al listado de usuarios para el equipo de ventas' AS [Mensaje]
				,00 AS [Codigo];
			RETURN;
		END;

		INSERT	INTO [PACASA].[SWIFT_USER_BY_TEAM]
				(
					[TEAM_ID]
					,[USER_ID]
				)
		SELECT
			@TEAM_ID
			,[CORRELATIVE]
		FROM
			@USERS;

    --
		SELECT
			1 AS [Resultado]
			,'Proceso Exitoso' [Mensaje]
			,0 [Codigo]
			,CAST(@TEAM_ID AS VARCHAR) [DbData];
	END TRY
	BEGIN CATCH
		SELECT
			-1 AS [Resultado]
			,CASE CAST(@@ERROR AS VARCHAR)
				WHEN '2627'
				THEN 'Error: Ya existe el equipo'
				ELSE ERROR_MESSAGE()
				END [Mensaje]
			,@@ERROR [Codigo];
	END CATCH;
END;