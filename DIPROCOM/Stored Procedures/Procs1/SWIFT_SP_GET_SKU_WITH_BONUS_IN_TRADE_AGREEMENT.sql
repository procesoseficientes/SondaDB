﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	20-09-2016 @ A-TEAM Sprint 1
-- Description:			SP que obtiene todos las bonificaciones de un acuerdo comercial

/*
-- Ejemplo de Ejecucion:
				EXEC [DIPROCOM].SWIFT_SP_GET_SKU_WITH_BONUS_IN_TRADE_AGREEMENT
					@TRADE_AGREEMENT_ID = 21
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].SWIFT_SP_GET_SKU_WITH_BONUS_IN_TRADE_AGREEMENT(
	@TRADE_AGREEMENT_ID INT
)
AS
BEGIN
	SELECT
		TAB.TRADE_AGREEMENT_BONUS_ID
		,TAB.TRADE_AGREEMENT_ID
		,TAB.CODE_SKU
		,S1.DESCRIPTION_SKU
		,TAB.PACK_UNIT
		,PU1.DESCRIPTION_PACK_UNIT
		,TAB.LOW_LIMIT
		,TAB.HIGH_LIMIT
		,TAB.CODE_SKU_BONUS
		,S2.DESCRIPTION_SKU DESCRIPTION_SKU_BONUS
		,TAB.PACK_UNIT_BONUS
		,PU2.DESCRIPTION_PACK_UNIT DESCRIPTION_PACK_UNIT_BONUS
		,TAB.BONUS_QTY
	FROM [DIPROCOM].SWIFT_TRADE_AGREEMENT_BONUS TAB
	INNER JOIN [DIPROCOM].SWIFT_VIEW_ALL_SKU S1 ON (
		TAB.CODE_SKU = S1.CODE_SKU
	)
	INNER JOIN [DIPROCOM].SONDA_PACK_UNIT PU1 ON (
		TAB.PACK_UNIT = PU1.PACK_UNIT
	)
	INNER JOIN [DIPROCOM].SWIFT_VIEW_ALL_SKU S2 ON (
		TAB.CODE_SKU_BONUS = S2.CODE_SKU
	)
	INNER JOIN [DIPROCOM].SONDA_PACK_UNIT PU2 ON (
		TAB.PACK_UNIT_BONUS = PU2.PACK_UNIT
	)
	WHERE TAB.TRADE_AGREEMENT_ID = @TRADE_AGREEMENT_ID
END
