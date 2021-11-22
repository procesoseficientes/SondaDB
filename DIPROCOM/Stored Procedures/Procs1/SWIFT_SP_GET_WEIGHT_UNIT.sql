
-- =============================================
-- Autor:				ppablo.loukota
-- Fecha de Creacion: 	11-01-2016
-- Description:			Obtiene la unidad de peso de la tabla

/*
-- Ejemplo de Ejecucion:				
				--
EXECUTE  [PACASA].[SWIFT_SP_GET_WEIGHT_UNIT]

				--				
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_WEIGHT_UNIT]

AS
BEGIN 

  SET NOCOUNT ON;

  SELECT [CODE] ,[DESCRIPTION] FROM [PACASA].[SWIFT_MEASURE_UNIT] WHERE [TYPE] = 'PESO'

END








