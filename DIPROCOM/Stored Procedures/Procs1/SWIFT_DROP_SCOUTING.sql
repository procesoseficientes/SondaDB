/****** Object:  Table [DIPROCOM].[SWIFT_UPDATE_SCOUTING]   Script Date: 14/12/2015  ******/

-- Autor:				ppablo.loukota
-- Fecha de Creacion: 	14-12-2015
-- Description:			Elimina el procedimiento erroneo de SWIFT_UPDATE_SCOUTING
/*
--						Ejemplo de Ejecucion:				

						EXECUTE [DIPROCOM].[SWIFT_DROP_SCOUTING] 

*/
CREATE PROCEDURE [DIPROCOM].[SWIFT_DROP_SCOUTING]

AS

DROP PROCEDURE [DIPROCOM].[SWIFT_UPDATE_SCOUTING]

