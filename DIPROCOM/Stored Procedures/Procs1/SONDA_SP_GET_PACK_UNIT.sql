﻿
-- =============================================
-- Author:         diego.as
-- Create date:    15-02-2016
-- Description:    Obtiene los registros de la Tabla 
--				   [DIPROCOM].[SONDA_PACK_UNIT]
--				   con control de errores.

--Modificacion 14-04-2016
                        -- alberto.ruiz
                        -- Se elimino columna de order
/*
Ejemplo de Ejecucion:

		EXEC [DIPROCOM].[SONDA_SP_GET_PACK_UNIT]	
				
*/
-- =============================================

CREATE PROCEDURE [DIPROCOM].[SONDA_SP_GET_PACK_UNIT]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
		[SPU].[PACK_UNIT]
		,[SPU].[CODE_PACK_UNIT]
		,[SPU].[DESCRIPTION_PACK_UNIT]
    ,[SPU].[UM_ENTRY]
	FROM [DIPROCOM].[SONDA_PACK_UNIT] AS SPU
END




