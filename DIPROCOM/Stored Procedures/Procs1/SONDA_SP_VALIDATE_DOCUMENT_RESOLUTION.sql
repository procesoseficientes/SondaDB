﻿-- =============================================
-- Autor:				eder.chamale
-- Fecha de Creacion: 	13-06-2017
-- Description:			Valida el número de la resolución

/*
-- Ejemplo de Ejecucion:
DECLARE
	@AUTH_ID VARCHAR(50) = 'PAYMENT'
	,@AUTH_SERIE VARCHAR(100) = 'AAA'
	,@AUTH_CURRENT_DOC INT = 1;
			
			
SELECT TOP 1 @AUTH_ID = [r].[AUTH_ID], @AUTH_SERIE = r.[AUTH_SERIE], @AUTH_CURRENT_DOC = r.[AUTH_CURRENT_DOC] FROM [PACASA].[SONDA_POS_RES_SAT] r WHERE R.[AUTH_ASSIGNED_TO] = '-001' AND R.[AUTH_STATUS] = '1' ORDER BY R.[AUTH_POST_DATETIME];
					
--
EXEC [PACASA].[SONDA_SP_VALIDATE_DOCUMENT_RESOLUTION] @AUTH_ID = @AUTH_ID , -- varchar(50)
	@AUTH_SERIE = @AUTH_SERIE , -- varchar(100)
	@AUTH_CURRENT_DOC = @AUTH_CURRENT_DOC-- int
--

*/
-- =============================================
CREATE PROCEDURE [PACASA].[SONDA_SP_VALIDATE_DOCUMENT_RESOLUTION]
	(
		@AUTH_ID VARCHAR(50)
		,@AUTH_SERIE VARCHAR(100)
		,@AUTH_CURRENT_DOC INT
	)
AS
	BEGIN			
		BEGIN TRY
			SELECT
				1 [RESULT]
			FROM
				[SONDA_POS_RES_SAT]
			WHERE
				[AUTH_CURRENT_DOC] = @AUTH_CURRENT_DOC
				AND [AUTH_ID] = @AUTH_ID
				AND [AUTH_SERIE] = @AUTH_SERIE
				AND [AUTH_STATUS] = '1';
		END TRY
		BEGIN CATCH			
			DECLARE	@ERROR VARCHAR(1000) = ERROR_MESSAGE();
			PRINT 'CATCH: ' + @ERROR;
			RAISERROR (@ERROR,16,1);
		END CATCH;
	END;