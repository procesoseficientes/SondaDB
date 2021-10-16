﻿-- =============================================
-- Autor:				diego.as
-- Fecha de Creacion: 	7/22/2017 @ Reborn-TEAM Sprint  Bearbeitung
-- Description:			SP que elimina una promocion siempre y cuando no este asociada a un Acuerdo Comercial

/*
-- Ejemplo de Ejecucion:
				EXEC [DIPROCOM].[SWIFT_SP_ELIMINATE_FULL_PROMOTION]
				@PROMO_ID = 2121
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_ELIMINATE_FULL_PROMOTION](
	@PROMO_ID INT
)
WITH RECOMPILE
AS
BEGIN
	SET NOCOUNT ON;
	-- -----------------------------------------------------------------
	-- Se almacena en una variable local para evitar Parameter Sniffing
	-- -----------------------------------------------------------------
	DECLARE @PROMOTION_ID INT = @PROMO_ID;
	DECLARE @THIS_ASSOCIATE INT = 0;
	
	BEGIN TRY
		-- ---------------------------------------------------------------------------------------------------
		-- Se verifica si la promocion enviada como parametro se encuentra asociada a algun acuerdo comercial
		-- ---------------------------------------------------------------------------------------------------
		SELECT @THIS_ASSOCIATE = 1 FROM [DIPROCOM].[SWIFT_TRADE_AGREEMENT_BY_PROMO] WHERE [PROMO_ID] = @PROMOTION_ID;

		IF(@THIS_ASSOCIATE = 1) BEGIN
			GOTO PROMOTION_ASSOCIATED_WITH_A_COMMERCIAL_AGREEMENT;
		END
		ELSE BEGIN
			GOTO PROMOTION_NOT_ASSOCIATED_WITH_A_COMMERCIAL_AGREEMENT;
		END

		PROMOTION_ASSOCIATED_WITH_A_COMMERCIAL_AGREEMENT:
			RAISERROR('No se puede eliminar la Promoción debido a que está siendo utilizada en un Acuerdo Comercial',16,1);

		PROMOTION_NOT_ASSOCIATED_WITH_A_COMMERCIAL_AGREEMENT:
			-- -------------------------------------------------------------------------------
			-- Se eliminan TODOS los SKUS asociados a la promocion
			-- -------------------------------------------------------------------------------
			DELETE FROM [DIPROCOM].[SWIFT_PROMO_DISCOUNT_BY_SCALE] WHERE [PROMO_ID] = @PROMOTION_ID;

			-- --------------------------------------------------------------------------------
			-- Se elimina la promocion
			-- --------------------------------------------------------------------------------
			DELETE FROM [DIPROCOM].[SWIFT_PROMO] WHERE [PROMO_ID] = @PROMOTION_ID
			
			-- --------------------------------------------------------------------------------
			-- Se devuelve el resultado como EXITOSO
			-- --------------------------------------------------------------------------------
			SELECT 1 AS Resultado, 'Proceso Exitoso' Mensaje, 0 Codigo, '' DbData
	END TRY
	BEGIN CATCH
		-- ---------------------------------------------------------------
		-- Se devuelve el resultado como ERRONEO
		-- ---------------------------------------------------------------
		SELECT -1 AS Resultado, ERROR_MESSAGE() Mensaje, @@ERROR Codigo
	END CATCH
END