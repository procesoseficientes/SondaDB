﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	20-09-2016 @ A-TEAM Sprint 1
-- Description:			SP que elimina la bonificacion al acuerdo comercial

/*
-- Ejemplo de Ejecucion:
				EXEC [DIPROCOM].SWIFT_SP_DELETE_BONUS_FROM_TRADE_AGREEMENT
					@TRADE_AGREEMENT_BONUS_ID = 7
				-- 
				SELECT * FROM [DIPROCOM].SWIFT_TRADE_AGREEMENT_BONUS
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].SWIFT_SP_DELETE_BONUS_FROM_TRADE_AGREEMENT(
	@TRADE_AGREEMENT_BONUS_ID INT
)
AS
BEGIN
	BEGIN TRY
		DELETE FROM [DIPROCOM].SWIFT_TRADE_AGREEMENT_BONUS
		WHERE TRADE_AGREEMENT_BONUS_ID = @TRADE_AGREEMENT_BONUS_ID
		--
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo, '' DbData
	END TRY
	BEGIN CATCH
		SELECT  -1 as Resultado
		,CASE CAST(@@ERROR AS VARCHAR)
			WHEN '2627' THEN 'Ya esta la bonificacion relacionada al acuerdo comercial'
			ELSE ERROR_MESSAGE() 
		END Mensaje 
		,@@ERROR Codigo 
	END CATCH
END
