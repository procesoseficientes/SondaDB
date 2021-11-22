﻿-- =============================================
-- Autor:				rudi.garcia
-- Fecha de Creacion: 	013-09-2016 @ A-TEAM Sprint 1
-- Description:			Obtiene todos los producots con descuento asociados al acuerdo comercial

-- Modificacion 2/10/2017 @ A-Team Sprint Chatuluka
					-- rodrigo.gomez
					-- Se 
/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].SWIFT_SP_GET_SKU_WITH_DISCOUNT_IN_TRADE_AGREEMENT
					@TRADE_AGREEMENT_ID = 2
*/
-- =============================================
CREATE PROCEDURE [PACASA].SWIFT_SP_GET_SKU_WITH_DISCOUNT_IN_TRADE_AGREEMENT(
  @TRADE_AGREEMENT_ID INT
)
AS
BEGIN
	SELECT
		[TAD].[TRADE_AGREEMENT_DISCUOUNT_ID]
		,TAD.CODE_SKU
		,VS.DESCRIPTION_SKU
		,TAD.DISCOUNT
		,ISNULL(FS.CODE_FAMILY_SKU, 'N/A') AS CODE_FAMILY_SKU
		,ISNULL(FS.DESCRIPTION_FAMILY_SKU, 'N/A') AS DESCRIPTION_FAMILY_SKU    
		,[PU].[PACK_UNIT]
		,[PU].[CODE_PACK_UNIT]
		,[PU].[DESCRIPTION_PACK_UNIT]
		,[TAD].[HIGH_LIMIT]
		,[TAD].[LOW_LIMIT]
	FROM [PACASA].SWIFT_VIEW_ALL_SKU VS
		INNER JOIN [PACASA].SWIFT_TRADE_AGREEMENT_DISCOUNT TAD ON (
			VS.CODE_SKU = TAD.CODE_SKU
		)
		INNER JOIN [PACASA].[SONDA_PACK_UNIT] PU ON (
			[TAD].[PACK_UNIT] = [PU].[PACK_UNIT]
		)
		LEFT JOIN [PACASA].SWIFT_FAMILY_SKU FS ON (
			FS.CODE_FAMILY_SKU = VS.CODE_FAMILY_SKU
		)
	WHERE TAD.TRADE_AGREEMENT_ID = @TRADE_AGREEMENT_ID

END
