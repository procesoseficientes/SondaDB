-- =============================================
-- Author:     	hector.gonzalez
-- Create date: 2016-10-11
-- Description: Obtiene los puntos del poligono por ruta


/*
Ejemplo de Ejecucion:
			      EXEC [DIPROCOM].SWIFT_SP_GET_POLYGON_POINTS_BY_ROUTE 
					@CODE_ROUTE = '4161'        
*/
-- =============================================

CREATE PROCEDURE [DIPROCOM].SWIFT_SP_GET_POLYGON_POINTS_BY_ROUTE @CODE_ROUTE VARCHAR(250)
AS
BEGIN
  --
  SELECT
    spp.POLYGON_ID
   ,spp.POSITION
   ,spp.LATITUDE
   ,spp.LONGITUDE
  FROM [DIPROCOM].SWIFT_POLYGON_POINT spp
  INNER JOIN [DIPROCOM].SWIFT_POLYGON sp
    ON (spp.POLYGON_ID = sp.POLYGON_ID)
  INNER JOIN [DIPROCOM].SWIFT_POLYGON_BY_ROUTE spbr
    ON sp.POLYGON_ID = spbr.POLYGON_ID
  INNER JOIN [DIPROCOM].SWIFT_ROUTES sr
    ON spbr.ROUTE = sr.ROUTE
  WHERE sr.CODE_ROUTE = @CODE_ROUTE
    ORDER BY spp.POSITION

END
