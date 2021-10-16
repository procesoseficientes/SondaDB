﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	26-01-2016
-- Description:			Obtiene todos los clientes locales y de SAP

/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [DIPROCOM].[SWIFT_VIEW_PROVIDER_INVENTORY_WITHOUT_SERIE]
*/
-- =============================================
CREATE VIEW [DIPROCOM].[SWIFT_VIEW_PROVIDER_INVENTORY_WITHOUT_SERIE]
AS
SELECT
	P.[CODE_PROVIDER]
	,MAX(P.[NAME_PROVIDER]) NAME_PROVIDER
	,S.[CODE_SKU]
	,MAX(S.[DESCRIPTION_SKU]) DESCRIPTION_SKU
	,I.[BATCH_ID]
	,MIN(B.[BATCH_SUPPLIER_EXPIRATION_DATE]) BATCH_SUPPLIER_EXPIRATION_DATE
	,I.[PALLET_ID]
	,SUM(I.[ON_HAND]) ON_HAND
FROM [DIPROCOM].[SWIFT_VIEW_ALL_PROVIDERS] P
INNER JOIN [DIPROCOM].[SWIFT_VIEW_ALL_SKU] S ON (P.[CODE_PROVIDER] = S.[CODE_PROVIDER])
INNER JOIN [DIPROCOM].[SWIFT_INVENTORY] I ON (S.[CODE_SKU] = I.[SKU])
INNER JOIN [DIPROCOM].[SWIFT_BATCH] B ON (I.[BATCH_ID] = B.[BATCH_ID])
WHERE I.[ON_HAND] > 0
GROUP BY 
	P.[CODE_PROVIDER]
	,S.[CODE_SKU]
	,I.[BATCH_ID]
	,I.[PALLET_ID]



