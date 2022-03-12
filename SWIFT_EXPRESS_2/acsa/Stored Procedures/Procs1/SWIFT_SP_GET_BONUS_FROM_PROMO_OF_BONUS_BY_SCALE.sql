﻿-- =============================================
-- Autor:				rodrigo.gomez
-- Fecha de Creacion: 	6/12/2017 @ A-TEAM Sprint Jibade 
-- Description:			Obtiene uno o todos los registros de la tabla SWIFT_PROMO_BONUS_BY_SCALE filtrados por PROMO_ID

/*
-- Ejemplo de Ejecucion:
				EXEC [SONDA].[SWIFT_SP_GET_BONUS_FROM_PROMO_OF_BONUS_BY_SCALE]
				--
				EXEC [SONDA].[SWIFT_SP_GET_BONUS_FROM_PROMO_OF_BONUS_BY_SCALE]
					@PROMO_ID = 83
*/
-- =============================================
CREATE PROCEDURE [SONDA].[SWIFT_SP_GET_BONUS_FROM_PROMO_OF_BONUS_BY_SCALE](
	@PROMO_ID INT = NULL	
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT [PBS].[PROMO_BONUS_BY_SCALE_ID]
			,[PBS].[PROMO_ID]
			,[PBS].[CODE_SKU]
			,[VAS1].[DESCRIPTION_SKU]
			,[PBS].[PACK_UNIT]
			,[PU1].[DESCRIPTION_PACK_UNIT]
			,[PBS].[LOW_LIMIT]
			,[PBS].[HIGH_LIMIT]
			,[PBS].[CODE_SKU_BONUS]
			,[VAS2].[DESCRIPTION_SKU] [DESCRIPTION_BONUS_SKU]
			,[PBS].[PACK_UNIT_BONUS] 
			,[PU2].[DESCRIPTION_PACK_UNIT] [DESCRIPTION_PACK_UNIT_BONUS]
			,[PBS].[BONUS_QTY]
	FROM [SONDA].[SWIFT_PROMO_BONUS_BY_SCALE] [PBS]
		INNER JOIN [SONDA].[SWIFT_VIEW_ALL_SKU] [VAS1] ON [VAS1].[CODE_SKU] = [PBS].[CODE_SKU]
		INNER JOIN [SONDA].[SWIFT_VIEW_ALL_SKU] [VAS2] ON [VAS2].[CODE_SKU] = [PBS].[CODE_SKU_BONUS]
		INNER JOIN [SONDA].[SONDA_PACK_UNIT] [PU1] ON [PU1].[PACK_UNIT] = [PBS].[PACK_UNIT]
		INNER JOIN [SONDA].[SONDA_PACK_UNIT] [PU2] ON [PU2].[PACK_UNIT] = [PBS].[PACK_UNIT_BONUS]
	WHERE [PBS].[PROMO_ID] = @PROMO_ID OR @PROMO_ID IS NULL 
END