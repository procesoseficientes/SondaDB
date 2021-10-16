﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	13-04-2016
-- Description:			Crea encabezado de orden de venta
/*
-- EJEMPLO DE EJECUCION: 

				exec [DIPROCOM].SWIFT_SP_INSERT_SALES_ORDER_HEADER 
					@CLIENT_ID=N'956'
					,@POS_TERMINAL=N'RutaGerente'
					,@GPS_URL=N'0,0'
					,@TOTAL_AMOUNT=100.00
					,@POSTED_BY=N'gerente@DIPROCOM'
					,@GPS_EXPECTED=N'14.6296785,-90.605712'
					,@DELIVERY_DATE='2016-04-30 00:00:00'
					,@REFERENCE_ID=N'RutaGerente2016/04/21 05:36:14-1'
					,@WAREHOUSE=N'BODEGA_CENTRAL'
					,@DOC_SERIE=N'BB'
					,@DOC_NUM=1
					,@DISCOUNT=5
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_INSERT_SALES_ORDER_HEADER]
		@POSTED_DATETIME DATETIME = NULL
		,@CLIENT_ID VARCHAR(50)
		,@POS_TERMINAL VARCHAR(25)
		,@GPS_URL VARCHAR(150)
		,@TOTAL_AMOUNT NUMERIC(18,6)
		,@STATUS INT = 0
		,@POSTED_BY VARCHAR(25)
		,@IMAGE_1 VARCHAR(MAX) = NULL
		,@IMAGE_2 VARCHAR(MAX) = NULL
		,@IMAGE_3 VARCHAR(MAX) = NULL
		,@DEVICE_BATTERY_FACTOR INT = 0
		,@IS_ACTIVE_ROUTE INT = 0
		,@GPS_EXPECTED VARCHAR(25)
		,@DELIVERY_DATE DATETIME
		,@SALES_ORDER_ID_HH INT = 0
		,@IS_PARENT INT = 1
		,@REFERENCE_ID VARCHAR(150)
		,@WAREHOUSE VARCHAR(50)
		,@TIMES_PRINTED INT = 0
		,@DOC_SERIE VARCHAR(100)
		,@DOC_NUM INT
		,@IS_VOID INT = 0
		,@SALES_ORDER_TYPE VARCHAR(250) = NULL --CREDIT
		,@DISCOUNT NUMERIC(18,6)
		,@IS_DRAFT INT = 0
		,@ASSIGNED_BY VARCHAR(50)= 'BO'
AS
BEGIN TRY
	DECLARE @ID INT
	--
	IF @SALES_ORDER_TYPE IS NULL
	BEGIN
		SELECT @SALES_ORDER_TYPE = VALUE
		FROM [DIPROCOM].SWIFT_PARAMETER P
		WHERE P.GROUP_ID = 'SALES_ORDER_TYPE'
			AND P.PARAMETER_ID = 'CREDIT'
	END
	--
	IF @POSTED_DATETIME IS NULL
	BEGIN
		SET @POSTED_DATETIME = GETDATE()
	END
	--
	INSERT INTO [DIPROCOM].[SONDA_SALES_ORDER_HEADER](
		POSTED_DATETIME
		,CLIENT_ID
		,POS_TERMINAL
		,GPS_URL
		,TOTAL_AMOUNT
		,STATUS --0
		,POSTED_BY
		,IMAGE_1
		,IMAGE_2
		,IMAGE_3
		,DEVICE_BATTERY_FACTOR
		,IS_ACTIVE_ROUTE--1
		,GPS_EXPECTED
		,DELIVERY_DATE
		,SALES_ORDER_ID_HH		
		,IS_PARENT
		,REFERENCE_ID
		,WAREHOUSE
		,TIMES_PRINTED
		,DOC_SERIE
		,DOC_NUM
		,IS_VOID
		,SALES_ORDER_TYPE
		,DISCOUNT
		,IS_DRAFT
		,ASSIGNED_BY
	) VALUES (
		@POSTED_DATETIME
		,@CLIENT_ID
		,@POS_TERMINAL
		,@GPS_URL
		,@TOTAL_AMOUNT
		,@STATUS --0
		,@POSTED_BY
		,@IMAGE_1
		,@IMAGE_2
		,@IMAGE_3
		,@DEVICE_BATTERY_FACTOR
		,@IS_ACTIVE_ROUTE
		,@GPS_EXPECTED
		,@DELIVERY_DATE
		,@SALES_ORDER_ID_HH		
		,@IS_PARENT
		,@REFERENCE_ID
		,@WAREHOUSE
		,@TIMES_PRINTED
		,@DOC_SERIE
		,@DOC_NUM
		,@IS_VOID
		,@SALES_ORDER_TYPE
		,@DISCOUNT
		,@IS_DRAFT
		,@ASSIGNED_BY
	)
	--	   
	SELECT @ID = SCOPE_IDENTITY()
	
  IF @@error = 0 BEGIN		
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo, CONVERT(VARCHAR(16), @ID) DbData
	END		
	ELSE BEGIN		
		SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo
	END
END TRY
BEGIN CATCH     
	 SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo 
END CATCH