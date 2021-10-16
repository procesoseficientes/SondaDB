-- =============================================
-- Autor:				Yaqueline Canahui
-- Fecha de Creacion: 	09-Aug-2018 @ G-FORCE Sprint Hormiga
-- Description:			SP que obtiene los roles.

/*
-- Ejemplo de Ejecucion:
				EXEC [DIPROCOM].[SWIFT_SP_GET_ROLE]
				--
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_ROLE]
AS
BEGIN
  SELECT * FROM DIPROCOM.SWIFT_ROLE
END