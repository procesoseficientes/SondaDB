﻿
CREATE PROCEDURE [SONDA].[SWIFT_SP_PROCESS_FINISH_PICKING]
@pTASK_ID	INT,
@pLOGIN_ID	VARCHAR(50),
@pResult varchar(250) OUTPUT
AS
	
	DECLARE @ErrorMessage NVARCHAR(4000);
	DECLARE @ErrorSeverity INT;
	DECLARE @ErrorState INT;
	DECLARE @pAllocated INT;
	DECLARE @pScanned INT;

		BEGIN TRY

			
			UPDATE SWIFT_TASKS set SCANNING_STATUS = 'COMPLETED', TASK_STATUS = 'COMPLETED', COMPLETED_STAMP = CURRENT_TIMESTAMP,
			[ACTION] = 'COMPLETED' WHERE TASK_ID = @pTASK_ID
			
			IF @@ROWCOUNT <> 1 BEGIN
				SELECT	@pResult	= 'ERROR, no se pudo actualizar la tarea';
				RETURN -8
			END
			
			UPDATE SWIFT_PICKING_HEADER SET STATUS = 'COMPLETED', LAST_UPDATE = CURRENT_TIMESTAMP 
			WHERE PICKING_HEADER = (SELECT PICKING_NUMBER FROM SWIFT_TASKS WHERE TASK_ID = @pTASK_ID)

			IF @@ROWCOUNT <> 1 BEGIN
				SELECT	@pResult	= 'ERROR, no se pudo actualizar encabezado de picking';
				RETURN -9
			END
			
			SELECT	@pResult	= 'OK';
			RETURN 0
			
		END TRY
		BEGIN CATCH
			SELECT	@pResult	= ERROR_MESSAGE()
			RETURN -10
		END CATCH










