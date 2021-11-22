/****** Object:  Table [PACASA].[SWIFT_UPDATE_SCOUTING]   Script Date: 14/12/2015  ******/

-- Autor:				ppablo.loukota
-- Fecha de Creacion: 	14-12-2015
-- Description:			Elimina el procedimiento erroneo de SWIFT_UPDATE_SCOUTING
/*
--						Ejemplo de Ejecucion:				

						EXECUTE [PACASA].[SWIFT_DROP_SCOUTING] 

*/
CREATE PROCEDURE [PACASA].[SWIFT_DROP_SCOUTING]

AS

DROP PROCEDURE [PACASA].[SWIFT_UPDATE_SCOUTING]

