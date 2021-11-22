﻿CREATE PROC [PACASA].[SWIFT_SP_INSERT_COUNT_HEADER]
@COUNT_TYPE VARCHAR(20),
@COUNT_NAME VARCHAR(50),
@COUNT_ASSIGNED_TO VARCHAR(50),
@ASSIGNED_BY VARCHAR(150),
@SEQ INT
AS
declare @headerid int
declare @table TABLE(ID INT)

BEGIN
	INSERT into [PACASA].SWIFT_CYCLE_COUNT_HEADER(COUNT_TYPE,COUNT_ASSIGNED_DATE,COUNT_ASSIGNED_TO,COUNT_NAME,COUNT_STATUS,COUNT_RESULT,SEQ)
	VALUES (@COUNT_TYPE,GETDATE(),@COUNT_ASSIGNED_TO,@COUNT_NAME,'ASSIGNED',0,@SEQ)
END

BEGIN
	SELECT @headerid = scope_identity() FROM [PACASA].SWIFT_CYCLE_COUNT_HEADER
	INSERT INTO @table (ID) VALUES (@headerid)
	SELECT * FROM @table
	INSERT INTO [PACASA].SWIFT_TASKS (TASK_TYPE,TASK_DATE,SCHEDULE_FOR,CREATED_STAMP,ASSIGEND_TO,ASSIGNED_BY,ASSIGNED_STAMP,COUNT_ID,ACTION,TASK_COMMENTS,COSTUMER_NAME,TASK_SEQ,TASK_STATUS,SCANNING_STATUS)
	VALUES ('COUNT',GETDATE(),GETDATE(),GETDATE(),@COUNT_ASSIGNED_TO,@ASSIGNED_BY,GETDATE(),@headerid,'PLAY','Conteo Fisico',@COUNT_NAME,@SEQ,'ASSIGNED','PENDING')
END





