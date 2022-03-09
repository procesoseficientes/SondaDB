
-- =============================================
-- Autor:					diego.as
-- Fecha de Creacion: 		5/9/2017 @ A-Team Sprint Issa
-- Description:			    Vista que lee todos los campos de la tabla OCQG del ERP

/*
-- Ejemplo de Ejecucion:
        SELECT * FROM [DIPROCOM].[ERP_VIEW_CUSTOMER_PROPERTIES]
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_VIEW_CUSTOMER_PROPERTIES]
AS
	SELECT 
		 NULL GROUP_CODE
		,NULL GROUP_NAME
		,NULL USER_SIGN
		,NULL FILLER