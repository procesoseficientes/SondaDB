-- =============================================
-- Autor:				        hector.gonzalez
-- Fecha de Creacion: 	10-10-2016
-- Description:			    Modifica una tarea a aceptada

/*
	Ejemplo Ejecucion: 
    EXEC	[PACASA].SONDA_SP_UPDATE_TASK_ACCEPTED
		@TASK_ID = 7707		
		
 */
-- =============================================
CREATE PROCEDURE [PACASA].SONDA_SP_UPDATE_TASK_ACCEPTED
	@TASK_ID VARCHAR(25)
AS
BEGIN
	
	--
	UPDATE [PACASA].SWIFT_TASKS
  SET 
    TASK_STATUS = 'ACCEPTED'
   ,ACCEPTED_STAMP = GETDATE()
  WHERE TASK_ID = @TASK_ID;


END
