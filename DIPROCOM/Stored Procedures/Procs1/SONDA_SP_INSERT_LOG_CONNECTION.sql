-- =============================================
-- Autor:				diego.as
-- Fecha de Creacion: 	6/2/2017 @ A-TEAM Sprint Jibade 
-- Description:			Inserta el log de conexiones del usuario

/*
-- Ejemplo de Ejecucion:
		EXEC [PACASA].[SONDA_SP_INSERT_LOG_CONNECTION]
		@LOGIN_USER = 'prueba'
		, @ROUTE_USER = 'prueba@DIPROCOM'
		, @DEVICE_USER = 'e39cbcecbc62d5d6'
		, @MESSAGE = 'Prueba mensaje'
		-----
		SELECT * FROM [PACASA].SONDA_HISTORY_CONNECTION_OF_USER
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SONDA_SP_INSERT_LOG_CONNECTION](
	 @LOGIN_USER VARCHAR(250)
	, @ROUTE_USER VARCHAR(250)
	, @DEVICE_USER VARCHAR(250)
	, @MESSAGE VARCHAR(250)
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	INSERT INTO [PACASA].[SONDA_HISTORY_CONNECTION_OF_USER]
			(
				[LOGIN_USER]
				,[ROUTE_USER]
				,[DEVICE_USER]
				,[LAST_UPDATE]
				,[MESSAGE]
			)
	VALUES
			(
				@LOGIN_USER  -- LOGIN_USER - varchar(250)
				,@ROUTE_USER  -- ROUTE_USER - varchar(250)
				,@DEVICE_USER  -- DEVICE_USER - varchar(250)
				,GETDATE()  -- LAST_UPDATE - datetime
				,@MESSAGE -- MESSAGE - varchar(250)
			)
	--
END
