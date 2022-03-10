﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	29-02-2016
-- Description:			SP que importa bodegas

/*
-- Ejemplo de Ejecucion:
				-- 
				EXEC [SWIFT_INTERFACES_QA].[diprocom].[BULK_DATA_SP_IMPORT_WAREHOUSE]
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[BULK_DATA_SP_IMPORT_WAREHOUSE]
AS
BEGIN
	SET NOCOUNT ON;
	--
	MERGE [SWIFT_EXPRESS_QA].[diprocom].[SWIFT_WAREHOUSES] SWI 
	USING ( SELECT * FROM  [SWIFT_INTERFACES_ONLINE_QA].[diprocom].[ERP_VIEW_WAREHOUSE]) WVH 
	ON SWI.[CODE_WAREHOUSE] = WVH.[CODE_WAREHOUSE] 
	WHEN MATCHED THEN 
	UPDATE 
		SET SWI.[DESCRIPTION_WAREHOUSE]   =  WVH.[DESCRIPTION]
		   ,SWI.[WEATHER_WAREHOUSE]       =  WVH.[WEATHER_WAREHOUSE]
		   ,SWI.[STATUS_WAREHOUSE]        =  WVH.[STATUS_WAREHOUSE]
		   ,SWI.[LAST_UPDATE]             =  WVH.[LAST_UPDATE]
		   ,SWI.[LAST_UPDATE_BY]          =  WVH.[LAST_UPDATE_BY]
		   ,SWI.[IS_EXTERNAL]             =  WVH.[IS_EXTERNAL]
		   ,SWI.[ERP_WAREHOUSE]			  =  WVH.[CODE_WAREHOUSE]
		   ,SWI.[GPS_WAREHOUSE]			  =	 '0,0'
	WHEN NOT MATCHED THEN 
	INSERT (
		[CODE_WAREHOUSE]
		,[DESCRIPTION_WAREHOUSE]
		,[WEATHER_WAREHOUSE]
		,[STATUS_WAREHOUSE]
		,[LAST_UPDATE]
		,[LAST_UPDATE_BY]
		,[IS_EXTERNAL]
		,[ERP_WAREHOUSE]
		,[GPS_WAREHOUSE]
	) 
	VALUES (
		WVH.[CODE_WAREHOUSE]
		,WVH.[DESCRIPTION]
		,WVH.[WEATHER_WAREHOUSE]
		,WVH.[STATUS_WAREHOUSE]
		,WVH.[LAST_UPDATE]
		,WVH.[LAST_UPDATE_BY]
		,WVH.[IS_EXTERNAL]
		,WVH.[CODE_WAREHOUSE]
		,'0,0'
	 );
	 
	 --Location
	 MERGE [SWIFT_EXPRESS_QA].[diprocom].[SWIFT_LOCATIONS] SWI
	USING (SELECT * FROM [SWIFT_INTERFACES_ONLINE_QA].[diprocom].[ERP_VIEW_WAREHOUSE]) WVH 
	ON SWI.[CODE_WAREHOUSE] = WVH.[CODE_WAREHOUSE] 
	WHEN MATCHED THEN 
	UPDATE 
		SET [CODE_LOCATION]		   =  WVH.[CODE_WAREHOUSE]
		,[CODE_WAREHOUSE]		   =  WVH.[CODE_WAREHOUSE]
		,[CLASSIFICATION_LOCATION] =  40
		,[HALL_LOCATION]		   =  WVH.[CODE_WAREHOUSE]
		,[ALLOW_PICKING]		   =  'NO'
		,[LAST_UPDATE]			   =  WVH.[LAST_UPDATE]
		,[LAST_UPDATE_BY]		   =  WVH.[LAST_UPDATE_BY]
		,[BARCODE_LOCATION]		   =  WVH.[CODE_WAREHOUSE]
		,[DESCRIPTION_LOCATION]	   =  WVH.[CODE_WAREHOUSE]
		,[RACK_LOCATION]		   =  WVH.[CODE_WAREHOUSE]
		,[COLUMN_LOCATION]		   =  WVH.[CODE_WAREHOUSE]
		,[LEVEL_LOCATION]		   =  WVH.[CODE_WAREHOUSE]
		,[SQUARE_METER_LOCATION]   =  100
		,[FLOOR_LOCATION]		   =  'SI'
		,[ALLOW_STORAGE]		   =  'SI'
		,[ALLOW_RELOCATION]		   =  'NO'
		,[STATUS_LOCATION]		   =  'HABILITADA'
	WHEN NOT MATCHED THEN 
	INSERT (
		[CODE_LOCATION]
		,[CODE_WAREHOUSE]
		,[CLASSIFICATION_LOCATION]
		,[HALL_LOCATION]
		,[ALLOW_PICKING]
		,[LAST_UPDATE]
		,[LAST_UPDATE_BY]
		,[BARCODE_LOCATION]
		,[DESCRIPTION_LOCATION]
		,[RACK_LOCATION]
		,[COLUMN_LOCATION]
		,[LEVEL_LOCATION]
		,[SQUARE_METER_LOCATION]
		,[FLOOR_LOCATION]
		,[ALLOW_STORAGE]
		,[ALLOW_RELOCATION]
		,[STATUS_LOCATION]
	) 
	VALUES (
		WVH.[CODE_WAREHOUSE]
		,WVH.[CODE_WAREHOUSE]
		,45
		,WVH.[CODE_WAREHOUSE]
		,'NO'
		,WVH.[LAST_UPDATE]
		,WVH.[LAST_UPDATE_BY]
		,WVH.[CODE_WAREHOUSE]
		,WVH.[CODE_WAREHOUSE]
		,WVH.[CODE_WAREHOUSE]
		,WVH.[CODE_WAREHOUSE]
		,WVH.[CODE_WAREHOUSE]
		,100
		,'SI'
		,'SI'
		,'NO'
		,'HABILITADA'
	 );

END