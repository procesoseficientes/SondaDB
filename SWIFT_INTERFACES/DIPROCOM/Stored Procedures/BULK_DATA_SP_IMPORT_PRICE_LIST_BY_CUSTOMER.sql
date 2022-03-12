-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	29-02-2016
-- Description:			SP que importa lista de precios por cliente

-- Modificacion 25-Apr-17 @ A-Team Sprint Hondo
					-- alberto.ruiz
					-- Se agrego el campo owner

/*
-- Ejemplo de Ejecucion:
				-- 
				EXEC [SWIFT_INTERFACES_QA].[SONDA].[BULK_DATA_SP_IMPORT_PRICE_LIST_BY_CUSTOMER]
*/
-- =============================================
CREATE PROCEDURE [SONDA].[BULK_DATA_SP_IMPORT_PRICE_LIST_BY_CUSTOMER]
AS
BEGIN
	SET NOCOUNT ON;
	--	
	TRUNCATE TABLE SWIFT_EXPRESS_MAY_QA.[SONDA].SWIFT_PRICE_LIST_BY_CUSTOMER

	--
	MERGE   [SWIFT_EXPRESS_MAY_QA].[SONDA].SWIFT_PRICE_LIST_BY_CUSTOMER TGR 
	USING ( SELECT DISTINCT * FROM  [SWIFT_INTERFACES_ONLINE_MAY_QA].[SONDA].[ERP_PRICE_LIST_BY_CUSTOMER] ) SRC 
	ON [TGR].[CODE_CUSTOMER] = [SRC].[CODE_CUSTOMER]
	WHEN MATCHED THEN
		UPDATE SET
				[TGR].[CODE_PRICE_LIST] = [SRC].[CODE_PRICE_LIST]
				,[TGR].[OWNER] = [SRC].[OWNER]
	WHEN NOT MATCHED THEN
		INSERT
				(
					[CODE_PRICE_LIST]
					,[CODE_CUSTOMER]
					,[OWNER]
				)
		VALUES	(
					[SRC].[CODE_PRICE_LIST]
					,[SRC].[CODE_CUSTOMER]
					,[SRC].[OWNER]
				);
END