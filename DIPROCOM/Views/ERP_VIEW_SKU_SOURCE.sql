
-- =============================================
-- Autor:					rodrigo.gomez
-- Fecha de Creacion: 		14-Jun-17 @ A-Team Sprint Jibade 
-- Description:			    Vista para el codigo de sku por cada base de datos de la multiempresa

/*
-- Ejemplo de Ejecucion:
        SELECT * FROM [DIPROCOM].[ERP_VIEW_SKU_SOURCE]
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_VIEW_SKU_SOURCE]
AS
(
	SELECT
		CODE_SKU  [MASTER_ID]
		,CODE_SKU [ITEM_CODE]
		,'Diprocom' [SOURCE]
	FROM DIPROCOM.ERP_VIEW_SKU
  )