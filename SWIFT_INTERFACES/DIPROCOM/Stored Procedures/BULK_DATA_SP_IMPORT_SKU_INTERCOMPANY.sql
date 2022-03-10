﻿-- =============================================
-- Autor:					rodrigo.gomez
-- Fecha de Creacion: 		14-Jun-17 @ A-Team Sprint Jibade
-- Description:			    SP para obtener el codigo de sku por cada base de datos de la multiempresa

/*
-- Ejemplo de Ejecucion:
        EXEC [SWIFT_INTERFACES_QA].[DIPROCOM].[BULK_DATA_SP_IMPORT_SKU_INTERCOMPANY]
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[BULK_DATA_SP_IMPORT_SKU_INTERCOMPANY]
AS
BEGIN
	SET NOCOUNT ON;
	--
	TRUNCATE TABLE [SWIFT_EXPRESS_QA].[DIPROCOM].[SWIFT_SKU_INTERCOMPANY]
	--
	INSERT INTO [SWIFT_EXPRESS_QA].[DIPROCOM].[SWIFT_SKU_INTERCOMPANY]
			(
				[MASTER_ID]
				,[ITEM_CODE]
				,[SOURCE]
			)
	SELECT
		[MASTER_ID]
		,[ITEM_CODE]
		,[SOURCE]
	FROM [SWIFT_INTERFACES_ONLINE_QA].[DIPROCOM].ERP_VIEW_SKU_SOURCE
END