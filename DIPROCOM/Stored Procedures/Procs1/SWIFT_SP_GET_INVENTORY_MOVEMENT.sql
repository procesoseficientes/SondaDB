﻿-- =============================================
-- Autor:					rudi.garcia
-- Fecha de Creacion: 		02-09-2016
-- Description:			    Obtiene el movimiento de sku 

/*
-- Ejemplo de Ejecucion:
				--
				EXEC [PACASA].[SWIFT_SP_GET_INVENTORY_MOVEMENT]
					@STAR_DATE = '01-01-2016'
					,@END_DATE = '09-02-2016'				
				--
*/
-- =============================================

CREATE PROCEDURE [PACASA].SWIFT_SP_GET_INVENTORY_MOVEMENT
@fechaIncio DATETIME,
@fechaFINAL DATETIME
AS
SELECT
      TXN_ID
    , TXN_TYPE
    , TXN_CREATED_STAMP
    , TXN_CODE_SKU AS SKU
    , TXN_DESCRIPTION_SKU AS SKU_DESCRIPTION
    , CASE TXN_TYPE
		WHEN 'INIT' THEN TXN_QTY
        WHEN 'PUTAWAY' THEN TXN_QTY
        WHEN 'PICKING' THEN (TXN_QTY * -1)
      END AS QTY
    , ISNULL((SELECT SUM(CASE TD.TXN_TYPE
					WHEN 'INIT' THEN TD.TXN_QTY
                    WHEN 'PUTAWAY' THEN TD.TXN_QTY
                    WHEN 'PICKING' THEN (TD.TXN_QTY * -1)END )
        FROM [PACASA].[SWIFT_TXNS] TD		
        WHERE TD.TXN_CREATED_STAMP < TH.TXN_CREATED_STAMP
        AND TD.TXN_CODE_SKU = TH.TXN_CODE_SKU),0) AS SALDO_ANTERIOR		
    , 
	ISNULL((SELECT SUM(CASE TD.TXN_TYPE
					WHEN 'INIT' THEN TD.TXN_QTY
                    WHEN 'PUTAWAY' THEN TD.TXN_QTY
                    WHEN 'PICKING' THEN (TD.TXN_QTY * -1)END )
        FROM [PACASA].[SWIFT_TXNS] TD		
        WHERE TD.TXN_CREATED_STAMP < TH.TXN_CREATED_STAMP
        AND TD.TXN_CODE_SKU = TH.TXN_CODE_SKU),0)
	+
	(CASE TH.TXN_TYPE
		WHEN 'INIT' THEN TH.TXN_QTY
		WHEN 'PUTAWAY' THEN TH.TXN_QTY
		WHEN 'PICKING' THEN (TH.TXN_QTY * -1)END) AS NUEVO_SALDO
  , CASE TH.TXN_TYPE
		  WHEN 'INIT' THEN PT.PALLET_ID
		  WHEN 'PUTAWAY' THEN PT.PALLET_ID
		  WHEN 'PICKING' THEN PS.PALLET_ID
    END AS PALLET_ID
   , CASE TH.TXN_TYPE
		  WHEN 'INIT' THEN BT.BATCH_SUPPLIER
		  WHEN 'PUTAWAY' THEN BT.BATCH_SUPPLIER
		  WHEN 'PICKING' THEN BS.BATCH_SUPPLIER
    END AS BATCH_SUPPLIER
  , CASE TH.TXN_TYPE
		  WHEN 'INIT' THEN BT.BATCH_SUPPLIER_EXPIRATION_DATE
		  WHEN 'PUTAWAY' THEN BT.BATCH_SUPPLIER_EXPIRATION_DATE
		  WHEN 'PICKING' THEN BS.BATCH_SUPPLIER_EXPIRATION_DATE
    END AS BATCH_SUPPLIER_EXPIRATION_DATE
 FROM [PACASA].[SWIFT_TXNS] TH
 LEFT JOIN [PACASA].SWIFT_PALLET PS ON (
  PS.PALLET_ID = TH.TXN_SOURCE_PALLET_ID
 )
 LEFT JOIN [PACASA].SWIFT_BATCH BS ON (
  BS.BATCH_ID = PS.BATCH_ID
 )
 LEFT JOIN [PACASA].SWIFT_PALLET PT ON (
  PT.PALLET_ID = TH.TXN_TARGET_PALLET_ID
 )
 LEFT JOIN [PACASA].SWIFT_BATCH BT ON (
  BT.BATCH_ID = PT.BATCH_ID
 )
 WHERE (TXN_TYPE = 'PUTAWAY' OR TXN_TYPE = 'PICKING' OR TXN_TYPE = 'INIT')
 AND TXN_CREATED_STAMP BETWEEN @fechaIncio AND @fechaFINAL
 ORDER BY TXN_CODE_SKU, TXN_CREATED_STAMP
