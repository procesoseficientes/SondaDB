﻿CREATE PROCEDURE [acsa].[SWIFT_SP_VALIDATE_SALES_ACC]
AS
BEGIN
 SET NOCOUNT ON;

DECLARE @SalesId INT 

SELECT TOP 1 @SalesId=SALES_ORDER_ID FROM [acsa].SONDA_SALES_ORDER_HEADER WITH (NOLOCK)
WHERE posted_datetime >= format (getdate(),'yyyyMMdd') 
	AND IS_READY_TO_SEND = 1 
	AND IS_VOID = 0 
	AND AUTHORIZED_BY IS NULL
	ORDER BY 1 desc

SELECT
  [H].[SALES_ORDER_ID]
  ,H.posted_by
  ,[D1].[SKU] SKU_D1
  ,[D2].[SKU] SKU_D2
  ,[D1].[QTY] QTY_D1
  ,[D2].[QTY] QTY_D2
  ,[D1].[PRICE] PRICE_D1
  ,[D2].[PRICE] PRICE_D2
  ,[D1].[TOTAL_LINE] TOTAL_LINE_D1
  ,[D2].[TOTAL_LINE] TOTAL_LINE_D2
  ,[D1].[IS_BONUS] IS_BONUS_D1
  ,[D2].[IS_BONUS] IS_BONUS_D2
INTO #PENDIENTE
FROM [acsa].[SONDA_SALES_ORDER_DETAIL] [D1] WITH (NOLOCK)
INNER JOIN [acsa].[SONDA_SALES_ORDER_HEADER] [H] ON ([H].[SALES_ORDER_ID] = [D1].[SALES_ORDER_ID])
INNER JOIN [acsa].[SONDA_SALES_ORDER_DETAIL]  [D2] ON (
  [D2].[SALES_ORDER_ID] = [D1].[SALES_ORDER_ID]
  AND [D2].[SKU] = [D1].[SKU]
  AND [D2].[QTY] = [D1].[QTY]
  AND [D2].[IS_BONUS] != [D1].[IS_BONUS]
)
WHERE [H].[POSTED_DATETIME] >= format (getdate(),'yyyyMMdd')
AND [H].[SALES_ORDER_ID] <=@SalesId
AND [H].[IS_READY_TO_SEND] = 1
AND [D1].[IS_BONUS] = 0
AND [D2].[IS_BONUS] = 1
AND ISNULL([H].[IS_POSTED_ERP], 0) = 0
AND AUTHORIZED_BY IS NULL
AND [D1].[SKU] NOT IN (
SELECT DISTINCT [CODE_SKU] FROM [acsa].[SWIFT_TRADE_AGREEMENT_SKU_BY_BONUS_RULE]
UNION
SELECT DISTINCT [CODE_SKU_BONUS] FROM [acsa].[SWIFT_TRADE_AGREEMENT_BONUS_BY_MULTIPLE]
UNION
SELECT DISTINCT [CODE_SKU_BONUS] FROM [acsa].[SWIFT_TRADE_AGREEMENT_BONUS]
)

UPDATE [acsa].SONDA_SALES_ORDER_HEADER
	SET AUTHORIZED_BY = '1'
	WHERE posted_datetime >= format (getdate(),'yyyyMMdd') 
	AND IS_READY_TO_SEND = 1 
	AND IS_VOID = 0 
	AND AUTHORIZED_BY IS NULL
	AND SALES_ORDER_ID NOT IN (SELECT DISTINCT SALES_ORDER_ID FROM #PENDIENTE)
  AND SALES_ORDER_ID<=@SalesId

END
