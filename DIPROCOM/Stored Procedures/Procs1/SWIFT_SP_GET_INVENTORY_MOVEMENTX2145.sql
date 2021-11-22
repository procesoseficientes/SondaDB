﻿CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_INVENTORY_MOVEMENTX2145] (
@fechaIncio DATETIME,
@fechaFINAL DATETIME
)
AS
BEGIN


 create table #TRANSACCIONES_INVE
 ([TXN_ID] [int] NOT NULL,
	[TXN_TYPE] [varchar](25) NULL,
	[TXN_CREATED_STAMP] [datetime] NULL,
	[TXN_CODE_SKU] [varchar](50) NULL,
	[TXN_DESCRIPTION_SKU] [varchar](250) NULL,
	[TXN_QTY] [numeric](18, 2) NULL,
	[TXN_SOURCE_PALLET_ID]  [int] null,
	[TXN_TARGET_PALLET_ID] [int] null
	)
	
	
	INSERT INTO #TRANSACCIONES_INVE
	 select   TXN_ID
    , TXN_TYPE
    , TXN_CREATED_STAMP
    , TXN_CODE_SKU AS SKU
    , TXN_DESCRIPTION_SKU AS SKU_DESCRIPTION
	, TXN_QTY
	,[TXN_SOURCE_PALLET_ID]
	,[TXN_TARGET_PALLET_ID]
	      FROM [PACASA].[SWIFT_TXNS]
	WHERE (TXN_TYPE = 'PUTAWAY' OR TXN_TYPE = 'INIT')
UNION ALL
 select   TXN_ID
    , TXN_TYPE
    , TXN_CREATED_STAMP
    , TXN_CODE_SKU AS SKU
    , TXN_DESCRIPTION_SKU AS SKU_DESCRIPTION
	, (TXN_QTY * -1 ) AS TXN_QTY
	,[TXN_SOURCE_PALLET_ID]
	,[TXN_TARGET_PALLET_ID]
      FROM [PACASA].[SWIFT_TXNS]
	WHERE (TXN_TYPE = 'PICKING')

	SELECT TXN_ID
	, TXN_TYPE
    , TXN_CREATED_STAMP
    , TXN_CODE_SKU AS SKU
    , TXN_DESCRIPTION_SKU AS SKU_DESCRIPTION
	, TXN_QTY AS QTY
	, ISNULL
	((SELECT SUM(TD.TXN_QTY) 
	  FROM #TRANSACCIONES_INVE TD		
        WHERE TD.TXN_CREATED_STAMP < TH.TXN_CREATED_STAMP
        AND TD.TXN_CODE_SKU = TH.TXN_CODE_SKU),0) AS SALDO_ANTERIOR	
	,ISNULL((SELECT SUM(TD.TXN_QTY)
        FROM #TRANSACCIONES_INVE TD		
        WHERE TD.TXN_CREATED_STAMP < TH.TXN_CREATED_STAMP
        AND TD.TXN_CODE_SKU = TH.TXN_CODE_SKU),0)
	+
	(TH.TXN_QTY) AS NUEVO_SALDO,
			[PT].[PALLET_ID]
		,[BT].[BATCH_SUPPLIER]
		,[BS].[BATCH_SUPPLIER_EXPIRATION_DATE]
	FROM  #TRANSACCIONES_INVE TH
	LEFT JOIN [PACASA].[SWIFT_PALLET] [PS] ON (
		[PS].[PALLET_ID] = [TH].[TXN_SOURCE_PALLET_ID]
	)
	LEFT JOIN [PACASA].[SWIFT_BATCH] [BS] ON (
		[BS].[BATCH_ID] = [PS].[BATCH_ID]
	)
	LEFT JOIN [PACASA].[SWIFT_PALLET] [PT] ON (
		[PT].[PALLET_ID] = [TH].[TXN_TARGET_PALLET_ID]
	)
	LEFT JOIN [PACASA].[SWIFT_BATCH] [BT] ON (
		[BT].[BATCH_ID] = [PT].[BATCH_ID]
	)
	WHERE TXN_CREATED_STAMP BETWEEN @fechaIncio AND @fechaFINAL
 ORDER BY TXN_CODE_SKU, TXN_CREATED_STAMP



 END
