-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	29-02-2016
-- Description:			SP que importa lista de precios por producto

-- Modificado 2016-05-10
              -- alberto.ruiz
              -- Se agregaron las columnas CODE_PRICE_LIST y CODE_SKU
/*
-- Ejemplo de Ejecucion:
				-- 
				EXEC [SWIFT_INTERFACES_QA].[SONDA].[BULK_DATA_SP_IMPORT_PRICE_LIST_BY_SKU]
				--
				SELECT top 1* FROM [SWIFT_EXPRESS_QA].[SONDA].[SWIFT_PRICE_LIST_BY_SKU]
				SELECT top 1* FROM [SWIFT_EXPRESS].[SONDA].[SWIFT_PRICE_LIST_BY_SKU]

*/
-- =============================================
CREATE PROCEDURE [SONDA].[BULK_DATA_SP_IMPORT_PRICE_LIST_BY_SKU]
AS
BEGIN
	SET NOCOUNT ON;
	--
	TRUNCATE TABLE [SWIFT_EXPRESS_QA].[SONDA].[SWIFT_PRICE_LIST_BY_SKU]
	
	MERGE [SWIFT_EXPRESS_QA].[SONDA].[SWIFT_PRICE_LIST_BY_SKU]   [TGR] 
	USING (SELECT [pl].[CODE_PRICE_LIST] ,
                  [pl].[CODE_SKU] ,
                  [pl].[BASEPRICE] ,
                  [pl].[COST] ,
                  [pl].[CODE_PACK_UNIT] ,
                  [pU].[UM_ENTRY] ,
                  [pl].[MASTER_ID] ,
                  [pl].[OWNER] FROM  [SWIFT_INTERFACES_ONLINE_QA].[SONDA].[ERP_PRICE_LIST_BY_SKU] pl
			INNER JOIN [SWIFT_INTERFACES_ONLINE_QA].[SONDA].[ERP_PACK_CONVERSION] pc 
				ON [pc].[CODE_SKU] = [pl].[CODE_SKU] AND [pc].[CODE_PACK_UNIT_TO] = [pl].[CODE_PACK_UNIT] --AND [pc].[ORDER]=1
			INNER JOIN [SWIFT_INTERFACES_ONLINE_QA].[SONDA].[ERP_PACK_UNIT] PU ON [PU].[CODE_PACK_UNIT] = [pl].[CODE_PACK_UNIT]
			WHERE pl.[CODE_PRICE_LIST] IS NOT NULL) [SRC] 
	ON  
		[TGR].[CODE_PRICE_LIST]  = [SRC].[CODE_PRICE_LIST] 
		AND [TGR].[CODE_SKU] = [SRC].[CODE_SKU] COLLATE DATABASE_DEFAULT
	WHEN MATCHED THEN 
	UPDATE  
		SET 
			[TGR].[COST] = [SRC].[COST]
			,[TGR].[CODE_PACK_UNIT] = [SRC].[CODE_PACK_UNIT] COLLATE DATABASE_DEFAULT
			,[TGR].[UM_ENTRY] = [SRC].[UM_ENTRY]
			,[TGR].[OWNER] = [SRC].[OWNER]
			,[TGR].[BASE_PRICE] = [SRC].[BASEPRICE]
	WHEN NOT MATCHED THEN 
	INSERT (
		[CODE_PRICE_LIST]
		,[CODE_SKU]
		,[COST]
		,[CODE_PACK_UNIT]
		,[UM_ENTRY]
		,[OWNER]
		,[BASE_PRICE]
	)
	VALUES (
		[SRC].[CODE_PRICE_LIST] 
		,[SRC].[CODE_SKU] 
		,[SRC].[COST] 
		,[SRC].[CODE_PACK_UNIT] COLLATE DATABASE_DEFAULT
		,[SRC].[UM_ENTRY]
		,[SRC].[OWNER]
		,[SRC].[BASEPRICE]
	);
END