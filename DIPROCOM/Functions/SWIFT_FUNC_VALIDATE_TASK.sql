/*
	-- =============================================
-- Autor:				jose.garcia
-- Fecha de Creacion: 	13-01-2016
-- Description:			Función que valida que el pallet exista
--						y que el producto coresponda a la tarea
						--
-- Ejemplo de Ejecucion:	
						SELECT [PACASA].[SWIFT_FUNC_VALIDATE_TASK]('5219','20GM')
						--						--
-- =============================================
*/
CREATE FUNCTION [PACASA].[SWIFT_FUNC_VALIDATE_TASK]
( 
	@TASK_ID INT
	,@SKU VARCHAR(50)
)
RETURNS BIT
	AS
BEGIN
	DECLARE @RESULT BIT = 0
	--
	SELECT TOP 1 @RESULT = 1  
	FROM [PACASA].[SWIFT_PALLET] TP
	INNER JOIN [PACASA].[SWIFT_BATCH] TB ON (TP.TASK_ID = TB.TASK_ID)
	WHERE TB.TASK_ID =@TASK_ID
	AND TB.SKU=@SKU
	--
	RETURN @RESULT
 END;

