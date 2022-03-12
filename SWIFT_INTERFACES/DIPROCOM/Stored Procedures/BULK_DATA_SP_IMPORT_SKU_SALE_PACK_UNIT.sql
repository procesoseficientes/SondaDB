﻿-- =============================================
-- Autor:				alejandro.ochoa
-- Fecha de Creacion: 	28-05-2018
-- Description:			SP que importa las unidades de venta del producto

/*
-- Ejemplo de Ejecucion:
				-- 
				EXEC [SWIFT_INTERFACES_QA].[SONDA].[BULK_DATA_SP_IMPORT_SKU_SALE_PACK_UNIT]
				--
				SELECT * FROM [SWIFT_EXPRESS_QA].[SONDA].[SWIFT_SKU_SALE_PACK_UNIT]
*/
-- =============================================
CREATE PROCEDURE [SONDA].[BULK_DATA_SP_IMPORT_SKU_SALE_PACK_UNIT]
AS
BEGIN
	SET NOCOUNT ON;
	--
	TRUNCATE TABLE [SWIFT_EXPRESS_QA].[SONDA].[SWIFT_SKU_SALE_PACK_UNIT]

	MERGE [SWIFT_EXPRESS_QA].[SONDA].[SWIFT_SKU_SALE_PACK_UNIT]   [TGR] 
	USING (SELECT DISTINCT [CODE_SKU],[CODE_PACK_UNIT] 
			FROM  [SWIFT_INTERFACES_ONLINE_QA].[SONDA].[ERP_SKU_SALE_PACK_UNIT]			
			GROUP BY [CODE_SKU],[CODE_PACK_UNIT] 
			) [SRC] 
	ON  
		[TGR].[CODE_SKU]  = [SRC].[CODE_SKU]
	WHEN MATCHED THEN 
	UPDATE  
		SET 
			[TGR].[CODE_PACK_UNIT] = [SRC].[CODE_PACK_UNIT]
	WHEN NOT MATCHED THEN 
	INSERT ([CODE_SKU]
		,[CODE_PACK_UNIT]
	)
	VALUES ([SRC].[CODE_SKU] 
		,[SRC].[CODE_PACK_UNIT]
	);
END