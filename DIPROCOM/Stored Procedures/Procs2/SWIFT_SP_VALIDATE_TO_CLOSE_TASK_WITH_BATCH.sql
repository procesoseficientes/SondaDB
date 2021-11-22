-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	14-01-2016
-- Description:			Validaciones de fin de ruta

/*
-- Ejemplo de Ejecucion:
				exec [PACASA].[SWIFT_SP_VALIDATE_TO_CLOSE_TASK_WITH_BATCH] @TASK_ID = 5219
*/
-- =============================================


CREATE PROCEDURE [PACASA].[SWIFT_SP_VALIDATE_TO_CLOSE_TASK_WITH_BATCH]
	@TASK_ID AS INT
AS
BEGIN 
	SET NOCOUNT ON;
	--
	DECLARE @RESULT INT = 0
	
	SELECT @RESULT = [PACASA].[SWIFT_FN_VALIDATE_COMPLETE_TASK](@TASK_ID)

	IF @RESULT = 1
	BEGIN
		SELECT @RESULT = [PACASA].[SWIFT_FN_VALIDATE_RESULT_SUM_PRODUCT](@TASK_ID)
	END

	SELECT @RESULT AS RESULT
END

