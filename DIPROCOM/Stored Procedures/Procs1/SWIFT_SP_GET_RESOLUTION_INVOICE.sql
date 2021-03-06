-- =============================================
-- Autor:				ppablo.loukota
-- Fecha de Creacion: 	03-12-2015
-- Description:			Selecciona las resoluciones filtradas
--                      
/*
DECLARE @RC int

-- Ejemplo de Ejecucion:

		EXECUTE  [PACASA].[SWIFT_SP_GET_RESOLUTION_INVOICE] @CODE_ROUTE = '51'
		
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_RESOLUTION_INVOICE]
	@CODE_ROUTE [varchar](100)
AS
BEGIN
--DECLARE 
--@CODE_ROUTE [varchar](100) = '51'
	SELECT
		S.AUTH_ID
		,S.AUTH_SERIE
		,s.[AUTH_ASSIGNED_TO]
		,S.AUTH_DOC_FROM
		,S.AUTH_DOC_TO
		,S.AUTH_CURRENT_DOC
		,CAST(CAST(S.AUTH_POST_DATETIME AS DATE) AS VARCHAR) AUTH_POST_DATETIME
		,CAST(CAST(S.AUTH_LIMIT_DATETIME AS DATE) AS VARCHAR) AUTH_LIMIT_DATETIME
	FROM [PACASA].[SONDA_POS_RES_SAT] S
	WHERE  [AUTH_ASSIGNED_TO] = @CODE_ROUTE 
	AND AUTH_LIMIT_DATETIME > GETDATE()
END