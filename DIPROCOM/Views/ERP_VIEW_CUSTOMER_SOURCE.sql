
-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		08-Jun-17 @ A-Team Sprint Jibade 
-- Description:			    Vista para el codigo de cliente por cada base de datos de la multiempresa

-- Modificacion 8/25/2017 @ NEXUS-Team Sprint CommandAndConquer
-- rodrigo.gomez
-- Se agrega lista de precios

/*
-- Ejemplo de Ejecucion:
        SELECT * FROM [DIPROCOM].[ERP_VIEW_CUSTOMER_SOURCE]
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_VIEW_CUSTOMER_SOURCE]
AS
(
	SELECT
		CODE_CUSTOMER [MASTER_ID]
	   ,CODE_CUSTOMER [CARD_CODE]
	   ,NAME_CUSTOMER [CARD_NAME]
	   ,TAX_ID [TAX_ID]
	   ,GROUP_NUM [GROUPNUM]
	   ,'Diprocom' [SOURCE]
	   ,NULL [PRICE_LIST]
	FROM DIPROCOM.ERP_VIEW_COSTUMER
)