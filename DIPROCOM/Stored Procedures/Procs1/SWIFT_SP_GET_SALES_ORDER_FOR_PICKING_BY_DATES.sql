﻿-- =============================================
-- Autor:				rudi.garcia
-- Fecha de Creacion: 	04-Ene-2017 @ A-TEAM Sprint Balder
-- Description:			SP que obtiene los encabezados de la ordenes de venta por fechas y bodegas.

/*
-- Ejemplo de Ejecucion:
				EXEC [acsa].[SWIFT_SP_GET_SALES_ORDER_FOR_PICKING_BY_DATES]
					@STARTDATE '2016-01-01'
          , @ENDDATE '2017-01-01'
          , @LOGIN 'gerente@DIPROCOM'
				-- 
				
*/
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_GET_SALES_ORDER_FOR_PICKING_BY_DATES] (
  @STARTDATE DATETIME
  , @ENDDATE DATETIME
  , @LOGIN VARCHAR(50)
)
AS
BEGIN
  DECLARE @BODEGAS TABLE (
    CODE_WAREHOUSE VARCHAR(50)
  )

  INSERT INTO @BODEGAS (CODE_WAREHOUSE)
    SELECT
      WU.CODE_WAREHOUSE
    FROM [acsa].SWIFT_WAREHOUSE_BY_USER_WITH_ACCESS WU
    INNER JOIN [acsa].USERS U
      ON (
      U.CORRELATIVE = WU.USER_CORRELATIVE
      )
    WHERE U.LOGIN = @LOGIN

  SELECT
    SO.SALES_ORDER_ID   
   ,SO.DOC_SERIE
   ,SO.DOC_NUM
   ,SO.CLIENT_ID
   ,SO.POS_TERMINAL
   ,SO.POSTED_DATETIME    
   ,SO.WAREHOUSE AS CODE_WAREHOUSE
  FROM [acsa].SONDA_SALES_ORDER_HEADER SO
  INNER JOIN @BODEGAS B ON (
    B.CODE_WAREHOUSE = SO.WAREHOUSE
  )
  WHERE SO.POSTED_DATETIME BETWEEN @STARTDATE AND @ENDDATE
  AND SO.IS_DRAFT <> 1
  AND SO.HAVE_PICKING <> 1
  AND SO.IS_READY_TO_SEND=1
END


