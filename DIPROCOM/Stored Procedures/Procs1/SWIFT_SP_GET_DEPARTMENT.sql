
-- =============================================
-- Autor:				ppablo.loukota	
-- Fecha de Creacion: 	08-12-2015
-- Description:			Selecciona todos los departamentos

/*
-- Ejemplo de Ejecucion:
				
				--
				EXECUTE  [DIPROCOM].[SWIFT_SP_GET_DEPARTMENT] 
				@COUNTRY = 'GUATEMALA'
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_DEPARTMENT]
@COUNTRY VARCHAR(50)
AS
BEGIN
	SELECT  DISTINCT DEPARTMENT , COUNTRY
    FROM [DIPROCOM].[SWIFT_GEOGRAPHIC_LOCATION]
	WHERE [COUNTRY] = @COUNTRY
END



