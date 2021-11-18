﻿/****** Object:  StoredProcedure [acsa].[SWIFT_SP_GET_RELOCATE_INVENTORY_BY_DATE]    Script Date: 20/12/2015 9:09:38 AM ******/
-- =============================================
-- Autor:				JOSE ROBERTO
-- Fecha de Creacion: 	02-12-2015
-- Description:			Manda a llamar todos los registros que han sido reubicados en el inventario 
--                      durante un periodo de fechas establecidos


/*
-- Ejemplo de Ejecucion:				
				--
				exec [acsa].[SWIFT_SP_GET_RELOCATE_INVENTORY_BY_DATE]
				--				
*/
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_GET_RELOCATE_INVENTORY_BY_DATE]
	@STARDATE DateTime
   ,@ENDDATE DateTime
AS
	SELECT 
		 R.ID_RELOCATE
		,R.CODE_SKU
		,S.DESCRIPTION_SKU
		,CASE 
			WHEN R.SERIAL != '' THEN R.SERIAL
			ELSE '...' END AS SERIAL_NUMBER
		,R.WAREHOUSE_SOURCE
		,R.WAREHOUSE_TARGET
		,WS.DESCRIPTION_WAREHOUSE AS WAREHOUSE_SOURCE_NAME
		,WT.DESCRIPTION_WAREHOUSE AS WAREHOUSE_TARGET_NAME
		,R.LOCATION_SOURCE
		,R.LOCATION_TARGET
		,R.QTY
		,R.LAST_UPDATE_BY
		,R.LAST_UPDATE
	FROM [acsa].[SWIFT_LOG_RELOCATE_INVENTORY] R
		INNER JOIN [acsa].[SWIFT_VIEW_WAREHOUSES] WS ON (R.WAREHOUSE_SOURCE = WS.CODE_WAREHOUSE)
		INNER JOIN [acsa].[SWIFT_VIEW_WAREHOUSES] WT ON (R.WAREHOUSE_TARGET = WT.CODE_WAREHOUSE)
		INNER JOIN [acsa].[SWIFT_VIEW_ALL_SKU] S ON (R.CODE_SKU = S.CODE_SKU)
	WHERE CONVERT(DATE,R.LAST_UPDATE) BETWEEN CONVERT(DATE,@STARDATE) AND CONVERT(DATE,@ENDDATE) 
	


