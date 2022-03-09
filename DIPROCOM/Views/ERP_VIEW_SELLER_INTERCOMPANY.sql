
-- =============================================
-- Autor:				alejandro.ochoa
-- Fecha de Creacion: 	2017-05-26
-- Description:			    Vista que obtiene los vendedores 

/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [DIPROCOM].[ERP_VIEW_SELLER_INTERCOMPANY]
*/
-- =============================================

CREATE VIEW [DIPROCOM].[ERP_VIEW_SELLER_INTERCOMPANY]
AS
	SELECT
		[SELLER_CODE] SELLER_CODE
		,[SELLER_NAME] SELLER_NAME
		,'Diprocom' [OWNER]
		,[SELLER_CODE] OWNER_ID
		,[GPS] GPS 
		,'Diprocom' DBSAP
	FROM [DIPROCOM].[ERP_VIEW_SELLER]