
-- =============================================
-- Autor:				ppablo.loukota
-- Fecha de Creacion: 	15-12-2015
-- Description:			Vista que obtiene detalles de bodegas 

-- Modificacion 3/14/2017 @ A-Team Sprint Ebonne
-- diego.as
-- Se modifica para que apunte a la BD SAP_INTERCOMPANY

-- Modificacion 4/21/2017 @ A-Team Sprint Hondo
-- rodrigo.gomez
-- Se agregaron las referencias a masterid de skus y bodegas

/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [DIPROCOM].[ERP_VIEW_COMMITED_BY_WAREHOUSE]
*/
-- =============================================

CREATE VIEW [DIPROCOM].[ERP_VIEW_COMMITED_BY_WAREHOUSE]
AS
	SELECT
	  *
	FROM OPENQUERY(DIPROCOM_SERVER, '
		SELECT  
			CAST(Codigo_Producto as VARCHAR) COLLATE database_default as CODE_SKU
		   ,Codigo_Bodega COLLATE database_default as CODE_WAREHOUSE 
		   ,0 as IS_COMMITED
		FROM [SONDA].[dbo].[vsINVENTARIO]
	')