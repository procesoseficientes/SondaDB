﻿-- =============================================
-- Autor:				ppablo.loukota	
-- Fecha de Creacion: 	08-12-2015
-- Description:			Selecciona todos los departamentos

/*
-- Ejemplo de Ejecucion:
				
				--
			EXECUTE  [DIPROCOM].[SWIFT_SP_GET_MUNICIPALITY_BY_DEPARTMENT] 
            @DEPARTMENT = 'GUATEMALA'

*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_MUNICIPALITY_BY_DEPARTMENT]
	@DEPARTMENT VARCHAR(50),
	@COUNTRY VARCHAR(50)
AS
BEGIN
	SELECT  [MUNICIPALITY]
	FROM [DIPROCOM].[SWIFT_GEOGRAPHIC_LOCATION]
	WHERE [DEPARTMENT] = @DEPARTMENT
	AND  [COUNTRY] = @COUNTRY
END



