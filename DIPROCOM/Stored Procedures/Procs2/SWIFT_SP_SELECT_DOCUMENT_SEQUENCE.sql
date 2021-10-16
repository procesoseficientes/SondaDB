-- =============================================
-- Autor:				PEDRO LOUKOTA
-- Fecha de Creacion: 	03-12-2015
-- Description:			Seleciona la secuencia de documentos
--                      
/*
-- Ejemplo de Ejecucion:				
				--


-- TODO: Set parameter values here.

EXECUTE @RC = [DIPROCOM].[SWIFT_SP_SELECT_DOCUMENT_SEQUENCE]


				--				
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_SELECT_DOCUMENT_SEQUENCE]

AS
BEGIN


	  SELECT * FROM [DIPROCOM].[SWIFT_DOCUMENT_SEQUENCE]



END
