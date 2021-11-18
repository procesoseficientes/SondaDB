﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	21-Nov-16 @ A-TEAM Sprint 5
-- Description:			SP para eliminar una bonificacion por multiplo

/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [acsa].[SWIFT_TRADE_AGREEMENT_BONUS_BY_MULTIPLE] WHERE [TRADE_AGREEMENT_BONUS_MULTIPLE_ID] = 4
				--
				EXEC [acsa].[SWIFT_SP_DELETE_BONUS_MULTIPLE_FROM_TRADE_AGREEMENT]
					@TRADE_AGREEMENT_BONUS_MULTIPLE_ID = 4
				-- 
				SELECT * FROM [acsa].[SWIFT_TRADE_AGREEMENT_BONUS_BY_MULTIPLE] WHERE [TRADE_AGREEMENT_BONUS_MULTIPLE_ID] = 4
*/
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_DELETE_BONUS_MULTIPLE_FROM_TRADE_AGREEMENT](
	@TRADE_AGREEMENT_BONUS_MULTIPLE_ID INT
)
AS
BEGIN
	BEGIN TRY
		DECLARE @ID INT
		--
		DELETE FROM [acsa].[SWIFT_TRADE_AGREEMENT_BONUS_BY_MULTIPLE]
		WHERE [TRADE_AGREEMENT_BONUS_MULTIPLE_ID] = @TRADE_AGREEMENT_BONUS_MULTIPLE_ID
		--
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo, '' DbData
	END TRY
	BEGIN CATCH
		SELECT  
			-1 as Resultado
			,ERROR_MESSAGE() Mensaje 
			,@@ERROR Codigo 
	END CATCH
END



