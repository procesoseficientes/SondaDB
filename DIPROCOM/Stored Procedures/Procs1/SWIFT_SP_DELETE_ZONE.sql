-- =============================================
-- Autor:				pablo.aguilar
-- Fecha de Creacion: 	14-Dec-16 @ A-TEAM Sprint 6 
-- Description:			SP que actualiza una zona 

/*
-- Ejemplo de Ejecucion:
				EXEC  [DIPROCOM].[SWIFT_SP_DELETE_ZONE] @ZONE_ID = 2
SELECT * FROM [DIPROCOM].[SWIFT_ZONE]
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_DELETE_ZONE] (
  @ZONE_ID INT
  )
AS
BEGIN
  SET NOCOUNT ON;
  --

  -- ------------------------------------------------------------------------------------
  -- Operar
  -- ------------------------------------------------------------------------------------
DELETE [DIPROCOM].[SWIFT_ZONE]
WHERE ZONE_ID = @ZONE_ID;


END


