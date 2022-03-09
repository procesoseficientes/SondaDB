-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		09-05-2016
-- Description:			    Vista que trae los precios base de los paquetes que no es el configurado el la lista de precios base

-- Modificacion 3/13/2017 @ A-Team Sprint Ebonne
-- rodrigo.gomez
-- Se pusieron como referencias las vistas en la base de datos SAP_INTERCOMPANY

-- Modificacion 4/21/2017 @ A-Team Sprint Hondo
-- rodrigo.gomez
-- Se agregaron las referencias de masterid de sku y listas de precio

/*
-- Ejemplo de Ejecucion:
        SELECT * FROM [DIPROCOM].[ERP_SKU_BASE_PRICE_BY_PACK]
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_SKU_BASE_PRICE_BY_PACK]
AS
SELECT
  CODE_PRICE_LIST COLLATE DATABASE_DEFAULT AS CODE_PRICE_LIST
 ,CODE_SKU COLLATE DATABASE_DEFAULT AS CODE_SKU
 ,CODE_PACK_UNIT COLLATE DATABASE_DEFAULT AS CODE_PACK_UNIT
 ,COST
FROM OPENQUERY([SAP_INTERCOMPANY], '
		SELECT
			CAST(IT.[U_MasterIdPL] AS VARCHAR) COLLATE DATABASE_DEFAULT AS CODE_PRICE_LIST 
			,ITM.[U_MasterId] COLLATE DATABASE_DEFAULT AS CODE_SKU
			,OU.UomCode COLLATE DATABASE_DEFAULT AS CODE_PACK_UNIT
			,CAST(IT.Price AS NUMERIC(18,6)) AS COST
		FROM [SAP_INTERCOMPANY].dbo.ITM9 IT
		INNER JOIN [SAP_INTERCOMPANY].dbo.OITM ITM ON (
			ITM.ItemCode = IT.ItemCode
		)
		INNER JOIN [SAP_INTERCOMPANY].dbo.OUOM OU ON (
			OU.UomEntry = IT.UomEntry and ITM.U_Owner = OU.U_Owner COLLATE DATABASE_DEFAULT
		)
		
		WHERE  ISNULL(ITM.U_MasterId, '''') <> ''''
		AND ISNULL(ITM.U_Owner,'''') <> ''''
		ORDER BY IT.PriceList
			,IT.ItemCode
			,OU.UomCode
	')