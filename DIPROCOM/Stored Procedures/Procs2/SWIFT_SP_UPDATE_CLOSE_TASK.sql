
-- =============================================
-- Autor:				ppablo.loukota
-- Fecha de Creacion: 	09-01-2016
-- Description:			Valida el cierre de los batchs

/*
-- Ejemplo de Ejecucion:				
				--
EXECUTE  [PACASA].[SWIFT_SP_UPDATE_CLOSE_TASK] 
   @TASK_ID = 2

				--				
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_UPDATE_CLOSE_TASK]
	 @TASK_ID AS INT

AS
BEGIN 

	SET NOCOUNT ON;
      
UPDATE [PACASA].[SWIFT_TASKS]
   SET 
      [TASK_STATUS] = 'CLOSED'
   WHERE [TASK_ID] = @TASK_ID

END








