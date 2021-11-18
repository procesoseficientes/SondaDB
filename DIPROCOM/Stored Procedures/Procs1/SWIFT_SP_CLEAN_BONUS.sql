﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	01-Jun-17 @ A-TEAM Sprint Jibade 
-- Description:			

/*
-- Ejemplo de Ejecucion:
				EXEC [acsa].[SWIFT_SP_CLEAN_BONUS]
*/
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_CLEAN_BONUS]
AS
BEGIN
	SET NOCOUNT ON;
	--
	DELETE D2
	FROM [acsa].[SONDA_SALES_ORDER_DETAIL] [D1]
	INNER JOIN [acsa].[SONDA_SALES_ORDER_HEADER] [H] ON ([H].[SALES_ORDER_ID] = [D1].[SALES_ORDER_ID])
	INNER JOIN [acsa].[SONDA_SALES_ORDER_DETAIL] [D2] ON (
		[D2].[SALES_ORDER_ID] = [D1].[SALES_ORDER_ID]
		AND [D2].[SKU] = [D1].[SKU]
		AND [D2].[QTY] = [D1].[QTY]
		AND [D2].[IS_BONUS] != [D1].[IS_BONUS]
	)
	WHERE [H].[SALES_ORDER_ID] > 0
		AND [H].[IS_READY_TO_SEND] = 1
		AND [D1].[IS_BONUS] = 0
		AND [D2].[IS_BONUS] = 1
		AND [H].[POSTED_DATETIME] >= FORMAT(GETDATE(),
											'yyyyMMdd')
		AND ISNULL([H].[IS_POSTED_ERP], 0) = 0
		AND [D1].[SKU] NOT IN (
		SELECT DISTINCT [CODE_SKU]
		FROM [acsa].[SWIFT_TRADE_AGREEMENT_SKU_BY_BONUS_RULE]
		UNION
		SELECT DISTINCT [CODE_SKU_BONUS]
		FROM [acsa].[SWIFT_TRADE_AGREEMENT_BONUS_BY_MULTIPLE]
		UNION
		SELECT DISTINCT [CODE_SKU_BONUS]
		FROM [acsa].[SWIFT_TRADE_AGREEMENT_BONUS]);
END