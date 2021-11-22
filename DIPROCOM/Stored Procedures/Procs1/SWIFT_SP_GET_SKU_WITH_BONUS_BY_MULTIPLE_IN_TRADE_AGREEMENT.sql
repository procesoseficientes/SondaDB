﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	21-Nov-16 @ A-TEAM Sprint 5 
-- Description:			SP que obtiene las bonificaciones por acuerdo comercial

/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].[SWIFT_SP_GET_SKU_WITH_BONUS_BY_MULTIPLE_IN_TRADE_AGREEMENT]
					@TRADE_AGREEMENT_ID = 20
*/
-- =============================================
CREATE PROCEDURE [PACASA].SWIFT_SP_GET_SKU_WITH_BONUS_BY_MULTIPLE_IN_TRADE_AGREEMENT(
	@TRADE_AGREEMENT_ID INT
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT
		[M].[TRADE_AGREEMENT_BONUS_MULTIPLE_ID]
		,[M].[TRADE_AGREEMENT_ID]
		,[M].[CODE_SKU]
		,[S1].[DESCRIPTION_SKU]
		,[M].[PACK_UNIT]
		,[PU1].[DESCRIPTION_PACK_UNIT]
		,[M].[MULTIPLE]
		,[M].[CODE_SKU_BONUS]
		,[S2].[DESCRIPTION_SKU] [DESCRIPTION_SKU_BONUS]
		,[M].[PACK_UNIT_BONUS]
		,[PU2].[DESCRIPTION_PACK_UNIT] [DESCRIPTION_PACK_UNIT_BONUS]
		,[M].[BONUS_QTY]
	FROM [PACASA].[SWIFT_TRADE_AGREEMENT_BONUS_BY_MULTIPLE] [M]
	INNER JOIN [PACASA].[SWIFT_VIEW_ALL_SKU] [S1] ON (
		[S1].[CODE_SKU] = [M].[CODE_SKU]
	)
	INNER JOIN [PACASA].[SWIFT_VIEW_ALL_SKU] [S2] ON (
		[S2].[CODE_SKU] = [M].[CODE_SKU]
	)
	INNER JOIN [PACASA].[SONDA_PACK_UNIT] [PU1] ON (
		[PU1].[PACK_UNIT] = [M].[PACK_UNIT]
	)
	INNER JOIN [PACASA].[SONDA_PACK_UNIT] [PU2] ON (
		[PU2].[PACK_UNIT] = [M].[PACK_UNIT_BONUS]
	)
	WHERE [M].[TRADE_AGREEMENT_ID] = @TRADE_AGREEMENT_ID
END
