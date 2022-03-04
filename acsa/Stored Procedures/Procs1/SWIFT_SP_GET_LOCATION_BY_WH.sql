﻿-- =============================================
-- Autor:				jose.garcia
-- Fecha de Creacion: 	22-01-2016
-- Description:			Trae todas las ubicaciones que existen en una bodega especifica
--	
-- MODIFICADO: 14-03-2016
			-- diego.as
			-- Se agregaron nuevos Parametros a la consulta
/*
-- Ejemplo de Ejecucion:
								
	 EXEC [acsa].[SWIFT_SP_GET_LOCATION_BY_WH] 
			@WAREHOUSE='C001'
			,@CLASIFICTATION_ID = '60'
			,@PISO = 'NO'
			,@PASILLO = 'P01'
			,@RACK = 'R01'
			,@COLUMNA = 'C01'
			,@NIVEL = 'NA'

	---------------------------------------------

	EXEC [acsa].[SWIFT_SP_GET_LOCATION_BY_WH] 
			@WAREHOUSE='C001'
			,@CLASIFICTATION_ID = '60'
			,@PISO = 'NO'
			,@PASILLO = ''
			,@RACK = ''
			,@COLUMNA = ''
			,@NIVEL = ''

*/

CREATE PROCEDURE [acsa].[SWIFT_SP_GET_LOCATION_BY_WH]
(
	@WAREHOUSE VARCHAR(50)
	,@CLASIFICTATION_ID INT
	,@PASILLO VARCHAR(50)
	,@PISO VARCHAR(5)
	,@RACK VARCHAR(30)
	,@COLUMNA VARCHAR(30)
	,@NIVEL VARCHAR(30)
)
AS
BEGIN
	SELECT SVL.LOCATION 
		,SVL.CODE_LOCATION
		,SVL.BARCODE_LOCATION
		,SVL.CODE_WAREHOUSE
		,SVL.DESCRIPTION_WAREHOUSE
	FROM [acsa].SWIFT_VIEW_ALL_LOCATIONS AS SVL
	WHERE 
		SVL.CODE_WAREHOUSE = UPPER(@WAREHOUSE)
		AND SVL.CLASSIFICATION_ID = @CLASIFICTATION_ID
		AND SVL.FLOOR_LOCATION = UPPER(@PISO)
		AND (@PASILLO = '' OR SVL.HALL_LOCATION = UPPER(@PASILLO))
		AND (@RACK = '' OR SVL.RACK_LOCATION = UPPER(@RACK))
		AND (@COLUMNA = '' OR SVL.COLUMN_LOCATION = UPPER(@COLUMNA))
		AND (@NIVEL = '' OR SVL.LEVEL_LOCATION  = UPPER(@NIVEL))
END


