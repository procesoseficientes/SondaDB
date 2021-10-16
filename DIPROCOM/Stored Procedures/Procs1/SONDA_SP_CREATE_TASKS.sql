﻿CREATE PROC [SONDA].[SONDA_SP_CREATE_TASKS]
	 @DOC_NUM INT = NULL
	,@CUSTOMER_CODE VARCHAR(25)
	,@CUSTOMER_NAME VARCHAR(250)
	,@CUSTOMER_PHONE VARCHAR(50)
	,@TASK_ADDRESS VARCHAR(250)
	,@ASSIGNED_TO VARCHAR(25)
	,@TASK_SEQ INT = NULL
	,@TASK_COMMENTS VARCHAR(150)
	,@TASK_TYPE VARCHAR(15)
	,@CREATED_STAMP DATETIME = NULL
	,@pResult VARCHAR(250) OUTPUT
AS
BEGIN TRAN t1
		BEGIN	
		INSERT INTO [SONDA].SWIFT_TASKS (
			PICKING_NUMBER,
			COSTUMER_CODE,
			COSTUMER_NAME,
			CUSTOMER_PHONE,
			SCHEDULE_FOR,
			TASK_ADDRESS,
			ASSIGEND_TO,
			TASK_STATUS,
			TASK_SEQ,
			TASK_COMMENTS,
			TASK_TYPE,
			CREATED_STAMP,
			ASSIGNED_STAMP,
			TASK_DATE,
			ASSIGNED_BY,
			[ACTION],
			ROUTE_IS_COMPLETED)
		VALUES(
			 @DOC_NUM
			,@CUSTOMER_CODE
			,@CUSTOMER_NAME
			,@CUSTOMER_PHONE
			,CURRENT_TIMESTAMP
			,@TASK_ADDRESS
			,@ASSIGNED_TO
			,'ASSIGNED'
			,@TASK_SEQ
			,@TASK_COMMENTS
			,@TASK_TYPE
			,@CREATED_STAMP
			,CURRENT_TIMESTAMP
			,CURRENT_TIMESTAMP
			,@ASSIGNED_TO
			,'PLAY'
			,0)
END	
IF @@error = 0 BEGIN
	SELECT @pResult = 'OK'
	COMMIT TRAN t1
END		
ELSE BEGIN
	ROLLBACK TRAN t1
	SELECT	@pResult	= ERROR_MESSAGE()
END



