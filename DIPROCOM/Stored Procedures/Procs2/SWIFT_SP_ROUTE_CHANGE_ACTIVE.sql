-- =============================================
-- Autor:				alberto.ruiz	
-- Fecha de Creacion: 	03-12-2015
-- Description:			Actualiza el si es activa o no la ruta

/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].[SWIFT_SP_ROUTE_CHANGE_ACTIVE] @CODE_ROUTE = 'ALBERTO@DIPROCOM' ,@IS_ACTIVE_ROUTE = 1
				--
				EXEC [PACASA].[SWIFT_SP_ROUTE_CHANGE_ACTIVE] @CODE_ROUTE = 'ALBERTO@DIPROCOM' ,@IS_ACTIVE_ROUTE = 0
				--
				SELECT * FROM [PACASA].[SWIFT_ROUTES] WHERE CODE_ROUTE = 'ALBERTO@DIPROCOM'
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_ROUTE_CHANGE_ACTIVE]
	@CODE_ROUTE VARCHAR(50)
	,@IS_ACTIVE_ROUTE INT
AS
BEGIN
	SET NOCOUNT ON;
    --
	UPDATE [PACASA].[SWIFT_ROUTES]
	SET IS_ACTIVE_ROUTE = @IS_ACTIVE_ROUTE
	WHERE CODE_ROUTE = @CODE_ROUTE
END


