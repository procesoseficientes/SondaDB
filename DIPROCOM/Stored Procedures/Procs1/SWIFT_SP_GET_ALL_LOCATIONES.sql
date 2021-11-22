-- exec 
-- =============================================
-- Autor:				jose.garcia
-- Fecha de Creacion: 	21-01-2016
-- Description:			Trae todas las locaciones de bodega

/*
-- Ejemplo de Ejecucion:				
				-- EXEC [PACASA].[SWIFT_SP_GET_ALL_LOCATIONES]
				--				
*/
-- =============================================

CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_ALL_LOCATIONES]
AS
Select L.[CODE_LOCATION]
from [PACASA].[SWIFT_LOCATIONS] L



