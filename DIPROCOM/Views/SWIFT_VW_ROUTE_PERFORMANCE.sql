﻿
-- =============================================
-- Autor:					alejandro.oochoa
-- Fecha de Creacion: 		11-12-2017
-- Description:			    Vista de acceso a datos del Reporte Performance de Ruta
/*
-- Ejemplo de Ejecucion:
	SELECT * FROM [SONDA].SWIFT_VW_ROUTE_PERFORMANCE 
*/
-- =============================================
CREATE VIEW [SONDA].[SWIFT_VW_ROUTE_PERFORMANCE] 
AS
	SELECT
      SI.TASK_ID
      ,SI.COSTUMER_CODE
      ,SI.COSTUMER_NAME
      ,SI.SCHEDULE_FOR
      ,SI.EXPECTED_GPS
      ,SI.POSTED_GPS
      ,SI.DISTANCE
      ,SI.KPI
      ,SI.ACCEPTED_STAMP
      ,SI.COMPLETED_STAMP
      ,SI.ELAPSED_TIME
      ,SI.TASK_STATUS
      ,SI.SELLER_ROUTE
      ,SI.NOSALES_REASON
      ,SI.SALES_ORDER_ID
      ,SI.SALES_ORDER_DATE
      ,SI.DOC_SERIE
      ,SI.DOC_NUM
      ,ISNULL(SI.TOTAL_AMOUNT, 0) AS TOTAL_AMOUNT
      ,ISNULL(SI.DISCOUNT, 0) AS DISCOUNT
      ,ISNULL(SI.DISCOUNT_AMOUNT, 0) AS DISCOUNT_AMOUNT
      ,ISNULL(SI.TOTAL_CD, 0) AS TOTAL_CD
      ,SI.SKU
      ,SI.DESCRIPTION_SKU
      ,SI.CODE_FAMILY_SKU
      ,SI.DESCRIPTION_FAMILY_SKU
      ,SI.QTY
      ,ISNULL(SI.PRICE, 0) AS PRICE
      ,ISNULL(SI.TOTAL_LINE, 0) AS TOTAL_LINE
      ,ISNULL(SI.DISCOUNT_LINE, 0) AS DISCOUNT_LINE
      ,ISNULL(SI.TOTAL_LINE_CD, 0) AS TOTAL_LINE_CD
    FROM [SONDA].SWIFT_SALES_INDICATOR SI
	


