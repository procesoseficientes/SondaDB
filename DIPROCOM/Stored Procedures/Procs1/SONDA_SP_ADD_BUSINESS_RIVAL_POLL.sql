﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	05-Jan-17 @ A-TEAM Sprint Baldor 
-- Description:			SP que inserta la encuesta de la competencia de cliente

/*
-- Ejemplo de Ejecucion:
				EXEC [SONDA].[SONDA_SP_ADD_BUSINESS_RIVAL_POLL]
					@INVOICE_RESOLUTION = 'PRUEBA'
					,@INVOICE_SERIE = 'PRUEBA'
					,@INVOICE_NUM = 0
					,@CODE_CUSTOMER = 'PRUEBA'
					,@BUSSINESS_RIVAL_NAME  = 'CLARO'
					,@BUSSINESS_RIVAL_TOTAL_AMOUNT  = 150
					,@CUSTOMER_TOTAL_AMOUNT = 125
					,@COMMENT = 'MAS BARATO'
					,@CODE_ROUTE = 'RUDI@DIPROCOM'
					,@POSTED_DATETIME = '20170105 12:12:12.123'
				--
				SELECT * FROM [SONDA].[SONDA_BUSINESS_RIVAL_POLL]
*/
-- =============================================
CREATE PROCEDURE [SONDA].[SONDA_SP_ADD_BUSINESS_RIVAL_POLL](
	@INVOICE_RESOLUTION VARCHAR(50)
	,@INVOICE_SERIE VARCHAR(50)
	,@INVOICE_NUM INT
	,@CODE_CUSTOMER VARCHAR(50)
	,@BUSSINESS_RIVAL_NAME VARCHAR(50)
	,@BUSSINESS_RIVAL_TOTAL_AMOUNT NUMERIC(18,6)
	,@CUSTOMER_TOTAL_AMOUNT NUMERIC(18,6)
	,@COMMENT VARCHAR(50)
	,@CODE_ROUTE VARCHAR(50)
	,@POSTED_DATETIME DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	DECLARE @ROUTE INT
	--
	SELECT @ROUTE = [SONDA].[SWIFT_FN_GET_ROUTE_ID_FROM_CODE_ROUTE](@CODE_ROUTE)
	--
	INSERT INTO [SONDA].[SONDA_BUSINESS_RIVAL_POLL]
			(
				[INVOICE_RESOLUTION]
				,[INVOICE_SERIE]
				,[INVOICE_NUM]
				,[CODE_CUSTOMER]
				,[BUSSINESS_RIVAL_NAME]
				,[BUSSINESS_RIVAL_TOTAL_AMOUNT]
				,[CUSTOMER_TOTAL_AMOUNT]
				,[COMMENT]
				,[ROUTE]
				,[POSTED_DATETIME]
			)
	VALUES
			(
				@INVOICE_RESOLUTION
				,@INVOICE_SERIE
				,@INVOICE_NUM
				,@CODE_CUSTOMER
				,@BUSSINESS_RIVAL_NAME
				,@BUSSINESS_RIVAL_TOTAL_AMOUNT
				,@CUSTOMER_TOTAL_AMOUNT
				,@COMMENT
				,@ROUTE
				,@POSTED_DATETIME
			)
END



