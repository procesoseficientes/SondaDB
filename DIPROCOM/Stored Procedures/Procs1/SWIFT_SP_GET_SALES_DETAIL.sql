﻿/*=======================================================
-- Author:         alejandro.ochoa
-- Create date:    17-08-2016
-- Description:    Genera la informacion del detalle de ventas con kpi
				   

-- EJEMPLO DE EJECUCION: 
		EXEC [acsa].[SWIFT_SP_GET_SALES_DETAIL]

=========================================================*/
CREATE PROCEDURE [acsa].SWIFT_SP_GET_SALES_DETAIL
AS
BEGIN
	
	DROP INDEX IDX_SALES_ROUTE ON [acsa].SWIFT_SALES_INDICATOR
	DROP INDEX IDX_SALES_DATE ON [acsa].SWIFT_SALES_INDICATOR

	DELETE FROM [acsa].SWIFT_SALES_INDICATOR 
	WHERE schedule_for= CAST(GETDATE() AS DATE)

	SELECT
		st.TASK_ID
		,st.COSTUMER_CODE
		,st.COSTUMER_NAME
		,st.SCHEDULE_FOR
		,st.EXPECTED_GPS
		,st.POSTED_GPS
		,st.ACCEPTED_STAMP
		,st.COMPLETED_STAMP
		,(cast(
			(cast(cast(st.completed_stamp as float) - cast(st.accepted_stamp as float) as int) * 24)
			+ datepart(hh, st.completed_stamp - st.accepted_stamp)
			as varchar(10))
		+ ':' + right('0' + cast(datepart(mi, st.completed_stamp - st.accepted_stamp) as varchar(2)), 2) 
		+ ':' + right('0' + cast(datepart(ss, st.completed_stamp - st.accepted_stamp) as varchar(2)), 2)) AS ELAPSED_TIME
		,st.TASK_STATUS
		,(CASE WHEN st.REASON IS NULL AND st.TASK_STATUS='ASSIGNED' THEN 'NO VISITADO' 
			   WHEN st.REASON IS NULL AND st.TASK_STATUS='ACCEPTED' THEN 'ACEPTADA SIN VISITA'
			   ELSE st.REASON END) as REASON
		,us.SELLER_ROUTE
		,st.ASSIGEND_TO
	INTO #Tasks
	FROM [acsa].SWIFT_TASKS st
	LEFT JOIN [acsa].USERS us ON st.ASSIGEND_TO = us.login
	WHERE SCHEDULE_FOR = CAST(GETDATE() AS DATE)

	SELECT
		ssoh.SALES_ORDER_ID
		,ssoh.TASK_ID
		,ssoh.GPS_URL AS POSTED_GPS
		,ssoh.POSTED_DATETIME as SALES_ORDER_DATE
		,ssoh.DOC_SERIE
		,ssoh.DOC_NUM
		,ssoh.TOTAL_AMOUNT
		,ssoh.DISCOUNT
		,(ssoh.TOTAL_AMOUNT*ssoh.DISCOUNT/100) AS DISCOUNT_AMOUNT
		,ssod.SKU
		,svas.DESCRIPTION_SKU
		,svas.CODE_FAMILY_SKU
		,ssf.DESCRIPTION_FAMILY_SKU
		,ssod.QTY
		,ssod.PRICE
		,ssod.TOTAL_LINE
		,(ssod.TOTAL_LINE*ssoh.DISCOUNT/100) AS DISCOUNT_LINE
	INTO #SalesOrder
	FROM [acsa].SONDA_SALES_ORDER_HEADER ssoh
	LEFT JOIN [acsa].SONDA_SALES_ORDER_DETAIL ssod ON ssoh.SALES_ORDER_ID = ssod.SALES_ORDER_ID
	LEFT JOIN [acsa].SWIFT_VIEW_ALL_SKU svas ON svas.CODE_SKU = ssod.SKU
	LEFT JOIN [acsa].[SWIFT_SKU_FAMILY] ssf ON ssf.CODE_FAMILY_SKU = svas.CODE_FAMILY_SKU
	WHERE ssoh.IS_DRAFT=0 AND CAST(ssoh.POSTED_DATETIME AS DATE) = CAST(GETDATE() AS DATE)
	AND ssoh.IS_READY_TO_SEND=1

	INSERT INTO [acsa].SWIFT_SALES_INDICATOR ([TASK_ID]
      ,[COSTUMER_CODE]
      ,[COSTUMER_NAME]
      ,[SCHEDULE_FOR]
      ,[EXPECTED_GPS]
      ,[POSTED_GPS]
      ,[DISTANCE]
      ,[KPI]
      ,[ACCEPTED_STAMP]
      ,[COMPLETED_STAMP]
      ,[ELAPSED_TIME]
      ,[TASK_STATUS]
      ,[SELLER_ROUTE]
      ,[NOSALES_REASON]
      ,[SALES_ORDER_ID]
      ,[SALES_ORDER_DATE]
      ,[DOC_SERIE]
      ,[DOC_NUM]
      ,[TOTAL_AMOUNT]
      ,[DISCOUNT]
      ,[DISCOUNT_AMOUNT]
      ,[TOTAL_CD]
      ,[SKU]
      ,[DESCRIPTION_SKU]
      ,[CODE_FAMILY_SKU]
      ,[DESCRIPTION_FAMILY_SKU]
      ,[QTY]
	  ,[PRICE]
      ,[TOTAL_LINE]
	  ,[DISCOUNT_LINE] 
	  ,[TOTAL_LINE_CD])
	select
		st.TASK_ID
		,st.COSTUMER_CODE
		,st.COSTUMER_NAME
		,st.SCHEDULE_FOR
		,st.EXPECTED_GPS
		,ISNULL(ssoh.POSTED_GPS,st.POSTED_GPS) AS POSTED_GPS
		,[acsa].[SWIFT_CALCULATE_DISTANCE] (st.EXPECTED_GPS,ISNULL(ssoh.POSTED_GPS,st.POSTED_GPS),'M') as DISTANCE
		,ISNULL([acsa].[SWIFT_FN_GET_KPI] 
			([acsa].[SWIFT_CALCULATE_DISTANCE] (st.EXPECTED_GPS,ISNULL(ssoh.POSTED_GPS,st.POSTED_GPS),'M'),
			st.SELLER_ROUTE,'SALES_DISTANCE',CASE WHEN ISNULL(ssoh.TOTAL_AMOUNT,0)>0 THEN 'SALE' ELSE 'WITHOUT_SALE' END),'INDEFINIDO') AS KPI
		,st.ACCEPTED_STAMP
		,st.COMPLETED_STAMP
		,CAST(CASE WHEN ISNULL(st.ELAPSED_TIME,'00:00:00') LIKE '-%' THEN SUBSTRING(st.ELAPSED_TIME,2,LEN(st.ELAPSED_TIME)) ELSE ISNULL(st.ELAPSED_TIME,'00:00:00') END as TIME) as ELAPSED_TIME
		,st.TASK_STATUS
		,st.SELLER_ROUTE
		,st.REASON
		,ssoh.SALES_ORDER_ID
		,ssoh.SALES_ORDER_DATE
		,ssoh.DOC_SERIE
		,ssoh.DOC_NUM
		,ssoh.TOTAL_AMOUNT
		,ssoh.DISCOUNT
		,ssoh.DISCOUNT_AMOUNT
		,(ssoh.TOTAL_AMOUNT-ssoh.DISCOUNT_AMOUNT) AS TOTAL_CD
		,ssoh.SKU
		,ssoh.DESCRIPTION_SKU
		,ssoh.CODE_FAMILY_SKU
		,ssoh.DESCRIPTION_FAMILY_SKU
		,ssoh.QTY
		,ssoh.PRICE
		,ssoh.TOTAL_LINE
		,ssoh.DISCOUNT_LINE
		,(ssoh.TOTAL_LINE-ssoh.DISCOUNT_LINE) AS TOTAL_LINE_CD
	from #Tasks st
	left join #SalesOrder ssoh ON ssoh.TASK_ID = st.TASK_ID

	CREATE INDEX IDX_SALES_ROUTE ON [acsa].SWIFT_SALES_INDICATOR ([SELLER_ROUTE])
	CREATE INDEX IDX_SALES_DATE ON [acsa].SWIFT_SALES_INDICATOR (SCHEDULE_FOR)

END
