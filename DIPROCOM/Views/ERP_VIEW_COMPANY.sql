-- =============================================
-- Autor:					rodrigo.gomez
-- Fecha de Creacion: 		4/20/2017 @ A-Team Sprint Hondo
-- Description:			    Se creo la vista ERP_VIEW_COMPANY para traer todas las compañias con el BulkData

/*
-- Ejemplo de Ejecucion:
        SELECT * FROM [DIPROCOM].ERP_VIEW_COMPANY
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_VIEW_COMPANY]
AS
SELECT DISTINCT
 -- EXTERNAL_SOURCE_ID    COMPANY_ID
 --,EXTERNAL_SOURCE_NAME  COMPANY_NAME
 --,EXTERNAL_SOURCE       COMPANY_SOURCE
  1 COMPANY_ID
 ,'DIPROCOM' COMPANY_NAME
 ,'DIPROCOM' COMPANY_SOURCE
 ,GETDATE() LAST_UPDATE
 ,'BULK_DATA' LAST_UPDATE_BY
--FROM OPENQUERY([SAP_INTERCOMPANY], '
--		SELECT  
--			EXTERNAL_SOURCE_ID 
--			,EXTERNAL_SOURCE_NAME 
--			,EXTERNAL_SOURCE  
--		FROM [SAP_INTERCOMPANY].DBO.SI_EXTERNAL_SOURCE ')