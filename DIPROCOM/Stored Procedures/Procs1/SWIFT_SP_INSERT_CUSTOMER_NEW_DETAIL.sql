﻿
-- =============================================
-- Autor:				ppablo.loukota	
-- Fecha de Creacion: 	09-12-2015
-- Description:			Inserta todos los departamentos

-- Modificacion: 05-07-2016
-- Autor: diego.as
-- Descripcion: Se modifico para que verifique si el cliente existe 
--				y si existe que solo actualice los datos del mismo
--				de lo contrario, que los inserte.

/*
-- Ejemplo de Ejecucion:
				

	EXECUTE [SONDA].[SWIFT_SP_INSERT_CUSTOMER_NEW_DETAIL] 
		@CUSTOMER = '2230'
	   ,@CODE_CUSTOMER = ''
	   ,@SALE_ROUTE  =''
	   ,@REFERENCE_CBC  =''
	   ,@VISIT_DAY  =''
	   ,@VISIT_FRECUENCY  =''
	   ,@TIME_DELIVER_DAYS  =0
	   ,@BRANCH  =''
       ,@SERVICE_WINDOW  ='Ventana 1'
       ,@SALE_POINT_COMPLEMENT_DIRECTIONC  ='Guatemala'
       ,@INVOICE_ADRESS_COMPLEMENT  ='Guatemala'
       ,@MUNICIPALITY  ='Villa Nueva'
       ,@DEPARTMENT  ='Guatemala'
       ,@CREDIT_LIMIT  = 0
       ,@CODE_BUSINESS_GYRE  =''
       ,@BUSINESS_GYRE_DENOMINATION  =''
       ,@CREDIT_CONTROL_AREA  =''
       ,@FORM_PAY_AUTHORIZATION  =''
       ,@CURRENCY  =''
       ,@ASSOCIATED_ACCOUNTANT_CREDIT_COUNT  =''
       ,@PAY_CONDITION  =''
       ,@CREDIT_BLOCKADE  =''
	   ,@LAST_UPDATED_BY = ''
	   ,@COMMENTS =''
GO

*/
-- =============================================
CREATE PROCEDURE [SONDA].[SWIFT_SP_INSERT_CUSTOMER_NEW_DETAIL]
	 @CUSTOMER INT
	,@CODE_CUSTOMER VARCHAR(250)
    ,@SALE_ROUTE VARCHAR(50)	
	,@REFERENCE_CBC VARCHAR(50)
	,@VISIT_DAY VARCHAR(50)
	,@VISIT_FRECUENCY VARCHAR(50)
	,@TIME_DELIVER_DAYS NUMERIC(8,0)
	,@BRANCH VARCHAR(50)
	,@SERVICE_WINDOW VARCHAR(50)
	,@SALE_POINT_COMPLEMENT_DIRECTIONC VARCHAR(50)
	,@INVOICE_ADRESS_COMPLEMENT VARCHAR(50)
	,@MUNICIPALITY VARCHAR(50)
	,@DEPARTMENT VARCHAR(50)
	,@CREDIT_LIMIT NUMERIC(18,2)
	,@CODE_BUSINESS_GYRE VARCHAR(50)
	,@BUSINESS_GYRE_DENOMINATION VARCHAR(50)
	,@CREDIT_CONTROL_AREA VARCHAR(50)
	,@FORM_PAY_AUTHORIZATION VARCHAR(50)
	,@CURRENCY VARCHAR(20)
	,@ASSOCIATED_ACCOUNTANT_CREDIT_COUNT VARCHAR(50)
	,@PAY_CONDITION VARCHAR(MAX)
	,@CREDIT_BLOCKADE VARCHAR(50)
	,@LAST_UPDATED_BY VARCHAR(25)
	,@COMMENTS VARCHAR(250)
AS
BEGIN TRY
	--
	IF(SELECT 1 FROM [SONDA].[SWIFT_CUSTOMER_NEW_DETAIL] WHERE [CUSTOMER] = @CUSTOMER) = 1 BEGIN
		UPDATE [SONDA].[SWIFT_CUSTOMER_NEW_DETAIL]
			SET [SALE_ROUTE] = @SALE_ROUTE
				,[REFERENCE_CBC] = @REFERENCE_CBC
				,[VISIT_DAY] = @VISIT_DAY
				,[VISIT_FRECUENCY] = @VISIT_FRECUENCY
				,[TIME_DELIVER_DAYS] = @TIME_DELIVER_DAYS
				,[BRANCH] = @BRANCH
				,[SERVICE_WINDOW] = @SERVICE_WINDOW
				,[SALE_POINT_COMPLEMENT_DIRECTION] = @SALE_POINT_COMPLEMENT_DIRECTIONC
				,[INVOICE_ADRESS_COMPLEMENT] = @INVOICE_ADRESS_COMPLEMENT
				,[MUNICIPALITY] = @MUNICIPALITY
				,[DEPARTMENT] = @DEPARTMENT
				,[CREDIT_LIMIT] = @CREDIT_LIMIT
				,[CODE_BUSINESS_GYRE] = @CODE_BUSINESS_GYRE
				,[BUSINESS_GYRE_DENOMINATION] = @BUSINESS_GYRE_DENOMINATION
				,[CREDIT_CONTROL_AREA] = @CREDIT_CONTROL_AREA
				,[FORM_PAY_AUTHORIZATION] = @FORM_PAY_AUTHORIZATION
				,[CURRENCY] = @CURRENCY
				,[ASSOCIATED_ACCOUNTANT_CREDIT_COUNT] = @ASSOCIATED_ACCOUNTANT_CREDIT_COUNT
				,[PAY_CONDITION] = @PAY_CONDITION
				,[CREDIT_BLOCKADE] = @CREDIT_BLOCKADE
		WHERE [CUSTOMER] = @CUSTOMER

		-- -------------------------------------------------------------------------------------------
		-- Se indica si se actualizo desde el BO
		-- -------------------------------------------------------------------------------------------
		UPDATE [SONDA].[SWIFT_CUSTOMERS_NEW]
		SET 
			[LAST_UPDATE] = GETDATE()
			,[LAST_UPDATE_BY] = @LAST_UPDATED_BY
			,[COMMENTS] = @COMMENTS
			,[UPDATED_FROM_BO] = 1
		WHERE [CODE_CUSTOMER] = @CODE_CUSTOMER
		--
	END
	ELSE BEGIN
		INSERT INTO [SONDA].[SWIFT_CUSTOMER_NEW_DETAIL]
		(
			[CUSTOMER]
			,[SALE_ROUTE]
			,[REFERENCE_CBC]
			,[VISIT_DAY]
			,[VISIT_FRECUENCY]
			,[TIME_DELIVER_DAYS]
			,[BRANCH]
			,[SERVICE_WINDOW]
			,[SALE_POINT_COMPLEMENT_DIRECTION]
			,[INVOICE_ADRESS_COMPLEMENT]
			,[MUNICIPALITY]
			,[DEPARTMENT]
			,[CREDIT_LIMIT]
			,[CODE_BUSINESS_GYRE]
			,[BUSINESS_GYRE_DENOMINATION]
			,[CREDIT_CONTROL_AREA]
			,[FORM_PAY_AUTHORIZATION]
			,[CURRENCY]
			,[ASSOCIATED_ACCOUNTANT_CREDIT_COUNT]
			,[PAY_CONDITION]
			,[CREDIT_BLOCKADE]
		 )
		 VALUES
		 (		   
			@CUSTOMER 
			,@SALE_ROUTE 	
			,@REFERENCE_CBC 
			,@VISIT_DAY 
			,@VISIT_FRECUENCY
			,@TIME_DELIVER_DAYS
			,@BRANCH
			,@SERVICE_WINDOW
			,@SALE_POINT_COMPLEMENT_DIRECTIONC
			,@INVOICE_ADRESS_COMPLEMENT
			,@MUNICIPALITY
			,@DEPARTMENT
			,@CREDIT_LIMIT
			,@CODE_BUSINESS_GYRE
			,@BUSINESS_GYRE_DENOMINATION
			,@CREDIT_CONTROL_AREA
			,@FORM_PAY_AUTHORIZATION
			,@CURRENCY
			,@ASSOCIATED_ACCOUNTANT_CREDIT_COUNT
			,@PAY_CONDITION
			,@CREDIT_BLOCKADE
		)
		
		-- -------------------------------------------------------------------------------------------
		-- Se indica si se actualizo desde el BO
		-- -------------------------------------------------------------------------------------------
		UPDATE [SONDA].[SWIFT_CUSTOMERS_NEW]
		SET 
			[LAST_UPDATE] = GETDATE()
			,[LAST_UPDATE_BY] = @LAST_UPDATED_BY
			,[COMMENTS] = @COMMENTS
			,[UPDATED_FROM_BO] = 1
		WHERE [CODE_CUSTOMER] = @CODE_CUSTOMER
		--

		--EXEC [SONDA].[SWIFT_SP_UPDATE_SCOUTING] @STATUS = 'ACCEPTED', @USER = @LAST_UPDATED_BY, @COMMENTS = @COMMENTS, @CUSTOMER = @CUSTOMER

	END

	IF @@error = 0 BEGIN
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje , 0 Codigo
	END		
	ELSE BEGIN		
		SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo
	END
END TRY
BEGIN CATCH     
	 SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo 
END CATCH




