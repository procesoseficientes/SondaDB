﻿
-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	29-02-2016
-- Description:			SP que importa ordenes

/*
-- Ejemplo de Ejecucion:
				-- 
				EXEC [DIPROCOM].[BULK_DATA_SP_IMPORT_ORDER]
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[BULK_DATA_SP_IMPORT_ORDER]
AS
BEGIN
	SET NOCOUNT ON;
	--
	PRINT 'INSERTA EN ORDER_DETAIL'
	DELETE FROM [DIPROCOM].[SWIFT_ERP_ORDER_DETAIL]
	INSERT INTO [DIPROCOM].[SWIFT_ERP_ORDER_DETAIL]
	SELECT * FROM [SWIFT_INTERFACES_ONLINE].[DIPROCOM].[ERP_ORDER_DETAIL]
	--
	PRINT 'INSERTA EN ORDER_HEADER'
	--DELETE FROM [DIPROCOM].[SWIFT_ERP_ORDER_HEADER]
	--INSERT INTO [DIPROCOM].[SWIFT_ERP_ORDER_HEADER]
	--SELECT * FROM [SWIFT_INTERFACES_ONLINE].[DIPROCOM].[ERP_ORDER_HEADER]
	--
	PRINT 'INSERTA EN ORDER_SERIE_DETAIL'
	DELETE FROM [DIPROCOM].[SWIFT_ERP_ORDER_SERIE_DETAIL]
	INSERT INTO [DIPROCOM].[SWIFT_ERP_ORDER_SERIE_DETAIL]
	SELECT * FROM [SWIFT_INTERFACES_ONLINE].[DIPROCOM].[ERP_VIEW_ORDER_SERIE_DETAIL]
END