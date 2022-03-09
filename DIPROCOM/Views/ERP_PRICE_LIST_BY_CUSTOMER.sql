-- =============================================
-- Autor:				
-- Fecha de Creacion: 	
-- Description:			

-- Modificacion 3/13/2017 @ A-Team Sprint Ebonne
-- rodrigo.gomez
-- Se pusieron como referencias las vistas en la base de datos SAP_INTERCOMPANY

-- Modificacion 6/13/2017 @ A-Team Sprint Jibade
-- rodrigo.gomez
-- Se obtienen todas las listas de precios para los clientes intercompany.

/*
-- Ejemplo de Ejecucion:
	-- 
	SELECT * FROM [DIPROCOM].[ERP_PRICE_LIST_BY_CUSTOMER]
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_PRICE_LIST_BY_CUSTOMER]
AS

	SELECT DISTINCT
		CODE_CUSTOMER AS CODE_PRICE_LIST
		,CODE_CUSTOMER COLLATE DATABASE_DEFAULT AS CODE_CUSTOMER  
		,'Diprocom' [OWNER]
	FROM DIPROCOM.ERP_VIEW_COSTUMER