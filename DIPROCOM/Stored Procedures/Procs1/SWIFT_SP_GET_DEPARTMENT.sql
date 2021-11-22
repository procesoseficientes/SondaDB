
-- =============================================
-- Autor:				ppablo.loukota	
-- Fecha de Creacion: 	08-12-2015
-- Description:			Selecciona todos los departamentos

/*
-- Ejemplo de Ejecucion:
				
				--
				EXECUTE  [PACASA].[SWIFT_SP_GET_DEPARTMENT] 
				@COUNTRY = 'GUATEMALA'
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_DEPARTMENT]
@COUNTRY VARCHAR(50)
AS
BEGIN
	SELECT  DISTINCT DEPARTMENT , COUNTRY
    FROM [PACASA].[SWIFT_GEOGRAPHIC_LOCATION]
	WHERE [COUNTRY] = @COUNTRY
END



