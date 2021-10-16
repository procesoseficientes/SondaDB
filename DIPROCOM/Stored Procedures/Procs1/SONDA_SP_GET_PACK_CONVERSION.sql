-- =============================================
-- Author:         diego.as
-- Create date:    15-02-2016
-- Description:    Obtiene los registros de la Tabla 
--				   [SONDA].[SONDA_PACK_CONVERSION]
--				   con control de errores.

-- Modificacion:	alejandro.ochoa
-- Create date:		15-10-2018 @DIPROCOM
-- Description:		Se cambian los alias de las columnas de los packunit para que funcionen las unidades de conversion en el movil.

/*
Ejemplo de Ejecucion:

		EXEC [SONDA].[SONDA_SP_GET_PACK_CONVERSION]	
				
*/
-- =============================================

CREATE PROC [SONDA].[SONDA_SP_GET_PACK_CONVERSION]
AS
BEGIN
  SET NOCOUNT ON;
  SELECT
    [SPC].[PACK_CONVERSION]
   ,[SPC].[CODE_SKU]
   ,[SPC].[CODE_PACK_UNIT_FROM] [CODE_PACK_UNIT_TO]
   ,[SPC].[CODE_PACK_UNIT_TO] [CODE_PACK_UNIT_FROM]
   ,[SPC].[CONVERSION_FACTOR]
   ,[SPC].[ORDER]
  FROM [SONDA].[SONDA_PACK_CONVERSION] AS SPC
END



