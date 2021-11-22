﻿-- =============================================
-- Autor:				rudi.garcia
-- Fecha de Creacion: 	02-MAy-2018 @ G-Force Sprint  Caribú
-- Description:			SP que elimina una promocion de descuento por monto general y familia siempre y cuando no este asociada a un Acuerdo Comercial

/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].[SWIFT_SP_ELIMINATE_FULL_PROMOTION_DISCOUNT_BY_FAMILY_AND_PAYMENT_TYPE]
				@PROMO_ID = 2121
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_ELIMINATE_FULL_PROMOTION_DISCOUNT_BY_FAMILY_AND_PAYMENT_TYPE] (@PROMO_ID INT) WITH RECOMPILE
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
    SELECT
      @THIS_ASSOCIATE = 1
    FROM [PACASA].[SWIFT_TRADE_AGREEMENT_BY_PROMO]
    WHERE [PROMO_ID] = @PROMOTION_ID;

    IF (@THIS_ASSOCIATE = 1)
    BEGIN
      GOTO PROMOTION_ASSOCIATED_WITH_A_COMMERCIAL_AGREEMENT;
    END
    ELSE
    BEGIN
      GOTO PROMOTION_NOT_ASSOCIATED_WITH_A_COMMERCIAL_AGREEMENT;
    END

  PROMOTION_ASSOCIATED_WITH_A_COMMERCIAL_AGREEMENT:
    RAISERROR ('No se puede eliminar la Promoción debido a que está siendo utilizada en un Acuerdo Comercial', 16, 1);

  PROMOTION_NOT_ASSOCIATED_WITH_A_COMMERCIAL_AGREEMENT:
    -- -------------------------------------------------------------------------------
    -- Se eliminan todas la familias asociados a la promocion
    -- -------------------------------------------------------------------------------
    DELETE FROM [PACASA].[SWIFT_PROMO_DISCOUNT_BY_PAYMENT_TYPE_AND_FAMILY]
    WHERE [PROMO_ID] = @PROMOTION_ID;

    -- --------------------------------------------------------------------------------
    -- Se elimina la promocion
    -- --------------------------------------------------------------------------------
    DELETE FROM [PACASA].[SWIFT_PROMO]
    WHERE [PROMO_ID] = @PROMOTION_ID

    -- --------------------------------------------------------------------------------
    -- Se devuelve el resultado como EXITOSO
    -- --------------------------------------------------------------------------------
    SELECT
      1 AS Resultado
     ,'Proceso Exitoso' Mensaje
     ,0 Codigo
     ,'' DbData
  END TRY
  BEGIN CATCH
    -- ---------------------------------------------------------------
    -- Se devuelve el resultado como ERRONEO
    -- ---------------------------------------------------------------
    SELECT
      -1 AS Resultado
     ,ERROR_MESSAGE() Mensaje
     ,@@ERROR Codigo
  END CATCH
END