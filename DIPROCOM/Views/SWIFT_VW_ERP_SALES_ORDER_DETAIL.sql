
-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		01-06-2016
-- Description:			    Vista que obtiene el detalle de las ordenes de venta del ERP

/*
-- Ejemplo de Ejecucion:
        SELECT * FROM [SONDA].[SWIFT_VW_ERP_SALES_ORDER_DETAIL] WHERE ERP_DOC = 8
*/
-- =============================================
CREATE VIEW [SONDA].[SWIFT_VW_ERP_SALES_ORDER_DETAIL]
AS
	SELECT 
		SAP_PICKING_ID
		,ERP_DOC
		,CUSTOMER_ID
		,CUSTOMER_NAME
		,SKU
		,[dbo].[FUNC_REMOVE_SPECIAL_CHARS](SKU_DESCRIPTION) as SKU_DESCRIPTION
		,QTY
		,QTY_SOURCE
		,SHIPPING_TO
		,SELLER_NAME
		,COMMENTS 
	FROM OPENQUERY(ERPSERVER,'
		SELECT
			CAST(POD.DocEntry AS VARCHAR) + CAST(POD.LineNum AS VARCHAR) AS SAP_PICKING_ID
			,PO.DocNum  AS ERP_DOC
			,PO.CardCode  COLLATE SQL_Latin1_General_CP1_CI_AS  AS CUSTOMER_ID
			,PO.CardName  COLLATE SQL_Latin1_General_CP1_CI_AS AS CUSTOMER_NAME
			,POD.ItemCode  COLLATE SQL_Latin1_General_CP1_CI_AS AS SKU
			,POD.Dscription  COLLATE SQL_Latin1_General_CP1_CI_AS AS SKU_DESCRIPTION
			,POD.OpenQty AS QTY
			,POD.OpenQty AS QTY_SOURCE
			,PO.Address2  COLLATE SQL_Latin1_General_CP1_CI_AS  AS SHIPPING_TO
			,SE.SlpName  COLLATE SQL_Latin1_General_CP1_CI_AS  as SELLER_NAME
			,PO.COMMENTS
		FROM [BD_Prueba_Viscosa].dbo.RDR1 AS POD 
		INNER JOIN [BD_Prueba_Viscosa].dbo.ORDR AS PO ON (PO.DocEntry = POD.DocEntry)
		INNER JOIN [BD_Prueba_Viscosa].dbo.OSLP AS SE ON (SE.SlpCode =  PO.SlpCode)
		WHERE po.DocStatus=''O'' 
			AND pod.LineStatus=''O'' 
			AND (PO.DocType = ''I'') 
			AND POD.OpenQty > 3')




