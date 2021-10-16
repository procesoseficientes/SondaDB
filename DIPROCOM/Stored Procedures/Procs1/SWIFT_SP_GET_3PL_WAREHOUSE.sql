﻿-- ======================================================
-- Autor:				        diego.as
-- Fecha de Creacion: 	10-01-2017 @ A-TEAM Sprint Balder
-- Description:			SP que obtiene las bodegas de 3PL
/*
  Ejemplo de Ejecucion:
  --
    EXEC [DIPROCOM].SWIFT_SP_GET_3PL_WAREHOUSE
      @CODE_WAREHOUSE = 'BOD.503'
*/

-- ======================================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_3PL_WAREHOUSE]
(
  @CODE_WAREHOUSE VARCHAR(50) = NULL
  )
  AS
BEGIN

	SELECT
	[WAREHOUSE] 
	,[CODE_WAREHOUSE] 
	,[DESCRIPTION_WAREHOUSE]
	,[WEATHER_WAREHOUSE] 
	,[STATUS_WAREHOUSE] 
	,[LAST_UPDATE] 
	,[LAST_UPDATE_BY] 
	,[IS_EXTERNAL] 
	,[BARCODE_WAREHOUSE] 
	,[SHORT_DESCRIPTION_WAREHOUSE]
	,[TYPE_WAREHOUSE] 
	,[ERP_WAREHOUSE] 
	,[ADDRESS_WAREHOUSE] 
	,[GPS_WAREHOUSE] 
	,[CODE_WAREHOUSE_3PL]
	,[SALES_OFFICE_ID] 
	FROM [DIPROCOM].[SWIFT_WAREHOUSES]	
		WHERE ([CODE_WAREHOUSE] = @CODE_WAREHOUSE OR [CODE_WAREHOUSE] IS NULL)
 -- SELECT 
 --W.[CODE_WAREHOUSE]
 --,[oww].[WAREHOUSE_ID]
 --,[oww].[NAME]
 --,[oww].[COMMENTS]
 --,[oww].[ERP_WAREHOUSE]
 --,[oww].[ALLOW_PICKING]
 --,[oww].[DEFAULT_RECEPTION_LOCATION]
 --,[oww].[SHUNT_NAME]
 --,[oww].[WAREHOUSE_WEATHER]
 --,[oww].[WAREHOUSE_STATUS]
 --,[oww].[IS_3PL_WAREHUESE]
 --,[oww].[WAHREHOUSE_ADDRESS]
 --,[oww].[GPS_URL]
 --,[oww].[DISTRIBUTION_CENTER_ID]
 --FROM [DIPROCOM].[OP_WMS_WAREHOUSES] [oww]
 -- LEFT JOIN [DIPROCOM].[SWIFT_WAREHOUSES] [W] ON (
 --   [oww].[WAREHOUSE_ID] = [W].[CODE_WAREHOUSE_3PL]
 -- )
 -- WHERE (W.[CODE_WAREHOUSE] = @CODE_WAREHOUSE OR W.[CODE_WAREHOUSE] IS NULL)
  END
