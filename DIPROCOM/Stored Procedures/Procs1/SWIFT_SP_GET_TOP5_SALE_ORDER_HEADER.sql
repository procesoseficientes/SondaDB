﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	06-04-2016
-- Description:			obtien las primeras 5 ordenes de venta para la interfaz

-- Modificacion: 12-04-2016
--			Autor: diego.as
--			Descripcion: Se agrego el campo DISCOUNT a la consulta

-- Modificado 2016-05-02
-- joel.delcompare
-- Se agregaron campos OFIVENTAS ,RUTAVENTAS ,RUTAENTREGA,SECUENCIA ,SONDA 

-- Modificado 2016-05-13
-- hector.gonzalez
-- Se agrego al WHERE una linea para que no tomara en cuenta los DRAFT

-- Modificacion 23-05-2016
-- alberto.ruiz
-- Se agrego validacion por parametro SEND_SALES_ORDER_TO_DELIVERY_DATE

-- Modificado 2016-06-27
-- joel.delcompare
-- Se agregó  el campo comentario para que las interfaces lo puedan enviar a SBO. 

-- Modificado 2016-06-27
-- joel.delcompare
-- Se agregó  el campo IS_SCOUTING que valida si el cliente existen en la vista de Skus. 

-- Modificado 2016-12-06
-- diego.as
-- Se agregó  el campo AUTHORIZED para que tome en cuenta unicamente las SO autorizadas.

-- Modificacion 2/7/2017 @ A-Team Sprint 
-- rodrigo.gomez
-- Se agrego el campo ORGVENTAS

-- Modificacion 28-Feb-17 @ A-Team Sprint Donkor
					-- alberto.ruiz
					-- Se agrego el campo de organiacion y oficina de ventas desde los vendedores

-- Modificacion 24-Mar-17 @ A-Team Sprint Fenyang
					-- alberto.ruiz
					-- Se agrego que solo envie pedidos con menor intento de envios que el parametro y que actualice el valor IS_SENDIGN

-- Modificacion 5/29/2017 @ A-Team Sprint Jibade
					-- rodrigo.gomez
					-- Se agrego el parametro @OWNER, este se envia como INTERFACE_OWNER y se filtran los vendedores que tengan el mismo OWNER o que el OWNER sea NULL
/*
-- Ejemplo de Ejecucion:
        USE SWIFT_EXPRESS
        GO
        --
        EXEC [acsa].[SWIFT_SP_GET_TOP5_SALE_ORDER_HEADER]
*/
-- =============================================
CREATE PROCEDURE [acsa].SWIFT_SP_GET_TOP5_SALE_ORDER_HEADER(
	@OWNER VARCHAR(125)
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	DECLARE @SALES_ORDER TABLE (
		[SALES_ORER_ID] INT,
		[DETAIL_QTY] INT,
		[ATTEMPTED_WITH_ERROR] INT,
		[POSTED_DATETIME] DATETIME
	)
	--
	DECLARE @CODE_CUSTOMER VARCHAR(50) = 'C.F.'
         ,@NAME_CUSTOMER VARCHAR(100) = 'Consumidor Final'
         ,@TAX_ID_NUMBER VARCHAR(20) = 'CF'
         ,@ADRESS_CUSTOMER VARCHAR(MAX) = 'CIUDAD'
         ,@SALES_ORDER_TYPE VARCHAR(250)
         ,@SEND_SALES_ORDER_TO_DELIVERY_DATE INT
		 ,@SHIPPING_ATTEMPTS VARCHAR(100)
		 ,@PARAMETER_OWNER VARCHAR(125)

	-- ------------------------------------------------------------------------------------
	-- Obtiene los parametros necesarios
	-- ------------------------------------------------------------------------------------
	SELECT
		@CODE_CUSTOMER = [svac].[CODE_CUSTOMER]
		,@NAME_CUSTOMER = [svac].[NAME_CUSTOMER]
		,@TAX_ID_NUMBER = [svac].[TAX_ID_NUMBER]
		,@ADRESS_CUSTOMER = [svac].[ADRESS_CUSTOMER]
	FROM [acsa].[SWIFT_VIEW_ALL_COSTUMER] [svac]
	INNER JOIN [acsa].[SWIFT_PARAMETER] [sp] ON (
		[sp].[VALUE] = [svac].[CODE_CUSTOMER]
		AND [sp].[GROUP_ID] = 'ERP_HARDCODE_VALUES'
		AND [sp].[PARAMETER_ID] = 'DEFAULT_CUSTOMER'
	);
	--
	SELECT
		@SALES_ORDER_TYPE = [acsa].[SWIFT_FN_GET_PARAMETER]('SALES_ORDER_TYPE', 'CASH')
		,@SEND_SALES_ORDER_TO_DELIVERY_DATE = [acsa].[SWIFT_FN_GET_PARAMETER]('SALES_ORDER', 'SEND_SALES_ORDER_TO_DELIVERY_DATE')
		,@SHIPPING_ATTEMPTS = [acsa].[SWIFT_FN_GET_PARAMETER]('SALES_ORDER', 'SHIPPING_ATTEMPTS')
		,@PARAMETER_OWNER = [acsa].[SWIFT_FN_GET_PARAMETER]('SALES_ORDER_INTERCOMPANY','SEND_ALL_DETAIL')

	-- ------------------------------------------------------------------------------------
	-- Obtiene las ordenes de venta para enviar
	-- ------------------------------------------------------------------------------------.
	IF(@PARAMETER_OWNER = @OWNER)
	BEGIN
		INSERT INTO @SALES_ORDER
		SELECT TOP 5
			[SSOH].[SALES_ORDER_ID]
			, COUNT(*)
			, [SSOH].[ATTEMPTED_WITH_ERROR]
			, [SSOH].[POSTED_DATETIME]
		FROM [acsa].[SONDA_SALES_ORDER_HEADER] [SSOH]
		INNER JOIN [acsa].[SWIFT_VIEW_ALL_COSTUMER] [SVAC] ON ([SSOH].[CLIENT_ID] = [SVAC].[CODE_CUSTOMER])
		INNER JOIN [acsa].[SWIFT_WAREHOUSES_PRESALE_FOR_3PL] SWPF ON (SSOH.WAREHOUSE=SWPF.CODE_WAREHOUSE)
		INNER JOIN [acsa].[USERS] [U] ON [SSOH].[POSTED_BY] = [U].[LOGIN]
		INNER JOIN [acsa].[SWIFT_SELLER] [SELL] ON [U].[RELATED_SELLER] = [SELL].[SELLER_CODE]
		INNER JOIN [acsa].[SONDA_SALES_ORDER_DETAIL] [SSOD] ON [SSOD].[SALES_ORDER_ID] = [SSOH].[SALES_ORDER_ID] 
		INNER JOIN [acsa].[SWIFT_VIEW_ALL_SKU] [SVAS] ON [SVAS].[CODE_SKU] = [SSOD].[SKU]
		INNER JOIN [acsa].[SWIFT_CUSTOMER_INTERCOMPAY] [CC] ON [CC].[MASTER_ID] = [SSOH].[CLIENT_ID]
		INNER JOIN [acsa].[SWIFT_SELLER_INTERCOMPAY] [SI] ON [SELL].[SELLER_CODE] = [SI].[MASTER_ID]
		WHERE SWPF.[IS_WAREHOUSE_3PL] = 0
			AND ISNULL([SSOH].[IS_POSTED_ERP], 0) = 0
			AND	ISNULL([SSOD].[IS_POSTED_ERP], 0) = 0
			AND ISNULL([SSOH].[IS_VOID], 0) = 0
			AND ISNULL([SSOH].[IS_DRAFT], 0) = 0
			AND ISNULL([SSOH].[AUTHORIZED], 1) = 1
			AND [SSOH].[IS_READY_TO_SEND] = 1
			AND (
					@SEND_SALES_ORDER_TO_DELIVERY_DATE = 0
					OR (
						@SEND_SALES_ORDER_TO_DELIVERY_DATE = 1
						AND [SSOH].[DELIVERY_DATE] BETWEEN (CAST(CONVERT(DATE, GETDATE()) AS VARCHAR) + ' 00:00:00.000') AND (CAST(CONVERT(DATE, GETDATE()) AS VARCHAR) + ' 23:59:59.997')
					)
			)
			AND SSOH.TOTAL_AMOUNT= (SELECT SUM([OD].[TOTAL_LINE]) FROM [acsa].[SONDA_SALES_ORDER_DETAIL] [OD] WHERE [OD].[SALES_ORDER_ID]=[SSOH].[SALES_ORDER_ID])
			AND [ssoh].[IS_SENDING] = 0
			AND (ISNULL([SSOH].ATTEMPTED_WITH_ERROR,0) < CAST(@SHIPPING_ATTEMPTS AS INT))
			AND [SSOH].[POSTED_DATETIME] >= FORMAT(GETDATE(),'yyyyMMdd')
			AND ([SELL].[OWNER] = @OWNER OR [SELL].[OWNER] IS NULL)
			AND [CC].[SOURCE] = @OWNER
			AND [SI].[SOURCE] = @OWNER
		GROUP BY [SSOH].[SALES_ORDER_ID]
				,[SSOH].[ATTEMPTED_WITH_ERROR]
				,[SSOH].[POSTED_DATETIME]
		HAVING COUNT(*) > 0
		ORDER BY 
			[SSOH].[ATTEMPTED_WITH_ERROR] ASC
			,[SSOH].[POSTED_DATETIME] ASC;
	END
	ELSE
	BEGIN
		INSERT INTO @SALES_ORDER
		SELECT TOP 5
			[SSOH].[SALES_ORDER_ID]
			, COUNT(*)
			, [SSOH].[ATTEMPTED_WITH_ERROR]
			, [SSOH].[POSTED_DATETIME]
		FROM [acsa].[SONDA_SALES_ORDER_HEADER] [SSOH]
		INNER JOIN [acsa].[SWIFT_VIEW_ALL_COSTUMER] [SVAC] ON ([SSOH].[CLIENT_ID] = [SVAC].[CODE_CUSTOMER])
		INNER JOIN [acsa].[SWIFT_WAREHOUSES_PRESALE_FOR_3PL] SWPF ON (SSOH.WAREHOUSE=SWPF.CODE_WAREHOUSE)
		INNER JOIN [acsa].[USERS] [U] ON [SSOH].[POSTED_BY] = [U].[LOGIN]
		INNER JOIN [acsa].[SWIFT_SELLER] [SELL] ON [U].[RELATED_SELLER] = [SELL].[SELLER_CODE]
		INNER JOIN [acsa].[SONDA_SALES_ORDER_DETAIL] [SSOD] ON [SSOD].[SALES_ORDER_ID] = [SSOH].[SALES_ORDER_ID] 
		INNER JOIN [acsa].[SWIFT_VIEW_ALL_SKU] [SVAS] ON [SVAS].[CODE_SKU] = [SSOD].[SKU]
		INNER JOIN [acsa].[SWIFT_CUSTOMER_INTERCOMPAY] [CC] ON [CC].[MASTER_ID] = [SSOH].[CLIENT_ID]
		INNER JOIN [acsa].[SWIFT_SELLER_INTERCOMPAY] [SI] ON [SELL].[SELLER_CODE] = [SI].[MASTER_ID]
		WHERE SWPF.[IS_WAREHOUSE_3PL] = 0
			AND ISNULL([SSOH].[IS_POSTED_ERP], 0) = 0
			AND	ISNULL([SSOD].[IS_POSTED_ERP], 0) = 0
			AND ISNULL([SSOH].[IS_VOID], 0) = 0
			AND ISNULL([SSOH].[IS_DRAFT], 0) = 0
			AND ISNULL([SSOH].[AUTHORIZED], 1) = 1
			AND [SSOH].[IS_READY_TO_SEND] = 1
			AND (
					@SEND_SALES_ORDER_TO_DELIVERY_DATE = 0
					OR (
						@SEND_SALES_ORDER_TO_DELIVERY_DATE = 1
						AND [SSOH].[DELIVERY_DATE] BETWEEN (CAST(CONVERT(DATE, GETDATE()) AS VARCHAR) + ' 00:00:00.000') AND (CAST(CONVERT(DATE, GETDATE()) AS VARCHAR) + ' 23:59:59.997')
					)
			)
			AND SSOH.TOTAL_AMOUNT= (SELECT SUM([OD].[TOTAL_LINE]) FROM [acsa].[SONDA_SALES_ORDER_DETAIL] [OD] WHERE [OD].[SALES_ORDER_ID]=[SSOH].[SALES_ORDER_ID])
			AND [ssoh].[IS_SENDING] = 0
			AND (ISNULL([SSOH].ATTEMPTED_WITH_ERROR,0) < CAST(@SHIPPING_ATTEMPTS AS INT))
			AND [SSOH].[POSTED_DATETIME] >= FORMAT(GETDATE(),'yyyyMMdd')
			AND ([SELL].[OWNER] = @OWNER OR [SELL].[OWNER] IS NULL)
			AND	[SVAC].[OWNER] <> @PARAMETER_OWNER
			AND [SVAS].[OWNER] = @OWNER
			AND [CC].[SOURCE] = @OWNER
			AND [SI].[SOURCE] = @OWNER
		GROUP BY [SSOH].[SALES_ORDER_ID]
				,[SSOH].[ATTEMPTED_WITH_ERROR]
				,[SSOH].[POSTED_DATETIME]
		HAVING COUNT(*) > 0
		ORDER BY 
			[SSOH].[ATTEMPTED_WITH_ERROR] ASC
			,[SSOH].[POSTED_DATETIME] ASC;
	END

	-- ------------------------------------------------------------------------------------
	-- Las coloca como enviando
	-- ------------------------------------------------------------------------------------
	UPDATE [SOH]
	SET
		[SOH].[IS_SENDING] = 1
		,[SOH].[LAST_UPDATE_IS_SENDING] = GETDATE()
	FROM [acsa].[SONDA_SALES_ORDER_HEADER] [SOH]
	INNER JOIN @SALES_ORDER [SO] ON ([SO].[SALES_ORER_ID] = [SOH].[SALES_ORDER_ID])

	-- ------------------------------------------------------------------------------------
	-- Obtiene la orden de venta
	-- ------------------------------------------------------------------------------------
	SELECT
		[SSOH].[SALES_ORDER_ID]
		,[SSOH].[TERMS]
		,[SSOH].[POSTED_DATETIME]
		,[CC].[CARD_CODE] [CLIENT_ID]
		,[SSOH].[POS_TERMINAL]
		,[SSOH].[GPS_URL]
		,[SSOH].[TOTAL_AMOUNT]
		,[SSOH].[STATUS]
		,[SSOH].[POSTED_BY]
		,'' [IMAGE_1]
		,'' [IMAGE_2]
		,'' [IMAGE_3]
		,[SSOH].[DEVICE_BATTERY_FACTOR]
		,[SSOH].[VOID_DATETIME]
		,[SSOH].[VOID_REASON]
		,[SSOH].[VOID_NOTES]
		,[SSOH].[VOIDED]
		,[SSOH].[CLOSED_ROUTE_DATETIME]
		,[SSOH].[IS_ACTIVE_ROUTE]
		,[SSOH].[GPS_EXPECTED]
		,[SSOH].[DELIVERY_DATE]
		,[SSOH].[SALES_ORDER_ID_HH]
		,[SSOH].[ATTEMPTED_WITH_ERROR]
		,[SSOH].[IS_POSTED_ERP]
		,[SSOH].[POSTED_ERP]
		,[SSOH].[POSTED_RESPONSE]
		,[SSOH].[IS_PARENT]
		,[SSOH].[REFERENCE_ID]
		,[SW].[ERP_WAREHOUSE] [WAREHOUSE]
		,[SSOH].[TIMES_PRINTED]
		,CASE [SSOH].[IS_PARENT]
			WHEN 1 THEN ISNULL([SVAC].[OWNER_ID],[SVAC].[CODE_CUSTOMER])
			WHEN 0 THEN @CODE_CUSTOMER
		END AS [CODE_CUSTOMER]
		,CASE [SSOH].[IS_PARENT]
			WHEN 1 THEN [SVAC].[NAME_CUSTOMER]
			WHEN 0 THEN @NAME_CUSTOMER
		-- ELSE
		END AS [NAME_CUSTOMER]
		,CASE [SSOH].[IS_PARENT]
			WHEN 1 THEN [SVAC].[TAX_ID_NUMBER]
			WHEN 0 THEN @TAX_ID_NUMBER
		END [TAX_ID_NUMBER]
		,CASE [SSOH].[IS_PARENT]
			WHEN 1 THEN [SVAC].[ADRESS_CUSTOMER]
			WHEN 0 THEN [ADRESS_CUSTOMER]
		END AS [ADRESS_CUSTOMER]
		,[SI].[SLP_CODE] [SALES_PERSON_CODE]
		,CASE [SSOH].[SALES_ORDER_TYPE]
			WHEN @SALES_ORDER_TYPE THEN '**CONTADO**'
			ELSE NULL
		END [SALES_ORDER_TYPE]
		,[SSOH].[DISCOUNT]
		,[SO].[NAME_SALES_OFFICE] [OFIVENTAS]
		,[ORG].[NAME_SALES_ORGANIZATION] [ORGVENTAS]
		,[SVAC].[RUTAVENTAS]
		,[SVAC].[RUTAENTREGA]
		,CASE	WHEN ISNULL([SVAC].[RUTAVENTAS], '..') = '..'
				THEN NULL
				ELSE [SVAC].[RUTAVENTAS] + RIGHT('000000' + CONVERT(VARCHAR(6), [SVAC].[SECUENCIA]), 6)
		END AS [NUM_AT_CARD]
		,'S' AS [acsa]
		,[SSOH].[COMMENT]
		,[acsa].[SWIFT_FN_VALIDATE_IS_SCOUTING]([SSOH].[CLIENT_ID]) AS [IS_SCOUTING]
		,[SVAC].[EXTRA_DAYS]
		,[SVAC].[PAYMENT_CONDITIONS]
		,@OWNER [INTERFACE_OWNER]
		,[SVAC].[OWNER] [CLIENT_OWNER]
	FROM [acsa].[SONDA_SALES_ORDER_HEADER] [SSOH]
	INNER JOIN @SALES_ORDER [SOT] ON ([SOT].[SALES_ORER_ID] = [SSOH].[SALES_ORDER_ID])
	INNER JOIN [acsa].[SWIFT_WAREHOUSES] [SW] ON ([SSOH].[WAREHOUSE] = [SW].[CODE_WAREHOUSE])
	LEFT JOIN [acsa].[SWIFT_VIEW_ALL_COSTUMER] [SVAC] ON ([SSOH].[CLIENT_ID] = [SVAC].[CODE_CUSTOMER])
	INNER JOIN [acsa].[USERS] [U] ON ([SSOH].[POSTED_BY] = [U].[LOGIN])
	LEFT JOIN [acsa].[SWIFT_SALES_OFFICE] [SO] ON ([SO].[SALES_OFFICE_ID] = [SW].[SALES_OFFICE_ID])
	LEFT JOIN [acsa].[SWIFT_SALES_ORGANIZATION] [ORG] ON ([ORG].[SALES_ORGANIZATION_ID] = [SVAC].[ORGANIZACION_VENTAS])
	INNER JOIN [acsa].[SWIFT_CUSTOMER_INTERCOMPAY] [CC] ON [CC].[MASTER_ID] = [SSOH].[CLIENT_ID]
	INNER JOIN [acsa].[SWIFT_SELLER_INTERCOMPAY] [SI] ON [U].[RELATED_SELLER] = [SI].[MASTER_ID]
	WHERE [CC].[SOURCE] = @OWNER
		AND [SI].[SOURCE] = @OWNER
END
