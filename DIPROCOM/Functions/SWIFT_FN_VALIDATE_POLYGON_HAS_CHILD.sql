
-- =============================================
-- Autor:				        hector.gonzalez
-- Fecha de Creacion: 	25-07-2016
-- Description:			    Valida si el poligono tine hijos 


/*
	SELECT [PACASA].SWIFT_FN_VALIDATE_POLYGON_HAS_CHILD (10) AS VALUE
*/
-- =============================================
CREATE FUNCTION [PACASA].SWIFT_FN_VALIDATE_POLYGON_HAS_CHILD (@POLYGON_ID INT)
RETURNS INT
AS
BEGIN

  DECLARE @HAS_CHILD INT = 0

  -- ------------------------------------------------------------------------------------
  -- Valida si el poligono tiene poligonos hijos
  -- ------------------------------------------------------------------------------------
  SELECT TOP 1
    @HAS_CHILD =
    1
  FROM [PACASA].SWIFT_POLYGON sp
  LEFT JOIN [PACASA].SWIFT_POLYGON sp1
    ON sp.POLYGON_ID = sp1.POLYGON_ID_PARENT
  WHERE sp1.POLYGON_ID_PARENT IS NOT NULL
  AND sp.POLYGON_ID = @POLYGON_ID


  RETURN @HAS_CHILD
END
