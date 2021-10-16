﻿CREATE PROC [SONDA].[SWIFT_SP_DELETE_TASK_AND_PICKING_AND_RECEPTION]
@TASK_ID INT
AS
DECLARE @TYPE VARCHAR(50)
DECLARE @ACTION VARCHAR(50)
SET @TYPE = ( SELECT TASK_TYPE FROM [SONDA].SWIFT_TASKS  WHERE TASK_ID= @TASK_ID)
SET @ACTION = ( SELECT [ACTION] FROM [SONDA].SWIFT_TASKS  WHERE TASK_ID= @TASK_ID)
PRINT @ACTION

IF (@TYPE = 'PICKING' AND @ACTION != 'CLOSED' AND @ACTION != 'COMPLETED')
BEGIN
DELETE FROM [SONDA].SWIFT_PICKING_HEADER WHERE PICKING_HEADER = (SELECT PICKING_NUMBER FROM [SONDA].SWIFT_TASKS WHERE TASK_ID = @TASK_ID)
DELETE FROM [SONDA].SWIFT_PICKING_DETAIL WHERE PICKING_HEADER = (SELECT PICKING_NUMBER FROM [SONDA].SWIFT_TASKS WHERE TASK_ID = @TASK_ID)
END
IF (@TYPE = 'RECEPTION' AND @ACTION != 'CLOSED' AND @ACTION != 'COMPLETED')
BEGIN
DELETE FROM [SONDA].SWIFT_RECEPTION_HEADER WHERE RECEPTION_HEADER = (SELECT RECEPTION_NUMBER FROM [SONDA].SWIFT_TASKS WHERE TASK_ID = @TASK_ID)
DELETE FROM [SONDA].SWIFT_RECEPTION_DETAIL WHERE RECEPTION_HEADER = (SELECT RECEPTION_NUMBER FROM [SONDA].SWIFT_TASKS WHERE TASK_ID = @TASK_ID)
END

DELETE FROM [SONDA].SWIFT_TASKS 
WHERE TASK_ID = @TASK_ID AND [TASK_STATUS] != 'CLOSED' AND [TASK_STATUS] != 'COMPLETED' AND [ACTION] != 'CLOSED' AND [ACTION] != 'COMPLETED'



