﻿-- =============================================
-- Autor:	        hector.gonzalez
-- Fecha de Creacion: 	2017-07-21 @ Team REBORN - Sprint Bearbeitung
-- Description:	        Trae los skus que no estan asociados a una regla 

/*
-- Ejemplo de Ejecucion:
				EXEC [acsa].[SWIFT_SP_GET_SKUS_AVAILABLE_OF_COMBO_FROM_PROMO_OF_BONUS_BY_COMBO]
					@PROMO_RULE_BY_COMBO_ID = 8
*/
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_GET_SKUS_AVAILABLE_OF_COMBO_FROM_PROMO_OF_BONUS_BY_COMBO] (@PROMO_RULE_BY_COMBO_ID INT)
AS
BEGIN
  SET NOCOUNT ON;
  --
  SELECT
    ROW_NUMBER() OVER (ORDER BY [VAS].[CODE_SKU], [PU].[PACK_UNIT]) [ID]
   ,[VAS].[CODE_SKU]
   ,[VAS].[DESCRIPTION_SKU]
   ,[FS].[FAMILY_SKU]
   ,[FS].[CODE_FAMILY_SKU]
   ,[FS].[DESCRIPTION_FAMILY_SKU]
   ,[PU].[PACK_UNIT]
   ,[PU].[CODE_PACK_UNIT]
   ,[PU].[DESCRIPTION_PACK_UNIT]
  FROM [acsa].[SWIFT_VIEW_ALL_SKU] [VAS]
  LEFT JOIN [acsa].[SWIFT_FAMILY_SKU] [FS]
    ON (
    [FS].[CODE_FAMILY_SKU] = [VAS].[CODE_FAMILY_SKU]
    )
  INNER JOIN [acsa].[SONDA_PACK_CONVERSION] [PC]
    ON (
    [PC].[CODE_SKU] = [VAS].[CODE_SKU]
    )
  INNER JOIN [acsa].[SONDA_PACK_UNIT] [PU]
    ON (
    [PU].[CODE_PACK_UNIT] = [PC].[CODE_PACK_UNIT_FROM]
    )
  LEFT JOIN [acsa].[SWIFT_PROMO_SKU_BY_PROMO_RULE] [PSR]
    ON ([PC].[CODE_SKU] = [PSR].[CODE_SKU]
    AND [PU].[PACK_UNIT] = [PSR].[PACK_UNIT]
    AND [PSR].[PROMO_RULE_BY_COMBO_ID] = @PROMO_RULE_BY_COMBO_ID)
  WHERE [PSR].[PROMO_RULE_BY_COMBO_ID] IS NULL
  ORDER BY [VAS].[CODE_SKU]
  , [PU].[PACK_UNIT]
END