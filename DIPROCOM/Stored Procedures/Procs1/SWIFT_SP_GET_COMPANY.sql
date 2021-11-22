-- =============================================
-- Autor:				rodrigo.gomez
-- Fecha de Creacion: 	4/21/2017 @ A-TEAM Sprint Hondo 
-- Description:			Obtiene una o todas las compañias

/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].[SWIFT_SP_GET_COMPANY]
					@COMPANY_ID = 1
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_COMPANY](
	@COMPANY_ID INT = NULL
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT [COMPANY_ID]
			,[COMPANY_NAME] 
	FROM [PACASA].[SWIFT_COMPANY]
		WHERE @COMPANY_ID IS NULL OR @COMPANY_ID = [COMPANY_ID]
END



