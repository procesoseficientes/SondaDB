﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	08-Feb-17 @ A-TEAM Sprint Chatuluka 
-- Description:			SP que actualiza la bonificacion por combo

/*
-- Ejemplo de Ejecucion:
				EXEC [acsa].[SWIFT_SP_UPDATE_TRADE_AGREEMENT_BY_COMBO_BONUS_RULE]
					@TRADE_AGREEMENT_BONUS_RULE_BY_COMBO_ID = 2
					,@COMBO_ID = 1
					,@BONUS_SUB_TYPE = 'MULTIPLE'
					,@IS_BONUS_BY_LOW_PURCHASE = 0
					,@IS_BONUS_BY_COMBO = 1
					,@LOW_QTY = 20
				-- 
				SELECT * FROM [acsa].[SWIFT_TRADE_AGREEMENT_BY_COMBO_BONUS_RULE]
*/
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_UPDATE_TRADE_AGREEMENT_BY_COMBO_BONUS_RULE](
	@TRADE_AGREEMENT_BONUS_RULE_BY_COMBO_ID INT
	,@COMBO_ID INT
	,@BONUS_SUB_TYPE VARCHAR(50)
	,@IS_BONUS_BY_LOW_PURCHASE INT
	,@IS_BONUS_BY_COMBO INT
	,@LOW_QTY INT = 1
)
AS
BEGIN
	BEGIN TRY
		UPDATE [acsa].[SWIFT_TRADE_AGREEMENT_BY_COMBO_BONUS_RULE]
		SET	
			[COMBO_ID] = @COMBO_ID
			,[BONUS_SUB_TYPE] = @BONUS_SUB_TYPE
			,[IS_BONUS_BY_LOW_PURCHASE] = @IS_BONUS_BY_LOW_PURCHASE
			,[IS_BONUS_BY_COMBO] = @IS_BONUS_BY_COMBO
			,[LOW_QTY] = @LOW_QTY
		WHERE [TRADE_AGREEMENT_BONUS_RULE_BY_COMBO_ID] = @TRADE_AGREEMENT_BONUS_RULE_BY_COMBO_ID
		--
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo, '' DbData
	END TRY
	BEGIN CATCH
		SELECT  -1 as Resultado
		,CASE CAST(@@ERROR AS VARCHAR)
			WHEN '2627' THEN ''
			ELSE ERROR_MESSAGE() 
		END Mensaje 
		,@@ERROR Codigo 
	END CATCH
END



