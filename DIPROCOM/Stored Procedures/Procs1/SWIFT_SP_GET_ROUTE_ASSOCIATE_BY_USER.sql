/****** Object:  StoredProcedure [DIPROCOM].[SWIFT_SP_GET_ROUTE_ASSOCIATE_BY_USER]    Script Date: 15/12/2015 9:09:38 AM ******/
-- =============================================
-- Autor:				JOSE ROBERTO
-- Fecha de Creacion: 	15-12-2015
-- Description:			Muestra las rutas asignadas por usuario



/*
-- Ejemplo de Ejecucion:				
				--
  EXEC [DIPROCOM].[SWIFT_SP_GET_ROUTE_ASSOCIATE_BY_USER]@LOGIN='GERENTE@DIPROCOM'
				--				
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].SWIFT_SP_GET_ROUTE_ASSOCIATE_BY_USER	
@LOGIN VARCHAR(50)
AS  
	SELECT
    
     AR.CODE_ROUTE
		, AR.NAME_ROUTE
		, RU.LOGIN
    , AR.ROUTE
	FROM [DIPROCOM].[SWIFT_VIEW_ALL_ROUTE] AR
		INNER JOIN [DIPROCOM].[SWIFT_ROUTE_BY_USER] RU ON (RU.CODE_ROUTE = AR.CODE_ROUTE)
	WHERE RU.LOGIN = @LOGIN
