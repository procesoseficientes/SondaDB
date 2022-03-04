﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	11-11-2015
-- Description:			Obtiene todos los clientes locales y de SAP

-- Modificacion 11-11-2015
--alberto.ruiz
--Se agrego la columna de GPS

-- Modificacion 23-01-2016
--alberto.ruiz
--Se agregaron las columnas de Latitud y longitud

-- Modificacion 27-02-2016
--rudi.garcia
--Se agrego la columna extradays

-- Modificacion 06-04-2016
--hector.gonzalez
--Se agrego la columna DISCOUNT

-- Modificado 2016-05-02
-- joel.delcompare
-- Se agregaron los campos , OFIVENTAS 	,RUTAVENTAS ,	RUTAENTREGA,SECUENCIA

-- Modificado 2016-05-02
-- hector.gonzalez
-- se agrego campo RGA_CODE

-- Modificacion 2/7/2017 @ A-Team Sprint Chatuluka
-- rodrigo.gomez
-- Se agrego el campo ORGVENTAS

-- Modificacion 28-Feb-17 @ A-Team Sprint Donkor
					-- alberto.ruiz
					-- Se agregaron columas de organizacion de ventas y payment_conditos

-- Modificacion 14-Mar-17 @ A-Team Sprint Ebonne
					-- alberto.ruiz
					-- Se agregaron los campos de [OWNER] y [OWNER_ID]

-- Modificacion 04-May-17 @ A-Team Sprint Hondo
					-- alberto.ruiz
					-- Se agrego columna de balance

-- Modificacion 29-May-17 @ A-Team Sprint Jibade
					-- alberto.ruiz
					-- Se agregaron campos de nit y nombre de facturacion

-- Modificacion 8/31/2017 @ Reborn-Team Sprint Collin
					-- diego.as
					-- Se agrega columna 
					
-- Modificacion 		6/20/2019 @ G-Force Team Sprint 
-- Autor: 				diego.as
-- Historia/Bug:		Product Backlog Item 29713: Agregar funcionalidad de Cobros en Preventa
-- Descripcion: 		6/20/2019 - Se agrega columna CREDIT_LIMIT en lugar del valor 999999, se agrega columna GROUP_NUM

/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [acsa].[SWIFT_VIEW_ALL_COSTUMER] WHERE CUSTOMER = '42082'
*/
-- =============================================
CREATE VIEW [acsa].[SWIFT_VIEW_ALL_COSTUMER]
AS
SELECT
	RTRIM(LTRIM([CODE_CUSTOMER])) COLLATE DATABASE_DEFAULT [CUSTOMER]
	,[CODE_CUSTOMER]
	,[NAME_CUSTOMER]
	,[PHONE_CUSTOMER]
	,[ADRESS_CUSTOMER]
	,[CLASSIFICATION_CUSTOMER]
	,[CONTACT_CUSTOMER]
	,[CODE_ROUTE]
	,[LAST_UPDATE]
	,[LAST_UPDATE_BY]
	,[SELLER_DEFAULT_CODE]
	,[CREDIT_LIMIT]
	,0 [FROM_ERP]
	,'C.F' AS [TAX_ID_NUMBER]
	,[GPS]
	,[LATITUDE]
	,[LONGITUDE]
	,[FREQUENCY]
	,[SUNDAY]
	,[MONDAY]
	,[TUESDAY]
	,[WEDNESDAY]
	,[THURSDAY]
	,[FRIDAY]
	,[SATURDAY]
	,[SCOUTING_ROUTE]
	,0 AS [EXTRA_DAYS]
	,0 AS [DISCOUNT]
	,'..' AS [OFIVENTAS]
	,'..' AS [ORGVENTAS]
	,'..' AS [RUTAVENTAS]
	,'..' AS [RUTAENTREGA]
	,0 AS [SECUENCIA]
	,NULL AS [RGA_CODE]
	,CAST(NULL AS VARCHAR(250)) AS [ORGANIZACION_VENTAS]
	,CAST(NULL AS VARCHAR(250)) AS [PAYMENT_CONDITIONS]
	,CAST(NULL AS VARCHAR(50)) AS [OWNER]
	,CAST(NULL AS VARCHAR(50)) AS [OWNER_ID]
	,CAST(0.00 AS NUMERIC(18,6)) [BALANCE]
	,[NAME_CUSTOMER] [INVOICE_NAME]
	,CAST(NULL AS VARCHAR(50)) AS CODE_CUSTOMER_ALTERNATE
	,CAST(NULL AS INT) AS [GROUP_NUM]
       ,CAST(NULL AS CHAR(1)) AS [SPECIAL_MARKER]
FROM
	[acsa].[SWIFT_CUSTOMERS]
UNION ALL
SELECT
	[C].[CUSTOMER] COLLATE DATABASE_DEFAULT [CUSTOMER]
	,CAST([C].[CODE_CUSTOMER] COLLATE DATABASE_DEFAULT AS VARCHAR(50)) [CODE_CUSTOMER]
	,[C].[NAME_CUSTOMER] COLLATE DATABASE_DEFAULT [NAME_CUSTOMER]
	,[C].[PHONE_CUSTOMER] COLLATE DATABASE_DEFAULT [PHONE_CUSTOMER]
	,[C].[ADRESS_CUSTOMER] COLLATE DATABASE_DEFAULT [ADRESS_CUSTOMER]
	,[C].[CLASSIFICATION_CUSTOMER] COLLATE DATABASE_DEFAULT [CLASSIFICATION_CUSTOMER]
	,[C].[CONTACT_CUSTOMER] COLLATE DATABASE_DEFAULT [CONTACT_CUSTOMER]
	,[C].[CODE_ROUTE] COLLATE DATABASE_DEFAULT [CODE_ROUTE]
	,[C].[LAST_UPDATE] [LAST_UPDATE]
	,[C].[LAST_UPDATE_BY] COLLATE DATABASE_DEFAULT [LAST_UPDATE_BY]
	,[C].[SELLER_DEFAULT_CODE] COLLATE DATABASE_DEFAULT AS [SELLER_DEFAULT_CODE]
	,[C].[CREDIT_LIMIT] AS [CREDIT_LIMIT]
	,[C].[FROM_ERP] [FROM_ERP]
	,[C].[TAX_ID_NUMBER]
	,[C].[GPS]
	,[C].[LATITUDE]
	,[C].[LONGITUDE]
	,[C].[FREQUENCY]
	,[C].[SUNDAY]
	,[C].[MONDAY]
	,[C].[TUESDAY]
	,[C].[WEDNESDAY]
	,[C].[THURSDAY]
	,[C].[FRIDAY]
	,[C].[SATURDAY]
	,[C].[SCOUTING_ROUTE]
	,(ISNULL([C].[EXTRA_MONT], 0) * CONVERT(INT, [P].[VALUE]))
	+ ISNULL([C].[EXTRA_DAYS], 0) AS [EXTRA_DAYS]
	,ISNULL([C].[DISCOUNT], 0) AS [DISCOUNT]
	,ISNULL([C].[OFIVENTAS], '..') AS [OFIVENTAS]
	,'..' AS [ORGVENTAS]
	,ISNULL([C].[RUTAVENTAS], '..') AS [RUTAVENTAS]
	,ISNULL([C].[RUTAVENTAS], '..') AS [RUTAENTREGA]
	,ISNULL([C].[SECUENCIA], 0) AS [SECUENCIA]
	,[C].[RGA_CODE]
	,[C].[ORGANIZACION_VENTAS]
	,[C].[PAYMENT_CONDITIONS]
	,[C].[OWNER]
	,[C].[OWNER_ID]
	,ISNULL([C].[BALANCE],CAST(0.00 AS NUMERIC(18,6)))
	,[C].[INVOICE_NAME]
	,[C].CODE_CUSTOMER_ALTERNATE
	  ,[C].[GROUP_NUM]
       ,[C].[SPECIAL_MARKER]
FROM
	[$(SWIFT_INTERFACES)].[acsa].[ERP_VIEW_COSTUMER] [C], 
	(SELECT P.VALUE FROM [acsa].[SWIFT_PARAMETER] [P] WHERE
											[P].[GROUP_ID] = 'DEFAULT_DAYS_BY_MONTH'
											AND [P].[PARAMETER_ID] = 'MONTH_CREDIT'
											) [P]
UNION ALL
SELECT
	'LINEA_PICKING_001' [CUSTOMER]
	,'LINEA_PICKING_001' [CODE_CUSTOMER]
	,'Línea de picking 001' [NAME_CUSTOMER]
	,NULL [PHONE_CUSTOMER]
	,NULL [ADRESS_CUSTOMER]
	,NULL [CLASSIFICATION_CUSTOMER]
	,NULL [CONTACT_CUSTOMER]
	,NULL [CODE_ROUTE]
	,NULL [LAST_UPDATE]
	,NULL [LAST_UPDATE_BY]
	,NULL [SELLER_DEFAULT_CODE]
	,NULL [CREDIT_LIMIT]
	,0 [FROM_ERP]
	,'C.F' AS [TAX_ID_NUMBER]
	,NULL [GPS]
	,NULL [LATITUDE]
	,NULL [LONGITUDE]
	,NULL [FREQUENCY]
	,NULL [SUNDAY]
	,NULL [MONDAY]
	,NULL [TUESDAY]
	,NULL [WEDNESDAY]
	,NULL [THURSDAY]
	,NULL [FRIDAY]
	,NULL [SATURDAY]
	,NULL [SCOUTING_ROUTE]
	,0 AS [EXTRA_DAYS]
	,0 AS [DISCOUNT]
	,'..' AS [OFIVENTAS]
	,'..' AS [ORGVENTAS]
	,'..' AS [RUTAVENTAS]
	,'..' AS [RUTAENTREGA]
	,0 AS [SECUENCIA]
	,NULL AS [RGA_CODE]
	,CAST(NULL AS VARCHAR(250)) AS [ORGANIZACION_VENTAS]
	,CAST(NULL AS VARCHAR(250)) AS [PAYMENT_CONDITIONS]
	,NULL [OWNER]
	,NULL [OWNER_ID]
	,CAST(0.00 AS NUMERIC(18,6)) [BALANCE]
	,'Línea de picking 001' [INVOICE_NAME]
	,NULL CODE_CUSTOMER_ALTERNATE
	  ,CAST(NULL AS INT) AS [GROUP_NUM]
      , CAST(NULL AS CHAR(1)) AS [SPECIAL_MARKER];