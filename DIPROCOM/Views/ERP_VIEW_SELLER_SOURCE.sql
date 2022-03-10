

-- =============================================
-- Autor:					rodrigo.gomez
-- Fecha de Creacion: 		08-Jun-17 @ A-Team Sprint Jibade 
-- Description:			    Vista para el codigo de vendedor por cada base de datos de la multiempresa

-- Modificacion 8/22/2017 @ NEXUS-Team Sprint CommandAndConquer
-- rodrigo.gomez
-- Se agrega la columna SERIE

/*
-- Ejemplo de Ejecucion:
        SELECT * FROM [SWIFT_INTERFACES].[DIPROCOM].[ERP_VIEW_SELLER_SOURCE]
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_VIEW_SELLER_SOURCE]
AS
(	SELECT
		SELLER_CODE [MASTER_ID]
		,SELLER_CODE [SLP_CODE]
		,'Diprocom' [SOURCE]
		,'' [SERIE]
	FROM [SWIFT_INTERFACES].DIPROCOM.ERP_VIEW_SELLER
)