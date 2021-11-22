﻿-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		04-07-2016
-- Description:			    Consulta para los vendedores en ruta

-- Modificacion:					hector.gonzalez
-- Fecha de Creacion: 		07-10-2016 sprint 2 TEAM-A
-- Description:			      Se agrego columna DELAY_TIME

-- Modificacion:					christian.hernandez
-- Fecha de Creacion: 		2/15/2019
-- Description:			      SE MODIFICO EL SP PARA MEJORAR EL PERFORMANCE Y ADAPTARLO A VENTAS Y PREVENTAS

-- Modificacion:			jonathan.salvador
-- Fecha de Creacion: 		29/10/2019
-- Description:			    Se agrega columna de Special Marker para indicador en el mapa

/*
-- Ejemplo de Ejecucion:
        EXEC [PACASA].[SWIFT_SP_GET_GPS_ACTIVE_ROUTE]
			@ASSIGNED_TO = '136'
			,@START_DATE = '20190215'
			,@END_DATE = '20190215' 
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_GPS_ACTIVE_ROUTE] (@ASSIGNED_TO VARCHAR(50)
, @START_DATE DATE
, @END_DATE DATE)
AS
BEGIN


  --------------------------------------------------------
  ---Declaramos las variables necesarioas para el procedimiento
  --------------------------------------------------------
  DECLARE @SALES_ORDER_HEADER_TOTALS TABLE (
    [SALES_ORDER_ID] INTEGER
   ,[TOTAL_AMOUNT] NUMERIC(18, 6)
   ,[QTY] NUMERIC(18, 2)
  )

  DECLARE @TEMP_DOCUMENT_HEADER TABLE (
    ID INT
   ,DOC_SERIAL VARCHAR(100)
   ,ROUTE VARCHAR(25)
   ,CLIENT VARCHAR(201)
   ,CLIENT_ID VARCHAR(50)
   ,ASSIGNED_TO VARCHAR(50)
   ,TOTAL_AMOUNT NUMERIC(18, 6)
   ,TOTAL_AMOUNT_WHIT_DISCOUNT NUMERIC(18, 6)
   ,UNIDADES_VENDIDAS NUMERIC
   ,SIGNATURE INT
   ,IMAGE INT
   ,EXPECTED_GPS VARCHAR(MAX)
   ,Latitude VARCHAR(150)
   ,Longitude VARCHAR(150)
   ,CREATED_DATESTAMP DATETIME
   ,CDF_SERIE VARCHAR(100)
   ,CDF_RESOLUCION VARCHAR(100)
   ,STATUS INT
   ,CLOSED_ROUTE_DATETIME DATETIME
   ,IMAGE_1 VARCHAR(MAX)
   ,IMAGE_2 VARCHAR(MAX)
   ,DOC_ID VARCHAR(50)
   ,DOC_TYPE VARCHAR(11)
   ,DOC_TYPE_DESCRIPTION VARCHAR(14)
   ,SALES_ORDER_TYPE VARCHAR(250)
   ,TASK_ID INT
   ,IS_POSTED_ERP INT
   ,ATTEMPTED_WITH_ERROR INT
   ,POSTED_RESPONSE VARCHAR(4000)
   ,POSTED_ERP DATETIME
   ,POSTED_DATETIME DATETIME
   ,LAST_UPDATE_IS_SENDING DATETIME
   ,TYPE_ACTION VARCHAR(12)
  )

  --DECLARE @SALES_ORDER_HEADER_TEMP TABLE (
  --  ID INT
  -- ,DOC_SERIAL VARCHAR(100)
  -- ,ROUTE VARCHAR(25)
  -- ,CLIENT VARCHAR(201)
  -- ,CLIENT_ID VARCHAR(50)
  -- ,ASSIGNED_TO VARCHAR(50)
  -- ,TOTAL_AMOUNT NUMERIC
  -- ,TOTAL_AMOUNT_WHIT_DISCOUNT NUMERIC
  -- ,UNIDADES_VENDIDAS NUMERIC
  -- ,SIGNATURE INT
  -- ,IMAGE INT
  -- ,EXPECTED_GPS VARCHAR(MAX)
  -- ,Latitude VARCHAR(150)
  -- ,Longitude VARCHAR(150)
  -- ,CREATED_DATESTAMP DATETIME
  -- ,CDF_SERIE VARCHAR(100)
  -- ,CDF_RESOLUCION VARCHAR(100)
  -- ,STATUS INT
  -- ,CLOSED_ROUTE_DATETIME DATETIME
  -- ,IMAGE_1 VARCHAR(MAX)
  -- ,IMAGE_2 VARCHAR(MAX)
  -- ,DOC_ID VARCHAR(50)
  -- ,DOC_TYPE VARCHAR(11)
  -- ,DOC_TYPE_DESCRIPTION VARCHAR(14)
  -- ,SALES_ORDER_TYPE VARCHAR(250)
  -- ,TASK_ID INT
  -- ,IS_POSTED_ERP INT
  -- ,ATTEMPTED_WITH_ERROR INT
  -- ,POSTED_RESPONSE VARCHAR(4000)
  -- ,POSTED_ERP DATETIME
  -- ,POSTED_DATETIME DATETIME
  -- ,LAST_UPDATE_IS_SENDING DATETIME
  -- ,TYPE_ACTION VARCHAR(12)
  --)
  --
  --
  --DECLARE @INVOICE_HEADER_TEMP TABLE (
  --  ID INT
  -- ,DOC_SERIAL VARCHAR(100)
  -- ,ROUTE VARCHAR(25)
  -- ,CLIENT VARCHAR(201)
  -- ,CLIENT_ID VARCHAR(50)
  -- ,ASSIGNED_TO VARCHAR(50)
  -- ,TOTAL_AMOUNT NUMERIC
  -- ,TOTAL_AMOUNT_WHIT_DISCOUNT NUMERIC
  -- ,UNIDADES_VENDIDAS NUMERIC
  -- ,SIGNATURE INT
  -- ,IMAGE INT
  -- ,EXPECTED_GPS VARCHAR(MAX)
  -- ,Latitude VARCHAR(150)
  -- ,Longitude VARCHAR(150)
  -- ,CREATED_DATESTAMP DATETIME
  -- ,CDF_SERIE VARCHAR(100)
  -- ,CDF_RESOLUCION VARCHAR(100)
  -- ,STATUS INT
  -- ,CLOSED_ROUTE_DATETIME DATETIME
  -- ,IMAGE_1 VARCHAR(MAX)
  -- ,IMAGE_2 VARCHAR(MAX)
  -- ,DOC_ID VARCHAR(50)
  -- ,DOC_TYPE VARCHAR(11)
  -- ,DOC_TYPE_DESCRIPTION VARCHAR(14)
  -- ,SALES_ORDER_TYPE VARCHAR(250)
  -- ,TASK_ID INT
  -- ,IS_POSTED_ERP INT
  -- ,ATTEMPTED_WITH_ERROR INT
  -- ,POSTED_RESPONSE VARCHAR(4000)
  -- ,POSTED_ERP DATETIME
  -- ,POSTED_DATETIME DATETIME
  -- ,LAST_UPDATE_IS_SENDING DATETIME
  -- ,TYPE_ACTION VARCHAR(12)
  --)

  DECLARE @TASK_TEMP TABLE (
    TASK_ID INT NOT NULL
   ,TASK_TYPE VARCHAR(15) NULL
   ,TASK_DATE DATE NULL
   ,SCHEDULE_FOR DATE NULL
   ,CREATED_STAMP DATETIME NULL
   ,ASSIGEND_TO VARCHAR(25) NULL
   ,ASSIGNED_BY VARCHAR(25) NULL
   ,ASSIGNED_STAMP DATETIME NULL
   ,CANCELED_STAMP DATETIME NULL
   ,CANCELED_BY VARCHAR(25) NULL
   ,ACCEPTED_STAMP DATETIME NULL
   ,COMPLETED_STAMP DATETIME NULL
   ,RELATED_PROVIDER_CODE VARCHAR(25) NULL
   ,RELATED_PROVIDER_NAME VARCHAR(250) NULL
   ,EXPECTED_GPS VARCHAR(100) NULL
   ,POSTED_GPS VARCHAR(100) NULL
   ,TASK_STATUS VARCHAR(10) NULL
   ,TASK_COMMENTS VARCHAR(150) NULL
   ,TASK_SEQ INT NULL
   ,REFERENCE VARCHAR(150) NULL
   ,SAP_REFERENCE VARCHAR(150) NULL
   ,COSTUMER_CODE VARCHAR(25) NULL
   ,COSTUMER_NAME VARCHAR(250) NULL
   ,RECEPTION_NUMBER INT NULL
   ,PICKING_NUMBER INT NULL
   ,COUNT_ID VARCHAR(50) NULL
   ,ACTION VARCHAR(50) NULL
   ,SCANNING_STATUS VARCHAR(50) NULL
   ,ALLOW_STORAGE_ON_DIFF INT NULL
   ,CUSTOMER_PHONE VARCHAR(50) NULL
   ,TASK_ADDRESS VARCHAR(250) NULL
   ,VISIT_HOUR DATETIME NULL
   ,ROUTE_IS_COMPLETED INT NULL
   ,EMAIL_TO_CONFIRM VARCHAR(150) NULL
   ,DISTANCE_IN_KMS FLOAT NULL
   ,DOC_RESOLUTION VARCHAR(50) NULL
   ,DOC_SERIE VARCHAR(100) NULL
   ,DOC_NUM INT NULL
   ,COMPLETED_SUCCESSFULLY NUMERIC NULL
   ,REASON VARCHAR(250) NULL
   ,TASK_ID_HH INT NULL
   ,IN_PLAN_ROUTE INT NULL
   ,CREATE_BY VARCHAR(250) NULL
   ,DEVICE_NETWORK_TYPE VARCHAR(15) NULL
   ,IS_POSTED_OFFLINE INT NOT NULL
  )

  --------------------------------------------------------
  ---Obtenemos las tareas
  --------------------------------------------------------

  INSERT INTO @TASK_TEMP ([TASK_ID], [TASK_TYPE], [TASK_DATE], [SCHEDULE_FOR], [CREATED_STAMP], [ASSIGEND_TO], [ASSIGNED_BY], [ASSIGNED_STAMP], [CANCELED_STAMP], [CANCELED_BY], [ACCEPTED_STAMP], [COMPLETED_STAMP], [RELATED_PROVIDER_CODE], [RELATED_PROVIDER_NAME], [EXPECTED_GPS], [POSTED_GPS], [TASK_STATUS], [TASK_COMMENTS], [TASK_SEQ], [REFERENCE], [SAP_REFERENCE], [COSTUMER_CODE], [COSTUMER_NAME], [RECEPTION_NUMBER], [PICKING_NUMBER], [COUNT_ID], [ACTION], [SCANNING_STATUS], [ALLOW_STORAGE_ON_DIFF], [CUSTOMER_PHONE], [TASK_ADDRESS], [VISIT_HOUR], [ROUTE_IS_COMPLETED], [EMAIL_TO_CONFIRM], [DISTANCE_IN_KMS], [DOC_RESOLUTION], [DOC_SERIE], [DOC_NUM], [COMPLETED_SUCCESSFULLY], [REASON], [TASK_ID_HH], [IN_PLAN_ROUTE], [CREATE_BY], [DEVICE_NETWORK_TYPE], [IS_POSTED_OFFLINE])
    SELECT
      [T].TASK_ID
     ,[T].TASK_TYPE
     ,[T].TASK_DATE
     ,[T].SCHEDULE_FOR
     ,[T].CREATED_STAMP
     ,[T].ASSIGEND_TO
     ,[T].ASSIGNED_BY
     ,[T].ASSIGNED_STAMP
     ,[T].CANCELED_STAMP
     ,[T].CANCELED_BY
     ,[T].ACCEPTED_STAMP
     ,[T].COMPLETED_STAMP
     ,[T].RELATED_PROVIDER_CODE
     ,[T].RELATED_PROVIDER_NAME
     ,[T].EXPECTED_GPS
     ,CASE WHEN [T].POSTED_GPS = '' THEN '0,0'
	  ELSE [T].POSTED_GPS
	  END AS POSTED_GPS
     ,[T].TASK_STATUS
     ,[T].TASK_COMMENTS
     ,[T].TASK_SEQ
     ,[T].REFERENCE
     ,[T].SAP_REFERENCE
     ,[T].COSTUMER_CODE
     ,[T].COSTUMER_NAME
     ,[T].RECEPTION_NUMBER
     ,[T].PICKING_NUMBER
     ,[T].COUNT_ID
     ,[T].ACTION
     ,[T].SCANNING_STATUS
     ,[T].ALLOW_STORAGE_ON_DIFF
     ,[T].CUSTOMER_PHONE
     ,[T].TASK_ADDRESS
     ,[T].VISIT_HOUR
     ,[T].ROUTE_IS_COMPLETED
     ,[T].EMAIL_TO_CONFIRM
     ,[T].DISTANCE_IN_KMS
     ,[T].DOC_RESOLUTION
     ,[T].DOC_SERIE
     ,[T].DOC_NUM
     ,[T].COMPLETED_SUCCESSFULLY
     ,[T].REASON
     ,[T].TASK_ID_HH
     ,[T].IN_PLAN_ROUTE
     ,[T].CREATE_BY
     ,[T].DEVICE_NETWORK_TYPE
     ,[T].IS_POSTED_OFFLINE
    FROM [PACASA].SWIFT_TASKS [T]
    WHERE [T].[CODE_ROUTE] = @ASSIGNED_TO
    AND [T].[TASK_DATE] BETWEEN @START_DATE AND @END_DATE

  --------------------------------------------------------
  ---Obtenemos los totales de la venta con su descuento aplicado
  --------------------------------------------------------

  INSERT INTO @SALES_ORDER_HEADER_TOTALS ([SALES_ORDER_ID], [TOTAL_AMOUNT], [QTY])
    SELECT
      [SOH].[SALES_ORDER_ID]
     ,CASE
        WHEN MAX([SOH].[DISCOUNT_BY_GENERAL_AMOUNT]) > 0 THEN CAST( SUM([SOD].TOTAL_LINE) - (ISNULL(MAX([SOH].[DISCOUNT_BY_GENERAL_AMOUNT]), 0) * SUM([SOD].TOTAL_LINE) / 100) AS NUMERIC(18, 6))
        ELSE SUM([SOD].TOTAL_LINE)
      END AS [TOTAL_AMOUNT]
     ,SUM([SOD].[QTY]) AS [QTY]
    FROM [PACASA].[SONDA_SALES_ORDER_HEADER] [SOH] WITH (NOLOCK)
    INNER JOIN [PACASA].[SONDA_SALES_ORDER_DETAIL] [SOD] WITH (NOLOCK)
      ON ([SOD].[SALES_ORDER_ID] = [SOH].[SALES_ORDER_ID])
    INNER JOIN @TASK_TEMP [T]
      ON (
      [SOH].[TASK_ID] = [T].[TASK_ID]
      )
    WHERE [SOH].[SALES_ORDER_ID] > 0
    AND [SOH].[IS_READY_TO_SEND] = 1
    GROUP BY [SOH].[SALES_ORDER_ID]

  --------------------------------------------------------
  ---Obtenemos ya todos los datos del encabezado de la venta.
  --------------------------------------------------------

  INSERT INTO @TEMP_DOCUMENT_HEADER ([ID], [DOC_SERIAL], [ROUTE], [CLIENT], [CLIENT_ID], [ASSIGNED_TO], [TOTAL_AMOUNT], [TOTAL_AMOUNT_WHIT_DISCOUNT], [UNIDADES_VENDIDAS], [SIGNATURE], [IMAGE], [EXPECTED_GPS], [Latitude], [Longitude], [CREATED_DATESTAMP], [CDF_SERIE], [CDF_RESOLUCION], [STATUS], [CLOSED_ROUTE_DATETIME], [IMAGE_1], [IMAGE_2], [DOC_ID], [DOC_TYPE], [DOC_TYPE_DESCRIPTION], [SALES_ORDER_TYPE], [TASK_ID], [IS_POSTED_ERP], [ATTEMPTED_WITH_ERROR], [POSTED_RESPONSE], [POSTED_ERP], [POSTED_DATETIME], [LAST_UPDATE_IS_SENDING])
    SELECT
      [SOH].[SALES_ORDER_ID] AS [ID]
     ,ISNULL([SOH].[DOC_SERIE], [SOH].[SALES_ORDER_ID]) AS [DOC_SERIAL]
     ,[SOH].[POS_TERMINAL] AS [ROUTE]
     ,[SOH].[CLIENT_ID] AS [CLIENT]
     ,[SOH].[CLIENT_ID] AS [CLIENT_ID]
     ,[SOH].[POSTED_BY] AS [ASSIGNED_TO]
     ,[SOH].[TOTAL_AMOUNT] [TOTAL_AMOUNT]
     ,[SOHT].[TOTAL_AMOUNT] AS [TOTAL_AMOUNT_WHIT_DISCOUNT]
     ,[SOHT].[QTY] AS [UNIDADES_VENDIDAS]
     ,NULL AS [SIGNATURE]
     ,NULL AS [IMAGE]
     ,[SOH].[GPS_EXPECTED] AS [EXPECTED_GPS]
     ,SUBSTRING([SOH].[GPS_URL], 1, CHARINDEX(',', [SOH].[GPS_URL]) - 1) AS [Latitude]
     ,SUBSTRING([SOH].[GPS_URL], CHARINDEX(',', [SOH].[GPS_URL]) + 1, LEN([SOH].[GPS_URL])) AS [Longitude]
     ,[SOH].[POSTED_DATETIME] AS [CREATED_DATESTAMP]
     ,[SOH].[DOC_SERIE] AS [CDF_SERIE]
     ,CONVERT(VARCHAR(100), 'NA') AS [CDF_RESOLUCION]
     ,[SOH].[STATUS] AS [STATUS]
     ,[SOH].[CLOSED_ROUTE_DATETIME] AS [CLOSED_ROUTE_DATETIME]
     ,[SOH].[IMAGE_1] AS [IMAGE_1]
     ,[SOH].[IMAGE_2] AS [IMAGE_2]
     ,CONVERT(VARCHAR(50), ISNULL([SOH].[DOC_NUM], [SOH].[SALES_ORDER_ID])) AS [DOC_ID]
     ,'SALES_ORDER' AS [DOC_TYPE]
     ,'Order de Venta' AS [DOC_TYPE_DESCRIPTION]
     ,[SOH].[SALES_ORDER_TYPE] [SALES_ORDER_TYPE]
     ,[SOH].[TASK_ID] AS [TASK_ID]
     ,[SOH].[IS_POSTED_ERP] AS [IS_POSTED_ERP]
     ,[SOH].[ATTEMPTED_WITH_ERROR] AS [ATTEMPTED_WITH_ERROR]
     ,[SOH].[POSTED_RESPONSE] AS [POSTED_RESPONSE]
     ,[SOH].[POSTED_ERP] AS [POSTED_ERP]
     ,[SOH].[POSTED_DATETIME] AS [POSTED_DATETIME]
     ,[SOH].[LAST_UPDATE_IS_SENDING] AS [LAST_UPDATE_IS_SENDING]
    FROM @SALES_ORDER_HEADER_TOTALS [SOHT]
    INNER JOIN [PACASA].[SONDA_SALES_ORDER_HEADER] [SOH] WITH (NOLOCK)
      ON ([SOHT].[SALES_ORDER_ID] = [SOH].[SALES_ORDER_ID])

  --------------------------------------------------------
  ---Obtenemos los datos de las facturas.
  --------------------------------------------------------

  INSERT INTO @TEMP_DOCUMENT_HEADER ([ID], [DOC_SERIAL], [ROUTE], [CLIENT], [CLIENT_ID], [ASSIGNED_TO], [TOTAL_AMOUNT], [TOTAL_AMOUNT_WHIT_DISCOUNT], [UNIDADES_VENDIDAS], [SIGNATURE], [IMAGE], [EXPECTED_GPS], [Latitude], [Longitude], [CREATED_DATESTAMP], [CDF_SERIE], [CDF_RESOLUCION], [STATUS], [CLOSED_ROUTE_DATETIME], [IMAGE_1], [IMAGE_2], [DOC_ID], [DOC_TYPE], [DOC_TYPE_DESCRIPTION], [SALES_ORDER_TYPE], [TASK_ID], [IS_POSTED_ERP], [ATTEMPTED_WITH_ERROR], [POSTED_RESPONSE], [POSTED_ERP], [POSTED_DATETIME], [LAST_UPDATE_IS_SENDING], [TYPE_ACTION])
    SELECT
      [IH].[ID] AS [ID]
     ,[IH].[CDF_SERIE] AS [DOC_SERIAL]
     ,[IH].[POS_TERMINAL] AS [ROUTE]
     ,[IH].[CLIENT_ID] + ' ' + [IH].[CDF_NOMBRECLIENTE] AS [CLIENT]
     ,[IH].[CLIENT_ID]
     ,[IH].[POSTED_BY] AS [ASSIGNED_TO]
     ,[IH].[TOTAL_AMOUNT] AS [TOTAL_AMOUNT]
     ,[IH].[TOTAL_AMOUNT] AS [TOTAL_AMOUNT_WHIT_DISCOUNT]
     ,(SELECT
          SUM([QTY])
        FROM [PACASA].[SONDA_POS_INVOICE_DETAIL] [D] WITH (NOLOCK)
        WHERE [D].[ID] = [IH].[ID])
      AS [UNIDADES_VENDIDAS]
     ,NULL AS [SIGNATURE]
     ,NULL AS [IMAGE]
     ,[IH].[GPS_URL] AS [EXPECTED_GPS]
     ,SUBSTRING([IH].[GPS_URL], 1, CHARINDEX(',', [IH].[GPS_URL]) - 1) AS [Latitude]
     ,SUBSTRING([IH].[GPS_URL], CHARINDEX(',', [IH].[GPS_URL]) + 1, LEN([IH].[GPS_URL])) AS [Longitude]
     ,[IH].[INVOICED_DATETIME] AS [CREATED_DATESTAMP]
     ,[IH].[CDF_SERIE] AS [CDF_SERIE]
     ,[IH].[CDF_RESOLUCION] AS [CDF_RESOLUCION]
     ,[IH].[STATUS] AS [STATUS]
     ,[IH].[CLOSED_ROUTE_DATETIME] AS [CLOSED_ROUTE_DATETIME]
     ,[IH].[IMAGE_1] COLLATE DATABASE_DEFAULT AS [IMAGE_1]
     ,[IH].[IMAGE_2] COLLATE DATABASE_DEFAULT AS [IMAGE_2]
     ,CONVERT(VARCHAR(50), [IH].[INVOICE_ID]) AS [DOC_ID]
     ,'INVOICE' AS [DOC_TYPE]
     ,'Factura' AS [DOC_TYPE_DESCRIPTION]
     ,[IH].[TERMS] AS [SALES_ORDER_TYPE]
     ,[IH].[TASK_ID]
     ,[IH].[IS_POSTED_ERP]
     ,[IH].[ATTEMPTED_WITH_ERROR]
     ,[IH].[POSTED_RESPONSE]
     ,[IH].[POSTED_ERP]
     ,[IH].[POSTED_DATETIME]
     ,[IH].[LAST_UPDATE_IS_SENDING] AS [LAST_UPDATE_IS_SENDING]
     ,'SALE' AS [TYPE_ACTION]
    FROM [PACASA].[SONDA_POS_INVOICE_HEADER] [IH] WITH (NOLOCK)
    INNER JOIN @TASK_TEMP [TT]
      ON ([IH].[TASK_ID] = [TT].[TASK_ID])
    WHERE [IH].[ID] > 0
    AND [IH].[IS_READY_TO_SEND] = 1

  --------------------------------------------------------
  ---Obtenemos ya todos los datos del encabezado de la venta.
  --------------------------------------------------------

  SELECT DISTINCT
    --ROW_NUMBER() OVER (ORDER BY [DH].[POSTED_DATETIME]) [LINE_NUMBER]
    --[TT].[TASK_SEQ] AS [LINE_NUMBER]
    ROW_NUMBER() OVER (ORDER BY [TT].COMPLETED_STAMP ASC,[FC].[PRIORITY]) [LINE_NUMBER]
	,[FC].[PRIORITY] AS [SUGGESTED_ORDER]
   ,ISNULL([TT].TASK_ID, [DH].TASK_ID) AS TASK_ID
   ,ISNULL([TT].[ACCEPTED_STAMP], [DH].[POSTED_DATETIME]) [ACCEPTED_STAMP]
    ,CASE [TT].[POSTED_GPS]
      WHEN '0,0' THEN  SUBSTRING([TT].EXPECTED_GPS, 0, CHARINDEX(',', [TT].EXPECTED_GPS)) 
      ELSE ISNULL([DH].[Latitude], SUBSTRING([TT].EXPECTED_GPS, 0, CHARINDEX(',', [TT].EXPECTED_GPS))) 
    END AS [LATITUDE]
   --,ISNULL([DH].[Latitude], SUBSTRING([TT].EXPECTED_GPS, 0, CHARINDEX(',', [TT].EXPECTED_GPS))) [LATITUDE]
   --,ISNULL([DH].[Longitude], SUBSTRING([TT].EXPECTED_GPS, CHARINDEX(',', [TT].EXPECTED_GPS) + 1, LEN([TT].EXPECTED_GPS))) [LONGITUDE]
    ,CASE [TT].[POSTED_GPS]
      WHEN '0,0' THEN  SUBSTRING([TT].EXPECTED_GPS, CHARINDEX(',', [TT].EXPECTED_GPS) + 1, LEN([TT].EXPECTED_GPS))
      ELSE ISNULL([DH].[Longitude], SUBSTRING([TT].EXPECTED_GPS, CHARINDEX(',', [TT].EXPECTED_GPS) + 1, LEN([TT].EXPECTED_GPS)))
    END AS [LONGITUDE]
   ,ISNULL([DH].[ASSIGNED_TO], [TT].[ASSIGEND_TO]) AS ASSIGEND_TO
   ,[DH].[ASSIGNED_TO]
   ,[TT].[ASSIGEND_TO]
   ,ISNULL([TT].[TASK_COMMENTS], 'Sin Comentario') [TASK_COMMENTS]
   ,ISNULL([DH].[CLIENT], [TT].COSTUMER_CODE) [CODE_CUSTOMER]
   ,[C].[NAME_CUSTOMER] [CUSTOMER_NAME]
   ,ISNULL([C].[ADRESS_CUSTOMER], '') [TASK_ADDRESS]
   ,ISNULL([TT].[COMPLETED_STAMP], [DH].[POSTED_DATETIME]) [COMPLETED_STAMP]
   ,[DH].[TOTAL_AMOUNT]
   ,ISNULL([DH].TOTAL_AMOUNT_WHIT_DISCOUNT, DH.TOTAL_AMOUNT) AS TOTAL_AMOUNT_WHIT_DISCOUNT
   ,[TT].COMPLETED_STAMP
   ,[TT].ACCEPTED_STAMP
   ,ISNULL([TT].REASON, 'ASIGNADO') AS REASON
   ,[TT].EXPECTED_GPS
   ,[TT].POSTED_GPS
   ,[TT].TASK_ID
   ,(SELECT TOP 1
        SYMBOL_CURRENCY
      FROM [PACASA].SWIFT_CURRENCY
      WHERE IS_DEFAULT = 1)
    AS SYMBOL_CURRENCY
   ,CASE
      WHEN [TT].REASON IS NULL THEN 'NARANJA'
      ELSE (SELECT
            [PACASA].[SWIFT_FN_GET_KPI]([PACASA].SWIFT_CALCULATE_DISTANCE([TT].EXPECTED_GPS, [TT].POSTED_GPS, 'M'), @ASSIGNED_TO, 'SALES_DISTANCE', CASE
              WHEN [DH].[TOTAL_AMOUNT] IS NULL THEN 'WITHOUT_SALE'
              ELSE 'SALE'
            END))
    END AS KPI_COLOR
   ,(SELECT
        [PACASA].[SWIFT_FN_GET_KPI]([PACASA].SWIFT_CALCULATE_DISTANCE([TT].EXPECTED_GPS, [TT].POSTED_GPS, 'M'), @ASSIGNED_TO, 'SALES_DISTANCE', CASE
          WHEN [DH].[TOTAL_AMOUNT] <= 0 THEN 'WITHOUT_SALE'
          ELSE 'SALE'
        END))
    AS COLOR
   ,CASE
      WHEN [PACASA].SWIFT_CALCULATE_DISTANCE([TT].EXPECTED_GPS, [TT].POSTED_GPS, 'K') <= 0 THEN CONVERT(VARCHAR(50), 0) + 'km.'
      ELSE CASE
          WHEN [PACASA].SWIFT_CALCULATE_DISTANCE([TT].EXPECTED_GPS, [TT].POSTED_GPS, 'K') < 1 THEN CONVERT(VARCHAR(50), [PACASA].SWIFT_CALCULATE_DISTANCE([TT].EXPECTED_GPS, [TT].POSTED_GPS, 'M')) + 'm.'
          ELSE CONVERT(VARCHAR(50), [PACASA].SWIFT_CALCULATE_DISTANCE([TT].EXPECTED_GPS, [TT].POSTED_GPS, 'k')) + 'km.'
        END
    END AS DIFERENCE
   ,CONVERT(VARCHAR(3), DATEDIFF(s, [TT].ACCEPTED_STAMP, [TT].COMPLETED_STAMP) / 3600) + ':' + CONVERT(VARCHAR(3), DATEDIFF(s, [TT].ACCEPTED_STAMP, [TT].COMPLETED_STAMP) % 3600 / 60) + ':' + CONVERT(VARCHAR(3), (DATEDIFF(s, [TT].ACCEPTED_STAMP, [TT].COMPLETED_STAMP) % 60)) AS DELAY_TIME   
   ,[C].[SPECIAL_MARKER]
  FROM @TASK_TEMP [TT]
  LEFT JOIN @TEMP_DOCUMENT_HEADER [DH]
    ON ([TT].TASK_ID = DH.TASK_ID)
  INNER JOIN [PACASA].[SWIFT_VIEW_ALL_COSTUMER] [C]
    ON ([TT].[COSTUMER_CODE] = [C].[CODE_CUSTOMER])
   LEFT JOIN [PACASA].[SWIFT_FREQUENCY_X_CUSTOMER] [FC]
   ON  ([TT].[COSTUMER_CODE] = [FC].[CODE_CUSTOMER])
  ORDER BY [LINE_NUMBER] 

END