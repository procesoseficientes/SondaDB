﻿

CREATE PROCEDURE [acsa].[SONDA_SP_FINISH_ROUTE] 
	@pPOS_ID	varchar(25),
	@pLOGIN_ID	varchar(25),
	@pLAST_INVOICE INT,
	
	@pResult varchar(250) OUTPUT
AS

	DECLARE @ErrorMessage NVARCHAR(4000);
	DECLARE @ErrorSeverity INT;
	DECLARE @ErrorState INT;
	DECLARE @pCLEARANCE_COUNT INT;
	
		BEGIN TRY
			
			UPDATE [acsa].SONDA_POS_INVOICE_HEADER 
			SET STATUS = 5, CLOSED_ROUTE_DATETIME = CURRENT_TIMESTAMP
			WHERE STATUS = 1 AND POS_TERMINAL = @pPOS_ID --MEANS ROUTE ID
			AND STATUS <> 3 AND IS_CREDIT_NOTE = 0 -- MEANS A VALID INVOICE
			
			UPDATE  [acsa].SONDA_POS_RES_SAT
			SET AUTH_CURRENT_DOC = @pLAST_INVOICE
			WHERE AUTH_ASSIGNED_TO = @pPOS_ID
			
			UPDATE [acsa].SONDA_DEPOSITS SET STATUS = 5 WHERE STATUS = 1 AND POS_TERMINAL = @pPOS_ID
			
			SELECT @pCLEARANCE_COUNT = ISNULL((SELECT COUNT(1) FROM [acsa].SONDA_CLEARANCES WHERE POS_ID = @pPOS_ID AND STATUS = 0),0)
			
			IF(@pCLEARANCE_COUNT <=0) BEGIN
				INSERT INTO [SWIFT_EXPRESS].[acsa].[SONDA_CLEARANCES]
				   ([POS_ID]
				   ,[STATUS]
				   ,[SOLD]
				   ,[DEPOSIT]
				   ,[RETURNED]
				   ,[COMMENTS]
				   ,[LAST_UPDATED]
				   ,[LAST_UPDATED_BY]
				   ,[CREATED_BY])
			 VALUES
				   (@pPOS_ID
				   ,0
				   ,ISNULL((SELECT SUM(TOTAL_AMOUNT)	FROM [acsa].SONDA_POS_INVOICE_HEADER	WHERE POS_TERMINAL = @pPOS_ID AND STATUS = 5),0)
				   ,ISNULL((SELECT SUM(AMOUNT)			FROM [acsa].SONDA_DEPOSITS				WHERE POS_TERMINAL = @pPOS_ID AND STATUS = 5),0)
				   ,0
				   ,NULL
				   ,CURRENT_TIMESTAMP
				   ,@pLOGIN_ID
				   ,CURRENT_TIMESTAMP)

			END
			SELECT	@pResult	= 'OK'
				
		END TRY
		BEGIN CATCH
			SELECT	@pResult	= ERROR_MESSAGE()
		END CATCH





