﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	07-Feb-17 @ A-TEAM Sprint Chatuluka
-- Description:			SP que obtiene los productos sin venta minima del acuerdo comercial

/*
-- Ejemplo de Ejecucion:
				EXEC [DIPROCOM].[SWIFT_SP_GET_UNASSIGNED_SKU_FOR_MULTIPLE_SALES]
					@TRADE_AGREEMENT_ID = 43
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_UNASSIGNED_SKU_FOR_MULTIPLE_SALES](
	@TRADE_AGREEMENT_ID INT
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT
		ROW_NUMBER() OVER (ORDER BY [S].[CODE_SKU],[PU].[PACK_UNIT]) [ID]
		,[S].[CODE_SKU]
		,[S].[DESCRIPTION_SKU]
		,[PU].[PACK_UNIT]
		,[PU].[CODE_PACK_UNIT]
		,[PU].[DESCRIPTION_PACK_UNIT]
		,[FS].[FAMILY_SKU]
		,[FS].[CODE_FAMILY_SKU]
		,[FS].[DESCRIPTION_FAMILY_SKU]
	FROM [DIPROCOM].[SWIFT_VIEW_ALL_SKU] [S]
	LEFT JOIN [DIPROCOM].[SWIFT_FAMILY_SKU] [FS] ON (
		[FS].[CODE_FAMILY_SKU] = [S].[CODE_FAMILY_SKU]
	)
	INNER JOIN [DIPROCOM].[SONDA_PACK_CONVERSION] [PC] ON (
		[PC].[CODE_SKU] = [S].[CODE_SKU]
	)
	INNER JOIN [DIPROCOM].[SONDA_PACK_UNIT] [PU] ON (
		[PU].[CODE_PACK_UNIT] = [PC].[CODE_PACK_UNIT_FROM]
	)
	LEFT JOIN [DIPROCOM].[SWIFT_TRADE_AGREEMENT_SKU_SALES_BY_MULTIPLE] [TAS] ON (
		[TAS].[CODE_SKU] = [S].[CODE_SKU]
		AND [TAS].[PACK_UNIT] = [PU].[PACK_UNIT]
		AND [TAS].[TRADE_AGREEMENT_ID] = @TRADE_AGREEMENT_ID
	)
	WHERE [TAS].[TRADE_AGREEMENT_ID] IS NULL
	ORDER BY
		[S].[CODE_SKU]
		,[PU].[PACK_UNIT]
END


