﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	09-Feb-17 @ A-TEAM Sprint Chatuluka 
-- Description:			SP que obtiene las bonificaciones del combo en el acuerdo comercial

-- Modificacion 27-Mar-17 @ A-Team Sprint Fenyang
					-- alberto.ruiz
					-- Se Agrego campo IS_MULTIPLE

/*
-- Ejemplo de Ejecucion:
				EXEC [DIPROCOM].[SWIFT_SP_GET_TRADE_AGREEMENT_SKU_BY_BONUS_RULE]
					@TRADE_AGREEMENT_ID = 1043
					,@COMBO_ID = 1003
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_TRADE_AGREEMENT_SKU_BY_BONUS_RULE](
	@TRADE_AGREEMENT_ID INT
	,@COMBO_ID INT
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT
		[S].[CODE_SKU]
		,[S].[DESCRIPTION_SKU]
		,[PU].[PACK_UNIT]
		,[PU].[CODE_PACK_UNIT]
		,[PU].[DESCRIPTION_PACK_UNIT]
		,[CRS].[QTY]
		,[FS].[FAMILY_SKU]
		,[FS].[CODE_FAMILY_SKU]
		,[FS].[DESCRIPTION_FAMILY_SKU]
		,[CRS].[IS_MULTIPLE]
	FROM [DIPROCOM].[SWIFT_VIEW_ALL_SKU] [S]
	INNER JOIN [DIPROCOM].[SWIFT_TRADE_AGREEMENT_SKU_BY_BONUS_RULE] [CRS] ON (
		[CRS].[CODE_SKU] = [S].[CODE_SKU]
	)
	INNER JOIN [DIPROCOM].[SONDA_PACK_UNIT] [PU] ON (
		[PU].[PACK_UNIT] = [CRS].[PACK_UNIT]
	)
	INNER JOIN [DIPROCOM].[SWIFT_TRADE_AGREEMENT_BY_COMBO_BONUS_RULE] [CR] ON(
		[CR].[TRADE_AGREEMENT_BONUS_RULE_BY_COMBO_ID] = [CRS].[TRADE_AGREEMENT_BONUS_RULE_BY_COMBO_ID]
	)
	INNER JOIN [DIPROCOM].[SWIFT_TRADE_AGREEMENT_BY_BONUS_RULE] [TAR] ON (
		[TAR].[TRADE_AGREEMENT_BONUS_RULE_BY_COMBO_ID] = [CR].[TRADE_AGREEMENT_BONUS_RULE_BY_COMBO_ID]
	)
	LEFT JOIN [DIPROCOM].[SWIFT_FAMILY_SKU] [FS] ON (
		[FS].[CODE_FAMILY_SKU] = [S].[CODE_FAMILY_SKU]
	)
	WHERE [TAR].[TRADE_AGREEMENT_ID] = @TRADE_AGREEMENT_ID
		AND [CR].[COMBO_ID] = @COMBO_ID
END



