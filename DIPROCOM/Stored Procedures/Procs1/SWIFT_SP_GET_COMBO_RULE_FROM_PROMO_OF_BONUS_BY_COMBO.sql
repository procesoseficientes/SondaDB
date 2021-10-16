﻿-- =============================================
-- Autor:				hector.gonzalez
-- Fecha de Creacion: 	18/07/2017 @ A-TEAM Sprint Beareitung 
-- Description:			Obtiene las reglas de un combo por su @PROMO_RULE_BY_COMBO_ID

/*
-- Ejemplo de Ejecucion:
				EXEC [DIPROCOM].[SWIFT_SP_GET_COMBO_RULE_FROM_PROMO_OF_BONUS_BY_COMBO]
					@PROMO_RULE_BY_COMBO_ID = 23
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_COMBO_RULE_FROM_PROMO_OF_BONUS_BY_COMBO](
	@PROMO_RULE_BY_COMBO_ID INT = NULL	
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT [PCPR].[PROMO_RULE_BY_COMBO_ID]
			,[COMBO_ID]
			,[BONUS_TYPE]
			,[BONUS_SUB_TYPE]
			,[IS_BONUS_BY_LOW_PURCHASE]
			,[IS_BONUS_BY_COMBO]
			,[LOW_QTY] 
	FROM [DIPROCOM].[SWIFT_PROMO_BY_COMBO_PROMO_RULE] [PCPR] 
	WHERE PCPR.PROMO_RULE_BY_COMBO_ID = @PROMO_RULE_BY_COMBO_ID
END
