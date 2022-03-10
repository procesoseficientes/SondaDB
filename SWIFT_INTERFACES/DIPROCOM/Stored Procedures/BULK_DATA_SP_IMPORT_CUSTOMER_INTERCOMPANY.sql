-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		08-Jun-17 @ A-Team Sprint Jibade
-- Description:			    SP para obtener el codigo de cliente por cada base de datos de la multiempresa

/*
-- Ejemplo de Ejecucion:
        EXEC [SWIFT_EXPRESS_QA].[DIPROCOM].[BULK_DATA_SP_IMPORT_CUSTOMER_INTERCOMPANY]
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[BULK_DATA_SP_IMPORT_CUSTOMER_INTERCOMPANY]
AS
BEGIN
	SET NOCOUNT ON;
	--
	TRUNCATE TABLE [SWIFT_EXPRESS_QA].[DIPROCOM].[SWIFT_CUSTOMER_INTERCOMPAY]
	--
	INSERT INTO [SWIFT_EXPRESS_QA].[DIPROCOM].[SWIFT_CUSTOMER_INTERCOMPAY]
			(
				[MASTER_ID]
				,[CARD_CODE]
				,[SOURCE]
			)
	SELECT
		CODE_CUSTOMER
		,CODE_CUSTOMER
		,[OWNER]
	FROM [SWIFT_INTERFACES_ONLINE_QA].DIPROCOM.[ERP_VIEW_COSTUMER]
END