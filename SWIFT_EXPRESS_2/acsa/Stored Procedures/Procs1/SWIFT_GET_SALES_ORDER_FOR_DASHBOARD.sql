﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	16-Dec-16 @ A-TEAM Sprint 6
-- Description:			

/*
-- Ejemplo de Ejecucion:
				EXEC [SONDA].[SWIFT_GET_SALES_ORDER_FOR_DASHBOARD]
*/
-- =============================================
CREATE PROCEDURE [SONDA].[SWIFT_GET_SALES_ORDER_FOR_DASHBOARD]
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT
		[SH].[POSTED_DATETIME]
		,CONVERT(NUMERIC(18,8),RTRIM(LTRIM(SUBSTRING([SH].[GPS_URL],1,CHARINDEX(',',[SH].[GPS_URL]) - 1)))) [LATITUDE_SALE_ORDER]
		,CONVERT(NUMERIC(18,8),RTRIM(LTRIM(SUBSTRING([SH].[GPS_URL],CHARINDEX(',',[SH].[GPS_URL]) + 1,LEN([SH].[GPS_URL]))))) [LONGITUDE_SALE_ORDER]
		,CASE [SH].[SALES_ORDER_TYPE]
			WHEN 'CASH' THEN 'CONTADO'
			WHEN 'CREDIT' THEN 'CREDITO'
			ELSE [SH].[SALES_ORDER_TYPE]
		END [SALES_ORDER_TYPE]
		,ISNULL([FS].[CODE_FAMILY_SKU],'No Aplica') [CODE_FAMILY_SKU]
		,ISNULL([FS].[DESCRIPTION_FAMILY_SKU],'No Aplica') [DESCRIPTION_FAMILY_SKU]
		,[S].[CODE_SKU]
		,[S].[DESCRIPTION_SKU]
		,[SD].[QTY]
		,[SD].[TOTAL_LINE]
		,[SH].[DISCOUNT] [DISCOUNT_TOTAL_LINE]
		,[SH].[TOTAL_AMOUNT]
		,CASE CAST([SH].[IS_VOID] AS VARCHAR)
			WHEN '1' THEN 'ANULADA'
			WHEN '0' THEN 'NO ANULADA'
			ELSE CAST([SH].[IS_VOID] AS VARCHAR)
		END [IS_VOID]
		,CASE 
			WHEN [SD].[DISCOUNT] > 0 THEN ([SD].[TOTAL_LINE] - (([SD].[TOTAL_LINE]*[SD].[DISCOUNT])/100))
			ELSE 0
		END [DISCOUNT]
		,CASE CAST(ISNULL([SD].[IS_BONUS],0) AS VARCHAR)
			WHEN '1' THEN 'BONIFICACION'
			WHEN '0' THEN 'VENTA'
			ELSE CAST([SD].[IS_BONUS] AS VARCHAR)
		END [IS_BONUS]
		,[C].[CODE_CUSTOMER]
		,[C].[NAME_CUSTOMER]
		,CONVERT(NUMERIC(18,8),[C].[LATITUDE]) [LATITUDE_CUSTOMER]
		,CONVERT(NUMERIC(18,8),[C].[LONGITUDE]) [LONGITUDE_CUSTOMER]
		,[U].[LOGIN]
		,[U].[NAME_USER]
		,[R].[CODE_ROUTE]
		,[R].[NAME_ROUTE]
		,[PU].[CODE_PACK_UNIT]
		,[PU].[DESCRIPTION_PACK_UNIT]
	FROM [SONDA].[SONDA_SALES_ORDER_HEADER] [SH]
	INNER JOIN [SONDA].[SONDA_SALES_ORDER_DETAIL] [SD] ON (
		[SD].[SALES_ORDER_ID] = [SH].[SALES_ORDER_ID]
	)
	INNER JOIN [SONDA].[SWIFT_VIEW_ALL_COSTUMER] [C] ON (
		[C].[CODE_CUSTOMER] = [SH].[CLIENT_ID]
	)
	INNER JOIN [SONDA].[USERS] [U] ON (
		[SH].[POSTED_BY] = [U].[LOGIN]
	)
	INNER JOIN [SONDA].[SWIFT_ROUTES] [R] ON (
		[R].[CODE_ROUTE] = [SH].[POS_TERMINAL]
	)
	INNER JOIN [SONDA].[SONDA_PACK_UNIT] [PU] ON (
		[PU].[CODE_PACK_UNIT] = [SD].[CODE_PACK_UNIT]
	)
	INNER JOIN [SONDA].[SWIFT_VIEW_ALL_SKU] [S] ON (
		[S].[CODE_SKU] = [SD].[SKU]
	)
	LEFT JOIN [SONDA].[SWIFT_FAMILY_SKU] [FS] ON (
		[FS].[CODE_FAMILY_SKU] = [S].[CODE_FAMILY_SKU]
	)
	WHERE [SH].[IS_DRAFT] = 0
END