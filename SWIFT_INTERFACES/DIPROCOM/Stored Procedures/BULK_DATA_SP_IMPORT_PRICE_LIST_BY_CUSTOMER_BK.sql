﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	29-02-2016
-- Description:			SP que importa lista de precios por cliente

/*
-- Ejemplo de Ejecucion:
				-- 
				EXEC [DIPROCOM].[BULK_DATA_SP_IMPORT_PRICE_LIST_BY_CUSTOMER]
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[BULK_DATA_SP_IMPORT_PRICE_LIST_BY_CUSTOMER_BK]
AS
BEGIN
	SET NOCOUNT ON;
	--
	MERGE [SWIFT_EXPRESS].[DIPROCOM].SWIFT_PRICE_LIST_BY_CUSTOMER TGR 
	USING ( SELECT * FROM  [SWIFT_INTERFACES_ONLINE].[DIPROCOM].[ERP_PRICE_LIST_BY_CUSTOMER] ) SRC 
	ON TGR.CODE_CUSTOMER = SRC.CODE_CUSTOMER  COLLATE DATABASE_DEFAULT
	WHEN MATCHED THEN 
	UPDATE 
		SET TGR.CODE_PRICE_LIST = SRC.CODE_PRICE_LIST 
	WHEN NOT MATCHED THEN 
	INSERT (
		CODE_PRICE_LIST
		,CODE_CUSTOMER
	) 
	VALUES(
		SRC.CODE_PRICE_LIST 
		, SRC.CODE_CUSTOMER
	);
END