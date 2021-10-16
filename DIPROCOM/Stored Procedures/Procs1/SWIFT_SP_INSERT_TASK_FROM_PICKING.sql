﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	06-04-2016
-- Description:			Crear una tarea del numero de picking

/*
-- Ejemplo de Ejecucion:
        USE SWIFT_EXPRESS
        GO
        --
        EXEC [DIPROCOM].[SWIFT_SP_INSERT_TASK_FROM_PICKING]
			@PICKING_HEADER = 627
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_INSERT_TASK_FROM_PICKING] (
	@PICKING_HEADER INT
)
AS
BEGIN
	BEGIN TRY
		DECLARE @ID INT
		--
		INSERT INTO DIPROCOM.SWIFT_TASKS (
			TASK_TYPE
			,TASK_DATE
			,SCHEDULE_FOR
			,CREATED_STAMP
			,ASSIGEND_TO
			,ASSIGNED_BY
			,ASSIGNED_STAMP
			,RELATED_PROVIDER_CODE
			,RELATED_PROVIDER_NAME
			,EXPECTED_GPS
			,TASK_STATUS
			,TASK_COMMENTS
			,TASK_SEQ
			,REFERENCE
			,SAP_REFERENCE
			,COSTUMER_CODE
			,COSTUMER_NAME
			,PICKING_NUMBER
			,ACTION
			,SCANNING_STATUS
			,CUSTOMER_PHONE
			,TASK_ADDRESS
		)
		SELECT TOP 1
			'PICKING'
			,P.SCHEDULE_FOR
			,P.SCHEDULE_FOR
			,GETDATE()
			,P.CODE_USER
			,P.LAST_UPDATE_BY
			,GETDATE()
			,P.CODE_CLIENT
			,C.NAME_CUSTOMER
			,C.GPS
			,'ASSIGNED'
			,P.COMMENTS
			,P.SEQ
			,P.REFERENCE
			,P.DOC_SAP_RECEPTION
			,P.CODE_CLIENT
			,C.NAME_CUSTOMER
			,P.PICKING_HEADER			
			,'PLAY'
			,'PENDING'
			,C.PHONE_CUSTOMER
			,C.ADRESS_CUSTOMER
		FROM DIPROCOM.[SWIFT_PICKING_HEADER] P
		INNER JOIN [DIPROCOM].[SWIFT_VIEW_ALL_COSTUMER] C ON (P.CODE_CLIENT = C.CODE_CUSTOMER)
		WHERE P.PICKING_HEADER = @PICKING_HEADER
		--	   
		SELECT @ID = SCOPE_IDENTITY()
		--
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo, CONVERT(VARCHAR(16), @ID) DbData
	END TRY
	BEGIN CATCH     
		 SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo 
	END CATCH
END



