﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	04-Nov-16 @ A-TEAM Sprint 4 
-- Description:			SP que genera las escalas de los productos de 1 a 1,000,000

-- Modificacion 28-Apr-17 @ A-Team Sprint Hondo
					-- alberto.ruiz
					-- Se agrega campo owner

/*
-- Ejemplo de Ejecucion:
				EXEC [DIPROCOM].[BULK_DATA_SP_GENERATE_SCALE]
				--
				SELECT * FROM [SWIFT_EXPRESS].[DIPROCOM].[SWIFT_PRICE_LIST_BY_SKU_PACK_SCALE]
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[BULK_DATA_SP_GENERATE_SCALE]
AS
BEGIN
	SET NOCOUNT ON;
	
	-- ------------------------------------------------------------------------------------
	-- Se limpia la tabla SWIFT_PRICE_LIST_BY_SKU_PACK_SCALE
	-- ------------------------------------------------------------------------------------
	TRUNCATE TABLE [SWIFT_EXPRESS].[DIPROCOM].[SWIFT_PRICE_LIST_BY_SKU_PACK_SCALE]

	-- ------------------------------------------------------------------------------------
	-- Genera las escalas
	-- ------------------------------------------------------------------------------------
	INSERT INTO [SWIFT_EXPRESS].[DIPROCOM].[SWIFT_PRICE_LIST_BY_SKU_PACK_SCALE]
			(
				[CODE_PRICE_LIST]
				,[CODE_SKU]
				,[CODE_PACK_UNIT]
				,[PRIORITY]
				,[LOW_LIMIT]
				,[HIGH_LIMIT]
				,[PRICE]
				,[OWNER]
			)
	SELECT
		[PLS].[CODE_PRICE_LIST]
		,[VS].[CODE_SKU]
		,[PC].[CODE_PACK_UNIT_FROM]
		,0
		,1
		,1000000
		,[PLS].[COST]
		,[PLS].[OWNER]
	FROM [SWIFT_EXPRESS].[DIPROCOM].[SWIFT_VIEW_ALL_SKU] [VS]
	INNER JOIN [SWIFT_EXPRESS].[DIPROCOM].[SONDA_PACK_CONVERSION] [PC] ON (
		[PC].[CODE_SKU] = [VS].[CODE_SKU] COLLATE DATABASE_DEFAULT
	)
	INNER JOIN [SWIFT_EXPRESS].[DIPROCOM].[SWIFT_PRICE_LIST_BY_SKU] [PLS] ON (
		[PLS].[CODE_SKU] = [VS].[CODE_SKU] COLLATE DATABASE_DEFAULT
	)
	ORDER BY [PLS].[CODE_PRICE_LIST]
END