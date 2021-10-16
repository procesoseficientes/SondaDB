
-- =============================================
-- Autor:				ppablo.loukota
-- Fecha de Creacion: 	11-01-2016
-- Description:			Obtiene la unidad de peso de la tabla

/*
-- Ejemplo de Ejecucion:				
				--
EXECUTE  [DIPROCOM].[SWIFT_SP_GET_WEIGHT_UNIT]

				--				
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_WEIGHT_UNIT]

AS
BEGIN 

  SET NOCOUNT ON;

  SELECT [CODE] ,[DESCRIPTION] FROM [DIPROCOM].[SWIFT_MEASURE_UNIT] WHERE [TYPE] = 'PESO'

END








