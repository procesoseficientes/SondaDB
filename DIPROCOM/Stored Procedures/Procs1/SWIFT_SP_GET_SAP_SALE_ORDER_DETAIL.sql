﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	26-01-2016
-- Description:			Obtiene el picking

-- Modificacion 11-07-2016 @ Sprint  ζ
					-- alberto.ruiz
					-- Se agrego columna TOTAL_LINE

-- Modificacion 12-08-2016 @ Sprint η
					-- rudi garcia
					-- Se quito la condicion "AND POD.OpenQty > 3"
-- Modificacion 05-Oct-16  @ A-Team Sprint 2
					-- alberto.ruiz
					-- Se quitaron los filtros de DocStatus y LineStatus
/*
-- Ejemplo de Ejecucion:
        EXEC [SONDA].[SWIFT_SP_GET_SAP_SALE_ORDER_DETAIL] @pERP_DOC = 8
*/
-- =============================================
CREATE PROCEDURE [SONDA].[SWIFT_SP_GET_SAP_SALE_ORDER_DETAIL] (
	@pERP_DOC VARCHAR(50)
)
AS
BEGIN
	DECLARE @SQL VARCHAR(8000)
	--
	SELECT @SQL = 
		 'SELECT 
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
			,TOTAL_LINE
			from openquery (ERPSERVER,''SELECT     CAST(POD.DocEntry AS VARCHAR) + CAST(POD.LineNum AS VARCHAR) AS SAP_PICKING_ID, PO.DocNum AS ERP_DOC, PO.CardCode AS CUSTOMER_ID, PO.CardName AS CUSTOMER_NAME, 
							  POD.ItemCode AS SKU, POD.Dscription AS SKU_DESCRIPTION, POD.OpenQty AS QTY, POD.OpenQty AS QTY_SOURCE, PO.Address2 AS SHIPPING_TO, SE.SlpName as SELLER_NAME,PO.COMMENTS,POD.LineTotal TOTAL_LINE
		FROM         [BD_Prueba_Viscosa].dbo.RDR1 AS POD INNER JOIN
							  [BD_Prueba_Viscosa].dbo.ORDR AS PO ON PO.DocEntry = POD.DocEntry
							  INNER JOIN
							[BD_Prueba_Viscosa].dbo.OSLP AS SE
							ON SE.SlpCode =  PO.SlpCode
		WHERE  (PO.DocType = ''''I'''') AND (PO.DocNum = '+@pERP_DOC+') '')'
	--
	PRINT '@SQL: ' + @SQL
	--
	EXEC (@SQL)
END



