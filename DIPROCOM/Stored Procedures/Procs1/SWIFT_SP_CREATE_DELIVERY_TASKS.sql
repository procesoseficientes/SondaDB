﻿-- =====================================================
-- Author:         diego.as
-- Create date:    30-05-2016
-- Description:    Genera tareas de entrega

--Modificaco:		hector.gonzalez
-- Create date:    17-06-2016
-- Description:    Se agregaron los campos TASK_ID_HH, IN_PLAN_ROUTE y CREATE_BY

--Modificaco:		rudi.garcia
-- Create date:    10-10-2016 @ A-TEAM Sprint 2
-- Description:    Se modifico el select del cursor para que no haga join con la tabla de task y de customer.
--				   
/*
-- EJEMPLO DE EJECUCION: 
		DECLARE @pResult VARCHAR(250) = ''
		--
		EXEC [PACASA].[SWIFT_SP_CREATE_DELIVERY_TASKS]
			@MANIFEST_ID = 69,
			@ASSIGNED_TO = 'RUDI@DIPROCOM',
			@pResult = @pResult OUTPUT
		--
		SELECT @pResult Result
*/
-- =====================================================


CREATE PROC [PACASA].[SWIFT_SP_CREATE_DELIVERY_TASKS]
	@MANIFEST_ID INT = NULL,
	@ASSIGNED_TO VARCHAR(50) = NULL,
	@pResult VARCHAR(250) OUTPUT
AS
	DECLARE @ErrorMessage NVARCHAR(4000);
	DECLARE @ErrorSeverity		INT;
	DECLARE @ErrorState			INT;
	DECLARE @pCLEARANCE_COUNT	INT;
	DECLARE @ORDER_ID			INT;
	
	DECLARE @MANIFEST_DETAIL_ID	INT;
	DECLARE @COSTUMER_CODE		VARCHAR(50); 
	DECLARE @CUSTOMER_PHONE		VARCHAR(50); 
	DECLARE @COSTUMER_NAME		VARCHAR(150);
	DECLARE @CUSTOMER_GPS		VARCHAR(75); 
	DECLARE @ADRESS_CUSTOMER	VARCHAR(250);
	DECLARE @LAST_TASK_ID		INT;

	DECLARE @STARTING_POINT		VARCHAR(100);
	DECLARE @LOGIN_DEFAULT_WAREHOUSE VARCHAR(50);
	DECLARE @KMS_DISTANCE		FLOAT;

	
	BEGIN TRY
	
		--GET THE USER STARTING POINT BASED ON DEFAULT WAREHOUSE
		SELECT @LOGIN_DEFAULT_WAREHOUSE = 	ISNULL((SELECT DEFAULT_WAREHOUSE FROM [PACASA].[USERS]
			WHERE UPPER(LOGIN) = UPPER(@ASSIGNED_TO)),'*')

		IF @LOGIN_DEFAULT_WAREHOUSE = '*' BEGIN
			SELECT @pResult = 'ERROR, OPERADOR ' +UPPER(@ASSIGNED_TO) + ' NO TIENE BODEGA DE SALIDA DEFAULT';
			RETURN -7;
		END

		PRINT 'DEFAULT WAREHOUSE: '+ @LOGIN_DEFAULT_WAREHOUSE;
		
		--GET THE USER STARTING POINT BASED ON DEFAULT WAREHOUSE, OTHERWISE TRY TO GET FROM THE ENTERPRISE VALUE
		SELECT @STARTING_POINT = ISNULL((SELECT GPS_WAREHOUSE FROM [PACASA].SWIFT_WAREHOUSES
				WHERE CODE_WAREHOUSE = @LOGIN_DEFAULT_WAREHOUSE),ISNULL((SELECT TOP 1 DEFAULT_GPS FROM [dbo].[SWIFT_ENTERPRISE]),'*'))

		IF @STARTING_POINT = '*' BEGIN
			SELECT @pResult = 'ERROR, OPERADOR ' +UPPER(@ASSIGNED_TO) + ' NO TIENE PUNTO DE PARTIDA DEFINIDO';
			RETURN -8;
		END
		
		--GET ALL ORDERS ON THE MANIFEST DETAIL

		DECLARE ORDERS_CURSOR CURSOR LOCAL FORWARD_ONLY 
			FOR 
				SELECT 
					MD.[MANIFEST_DETAIL],
					VC.CODE_CUSTOMER COSTUMER_CODE, 
					VC.NAME_CUSTOMER, 
					ISNULL(VC.PHONE_CUSTOMER,'0') AS PHONE_CUSTOMER, 
					ISNULL(VC.GPS, '0,0') AS GPS, 
					ISNULL(VC.ADRESS_CUSTOMER,'SIN DIRECCION') AS ADRESS_CUSTOMER
					
					FROM
            [PACASA].[SWIFT_MANIFEST_DETAIL] MD
            INNER JOIN [PACASA].[SWIFT_VIEW_ALL_COSTUMER] VC  ON(
              VC.CODE_CUSTOMER = MD.CODE_CUSTOMER 
            )
            WHERE MD.CODE_MANIFEST_HEADER = @MANIFEST_ID

		OPEN ORDERS_CURSOR
		FETCH NEXT FROM ORDERS_CURSOR
		INTO @MANIFEST_DETAIL_ID, @COSTUMER_CODE, @COSTUMER_NAME, @CUSTOMER_PHONE, @CUSTOMER_GPS, @ADRESS_CUSTOMER;
		
		BEGIN TRAN

		WHILE @@FETCH_STATUS = 0
			BEGIN

			print '@STARTING_POINT: ' + cast(isnull(@STARTING_POINT,'sin valor') as varchar)
			print '@CUSTOMER_GPS: ' + cast(isnull(@CUSTOMER_GPS,'sin valor') as varchar)
			
			SELECT @KMS_DISTANCE = dbo.[SONDA_FN_CALCULATE_DISTANCE](@STARTING_POINT,@CUSTOMER_GPS)

				INSERT INTO [PACASA].[SWIFT_TASKS]
				   ([TASK_TYPE]
				   ,[TASK_DATE]
				   ,[SCHEDULE_FOR]
				   ,[CREATED_STAMP]
				   ,[ASSIGEND_TO]
				   ,[ASSIGNED_BY]
				   ,[ASSIGNED_STAMP]
				   ,[CANCELED_STAMP]
				   ,[CANCELED_BY]
				   ,[ACCEPTED_STAMP]
				   ,[COMPLETED_STAMP]
				   ,[RELATED_PROVIDER_CODE]
				   ,[RELATED_PROVIDER_NAME]
				   ,[EXPECTED_GPS]
				   ,[POSTED_GPS]
				   ,[TASK_STATUS]
				   ,[TASK_COMMENTS]
				   ,[TASK_SEQ]
				   ,[REFERENCE]
				   ,[SAP_REFERENCE]
				   ,[COSTUMER_CODE]
				   ,[COSTUMER_NAME]
				   ,[RECEPTION_NUMBER]
				   ,[PICKING_NUMBER]
				   ,[COUNT_ID]
				   ,[ACTION]
				   ,[SCANNING_STATUS]
				   ,[ALLOW_STORAGE_ON_DIFF]
				   ,[CUSTOMER_PHONE]
				   ,[TASK_ADDRESS]
				   ,[VISIT_HOUR]
				   ,[ROUTE_IS_COMPLETED]
				   ,[EMAIL_TO_CONFIRM]
				   ,[DISTANCE_IN_KMS]
				   ,[IN_PLAN_ROUTE]
				   ,[CREATE_BY])
			 VALUES
				   ('DELIVERY'
				   ,CURRENT_TIMESTAMP
				   ,CURRENT_TIMESTAMP
				   ,CURRENT_TIMESTAMP
				   ,@ASSIGNED_TO
				   ,@ASSIGNED_TO
				   ,CURRENT_TIMESTAMP
				   ,NULL
				   ,NULL
				   ,NULL
				   ,NULL
				   ,NULL
				   ,NULL
				   ,@CUSTOMER_GPS
				   ,NULL
				   ,'ASSIGNED'
				   ,('MANIFIESTO ' + CONVERT(VARCHAR(250),@MANIFEST_ID) + ' KMS DE DISTANCIA: ' + CONVERT(VARCHAR(250),@KMS_DISTANCE))
				   ,0
				   ,CONVERT(VARCHAR(250), @MANIFEST_ID) --USE MANIFEST ID AS REFERENCE
				   ,NULL
				   ,@COSTUMER_CODE
				   ,@COSTUMER_NAME
				   ,NULL
				   ,NULL
				   ,NULL
				   ,'ACTIVE'
				   ,NULL
				   ,NULL
				   ,@CUSTOMER_PHONE
				   ,@ADRESS_CUSTOMER
				   ,NULL
				   ,0
				   ,NULL
				   ,@KMS_DISTANCE
				   ,0
				   ,'BY_USER');
				   
				   SELECT @LAST_TASK_ID =  SCOPE_IDENTITY();
				  
				  UPDATE [PACASA].SWIFT_TASKS 
					SET TASK_ID_HH = @LAST_TASK_ID 
					WHERE TASK_ID = @LAST_TASK_ID

				   --ON THIS CLAUSE, WE WILL CHAIN THE MANIFEST DETAIL WITH THE TASK TABLE IN ORDER TO KEEP BOTH UPDATE ON ROUTE
				   UPDATE 
					[PACASA].SWIFT_MANIFEST_DETAIL SET DELIVERY_TASK = @LAST_TASK_ID
					WHERE  [CODE_MANIFEST_HEADER] = @MANIFEST_ID AND 
					[MANIFEST_DETAIL] = @MANIFEST_DETAIL_ID

				FETCH NEXT FROM ORDERS_CURSOR
				INTO @MANIFEST_DETAIL_ID, @COSTUMER_CODE, @COSTUMER_NAME, @CUSTOMER_PHONE, @CUSTOMER_GPS, @ADRESS_CUSTOMER;

			END

		CLOSE ORDERS_CURSOR;
		DEALLOCATE ORDERS_CURSOR;

		DECLARE @CURSOR_TASK_ID INT;
		DECLARE @CURSOR_SEQ INT;
		SELECT @CURSOR_SEQ = 0;

		DECLARE TASKS_CURSOR CURSOR LOCAL FORWARD_ONLY 
			FOR 
				SELECT TASK_ID FROM [PACASA].SWIFT_TASKS 
				WHERE REFERENCE = CONVERT(VARCHAR(250),@MANIFEST_ID)
				ORDER BY DISTANCE_IN_KMS ASC

		OPEN TASKS_CURSOR
		FETCH NEXT FROM TASKS_CURSOR
		INTO @CURSOR_TASK_ID;
		
		WHILE @@FETCH_STATUS = 0
			BEGIN

				SELECT @CURSOR_SEQ = @CURSOR_SEQ + 1;

				UPDATE [PACASA].SWIFT_TASKS SET TASK_SEQ = @CURSOR_SEQ
				WHERE TASK_ID = @CURSOR_TASK_ID

				FETCH NEXT FROM TASKS_CURSOR
				INTO @CURSOR_TASK_ID;

			END
			
		CLOSE TASKS_CURSOR;
		DEALLOCATE TASKS_CURSOR;

		UPDATE [PACASA].[SWIFT_MANIFEST_HEADER] SET STATUS = 'ACCEPTED', 
		[ACCEPTED_STAMP] = CURRENT_TIMESTAMP WHERE [MANIFEST_HEADER] = @MANIFEST_ID

		COMMIT TRAN

		SELECT @pResult = 'OK'
		RETURN 0

	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		SELECT	@pResult = ERROR_MESSAGE();
		RETURN -1;
	END CATCH	


