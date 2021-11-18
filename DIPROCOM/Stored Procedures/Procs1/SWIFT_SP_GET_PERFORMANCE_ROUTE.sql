﻿-- =============================================
-- Autor:					rudi.garcia
-- Fecha de Creacion: 		02-09-2016
-- Description:			    Obtine el performance de las rutas

/*
-- Ejemplo de Ejecucion:
				--
				EXEC [acsa].[SWIFT_SP_GET_PERFORMANCE_ROUTE]
					@STAR_DATE = '01-01-2016' --'20160701'
					,@END_DATE = '09-02-2016'--'20160902'
					,@CODE_ROUTE = 'RUDI@DIPROCOM'
				--
*/
-- =============================================
CREATE PROCEDURE [acsa].SWIFT_SP_GET_PERFORMANCE_ROUTE (
	@STAR_DATE DATETIME
	,@END_DATE DATETIME
	,@CODE_ROUTE VARCHAR(4000)
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	DECLARE 
    @DELIMITER CHAR(1)
		,@QUERY NVARCHAR(2000)		
		,@DEFAULT_DISPLAY_DECIMALS INT
	
	-- ------------------------------------------------------------------------------------
	-- Coloca parametros iniciales
	--------------------------------------------------------------------------------------
	SELECT
    @DELIMITER = [acsa].SWIFT_FN_GET_PARAMETER('DELIMITER','DEFAULT_DELIMITER')
		,@DEFAULT_DISPLAY_DECIMALS = [acsa].[SWIFT_FN_GET_PARAMETER]('CALCULATION_RULES','DEFAULT_DISPLAY_DECIMALS')

	-- ------------------------------------------------------------------------------------
	-- Obtiene las rutas a filtrar
	-- ------------------------------------------------------------------------------------
	SELECT 
		[R].[CODE_ROUTE]
		,[R].[NAME_ROUTE]
	INTO #ROUTE
	FROM [acsa].[Split](@CODE_ROUTE,@DELIMITER) [S]
	INNER JOIN [acsa].[SWIFT_ROUTES] [R] ON (
		[S].[Data] = [R].[CODE_ROUTE]
	)
	
	-- ------------------------------------------------------------------------------------
	-- Muestra el resultado
	-- ------------------------------------------------------------------------------------

  SET @QUERY = N'
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
      ,ISNULL(CONVERT(DECIMAL(18,' + CAST(@DEFAULT_DISPLAY_DECIMALS AS VARCHAR) + '),[acsa].[SWIFT_FN_GET_DISPLAY_NUMBER](SI.TOTAL_AMOUNT)), 0) AS TOTAL_AMOUNT
      ,ISNULL(CONVERT(DECIMAL(18,' + CAST(@DEFAULT_DISPLAY_DECIMALS AS VARCHAR) + '),[acsa].[SWIFT_FN_GET_DISPLAY_NUMBER](SI.DISCOUNT)), 0) AS DISCOUNT
      ,ISNULL(CONVERT(DECIMAL(18,' + CAST(@DEFAULT_DISPLAY_DECIMALS AS VARCHAR) + '),[acsa].[SWIFT_FN_GET_DISPLAY_NUMBER](SI.DISCOUNT_AMOUNT)), 0) AS DISCOUNT_AMOUNT
      ,ISNULL(CONVERT(DECIMAL(18,' + CAST(@DEFAULT_DISPLAY_DECIMALS AS VARCHAR) + '),[acsa].[SWIFT_FN_GET_DISPLAY_NUMBER](SI.TOTAL_CD)), 0) AS TOTAL_CD
      ,SI.SKU
      ,SI.DESCRIPTION_SKU
      ,SI.CODE_FAMILY_SKU
      ,SI.DESCRIPTION_FAMILY_SKU
      ,SI.QTY
      ,ISNULL(CONVERT(DECIMAL(18,' + CAST(@DEFAULT_DISPLAY_DECIMALS AS VARCHAR) + '),[acsa].[SWIFT_FN_GET_DISPLAY_NUMBER](SI.PRICE)), 0) AS PRICE
      ,ISNULL(CONVERT(DECIMAL(18,' + CAST(@DEFAULT_DISPLAY_DECIMALS AS VARCHAR) + '),[acsa].[SWIFT_FN_GET_DISPLAY_NUMBER](SI.TOTAL_LINE)), 0) AS TOTAL_LINE
      ,ISNULL(CONVERT(DECIMAL(18,' + CAST(@DEFAULT_DISPLAY_DECIMALS AS VARCHAR) + '),[acsa].[SWIFT_FN_GET_DISPLAY_NUMBER](SI.DISCOUNT_LINE)), 0) AS DISCOUNT_LINE
      ,ISNULL(CONVERT(DECIMAL(18,' + CAST(@DEFAULT_DISPLAY_DECIMALS AS VARCHAR) + '),[acsa].[SWIFT_FN_GET_DISPLAY_NUMBER](SI.TOTAL_LINE_CD)), 0) AS TOTAL_LINE_CD
      ,ISNULL(' + CAST(@DEFAULT_DISPLAY_DECIMALS AS VARCHAR) +', 0) AS DEFAULT_DISPLAY_DECIMALS
    FROM [acsa].SWIFT_SALES_INDICATOR SI
    INNER JOIN #ROUTE R ON (
      R.CODE_ROUTE = SI.SELLER_ROUTE
    )
    WHERE SI.SCHEDULE_FOR BETWEEN CONVERT(DATE, ''' + CONVERT(VARCHAR, @STAR_DATE, 110) + ''' ) AND CONVERT(DATE, ''' + CONVERT(VARCHAR, @END_DATE, 110) + ''' )  
  '
	--
	PRINT '----> @QUERY: ' + @QUERY
	--
	EXEC(@QUERY)
	--
	PRINT '----> DESPUES DE @QUERY'
END
