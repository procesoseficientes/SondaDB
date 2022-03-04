﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	09-Feb-17 @ A-TEAM Sprint Chatuluka
-- Description:			SP que obtiene la informacion del combo en el acuerdo comercial

/*
-- Ejemplo de Ejecucion:
				EXEC [acsa].[SWIFT_SP_GET_TRADE_AGREEMENT_BY_COMBO_BONUS_RULE]
					@TRADE_AGREEMENT_ID = 20
					,@COMBO_ID = 5
*/
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_GET_TRADE_AGREEMENT_BY_COMBO_BONUS_RULE](
	@TRADE_AGREEMENT_ID INT
	,@COMBO_ID INT
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT
		[TAR].[TRADE_AGREEMENT_BONUS_RULE_BY_COMBO_ID]
		,[TAR].[COMBO_ID]
		,[TAR].[BONUS_TYPE]
		,[TAR].[BONUS_SUB_TYPE]
		,[TAR].[IS_BONUS_BY_LOW_PURCHASE]
		,[TAR].[IS_BONUS_BY_COMBO]
		,[TAR].[LOW_QTY]
		,[TAB].[TRADE_AGREEMENT_ID]
	FROM [acsa].[SWIFT_TRADE_AGREEMENT_BY_COMBO_BONUS_RULE] [TAR]
	INNER JOIN [acsa].[SWIFT_TRADE_AGREEMENT_BY_BONUS_RULE] [TAB] ON (
		[TAB].[TRADE_AGREEMENT_BONUS_RULE_BY_COMBO_ID] = [TAR].[TRADE_AGREEMENT_BONUS_RULE_BY_COMBO_ID]
	)
	WHERE [TAB].[TRADE_AGREEMENT_ID] = @TRADE_AGREEMENT_ID
		AND [TAR].[COMBO_ID] = @COMBO_ID
END



