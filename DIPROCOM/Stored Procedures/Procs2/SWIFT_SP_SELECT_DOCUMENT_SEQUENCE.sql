-- =============================================
-- Autor:				PEDRO LOUKOTA
-- Fecha de Creacion: 	03-12-2015
-- Description:			Seleciona la secuencia de documentos
--                      
/*
-- Ejemplo de Ejecucion:				
				--


-- TODO: Set parameter values here.

EXECUTE @RC = [PACASA].[SWIFT_SP_SELECT_DOCUMENT_SEQUENCE]


				--				
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_SELECT_DOCUMENT_SEQUENCE]

AS
BEGIN


	  SELECT * FROM [PACASA].[SWIFT_DOCUMENT_SEQUENCE]



END
