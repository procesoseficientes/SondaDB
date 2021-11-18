﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	22-01-2016
-- Description:			Obtiene clientes no asociados a una frecuencia

-- Modificacion 15-02-2016
				-- alberto.ruiz
				-- Se cambia la condicion de los dias de AND por OR

/*
-- Ejemplo de Ejecucion:
				-- 
				EXEC [acsa].[SWIFT_SP_GET_CUSTOMER_NO_ASSOCIATE]
					@ID_FREQUENCY = 1059
					,@CODE_ROUTE = '001'
					,@FREQUENCY = 0
					,@SUNDAY = 0
					,@MONDAY = 1
					,@TUESDAY = 0
					,@WEDNESDAY = 0
					,@THURSDAY = 0
					,@FRIDAY = 0
					,@SATURDAY = 0
*/
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_GET_CUSTOMER_NO_ASSOCIATE]
	@ID_FREQUENCY INT
	,@CODE_ROUTE VARCHAR(50)
	,@FREQUENCY INT = 0
	,@SUNDAY INT = 0
	,@MONDAY INT = 0
	,@TUESDAY INT = 0
	,@WEDNESDAY INT = 0
	,@THURSDAY INT = 0
	,@FRIDAY INT = 0
	,@SATURDAY INT = 0
AS
BEGIN
	SET NOCOUNT ON;
	--
	DECLARE 
		@SQL NVARCHAR(2000) = ''
		,@HAVE_DAY INT = 0
	--
	SELECT @HAVE_DAY = CASE WHEN 
			@SUNDAY = 1
			OR @MONDAY = 1
			OR @TUESDAY = 1
			OR @WEDNESDAY = 1
			OR @THURSDAY = 1
			OR @FRIDAY = 1
			OR @SATURDAY = 1
		THEN 1 ELSE 0 END
	--
	CREATE TABLE #CLIENT (
		CODE_CUSTOMER VARCHAR(50)
		,IS_IN INT
	)
	
	-- ------------------------------------------------------------------------------------
	-- Obtiene clientes en poligono de ruta 
	-- ------------------------------------------------------------------------------------
	INSERT INTO #CLIENT
	EXEC [acsa].[SWIFT_SP_GET_CUSTOMERS_IN_POLYGON] @CODE_ROUTE = @CODE_ROUTE

	-- ------------------------------------------------------------------------------------
	-- Forma query dinamico
	-- ------------------------------------------------------------------------------------
	SELECT @SQL = 'SELECT 
		C.CODE_CUSTOMER
		,C.NAME_CUSTOMER
	FROM [acsa].[SWIFT_VIEW_ALL_COSTUMER] C
	INNER JOIN #CLIENT T ON (C.CODE_CUSTOMER = T.CODE_CUSTOMER)
	WHERE C.CODE_CUSTOMER NOT IN (SELECT F.CODE_CUSTOMER FROM [acsa].[SWIFT_FREQUENCY_X_CUSTOMER] F WHERE F.ID_FREQUENCY = ' + CAST(@ID_FREQUENCY AS VARCHAR) + ')'
	+ CASE WHEN @FREQUENCY > 0 THEN ' AND C.FREQUENCY = ''' + CAST(@FREQUENCY AS VARCHAR) + '''' ELSE '' END
	+ CASE WHEN @HAVE_DAY = 1 THEN ' AND (' ELSE '' END
	+ CASE WHEN @SUNDAY = 1 THEN 'C.SUNDAY = 1' ELSE '' END
	+ CASE WHEN @MONDAY = 1 AND @SUNDAY = 1 THEN ' OR' ELSE '' END
	+ CASE WHEN @MONDAY = 1 THEN ' C.MONDAY = 1' ELSE '' END
	+ CASE WHEN @TUESDAY = 1 AND (@SUNDAY = 1 OR @MONDAY = 1) THEN ' OR' ELSE '' END
	+ CASE WHEN @TUESDAY = 1 THEN ' C.TUESDAY = 1' ELSE '' END
	+ CASE WHEN @WEDNESDAY = 1 AND (@SUNDAY = 1 OR @MONDAY = 1 OR @TUESDAY = 1) THEN ' OR' ELSE '' END
	+ CASE WHEN @WEDNESDAY = 1 THEN ' C.WEDNESDAY = 1' ELSE '' END
	+ CASE WHEN @THURSDAY = 1 AND (@SUNDAY = 1 OR @MONDAY = 1 OR @TUESDAY = 1 OR @WEDNESDAY = 1) THEN ' OR' ELSE '' END
	+ CASE WHEN @THURSDAY = 1 THEN ' C.THURSDAY = 1' ELSE '' END
	+ CASE WHEN @FRIDAY = 1 AND (@SUNDAY = 1 OR @MONDAY = 1 OR @TUESDAY = 1 OR @WEDNESDAY = 1 OR @THURSDAY = 1) THEN ' OR' ELSE '' END
	+ CASE WHEN @FRIDAY = 1 THEN ' C.FRIDAY = 1' ELSE '' END
	+ CASE WHEN @SATURDAY = 1 AND (@SUNDAY = 1 OR @MONDAY = 1 OR @TUESDAY = 1 OR @WEDNESDAY = 1 OR @THURSDAY = 1 OR @FRIDAY = 1) THEN ' OR' ELSE '' END
	+ CASE WHEN @SATURDAY = 1 THEN ' C.SATURDAY = 1' ELSE '' END
	+ CASE WHEN @HAVE_DAY = 1 THEN ')' ELSE '' END
	--
	PRINT '@ID_FREQUENCY: ' + CAST(@ID_FREQUENCY AS VARCHAR)
	PRINT '@CODE_ROUTE: ' + CAST(@CODE_ROUTE AS VARCHAR)
	PRINT '@FREQUENCY: ' + CAST(@FREQUENCY AS VARCHAR)
	PRINT '@SUNDAY: ' + CAST(@SUNDAY AS VARCHAR)
	PRINT '@MONDAY: ' + CAST(@MONDAY AS VARCHAR)
	PRINT '@TUESDAY: ' + CAST(@TUESDAY AS VARCHAR)
	PRINT '@WEDNESDAY: ' + CAST(@WEDNESDAY AS VARCHAR)
	PRINT '@THURSDAY: ' + CAST(@THURSDAY AS VARCHAR)
	PRINT '@FRIDAY: ' + CAST(@FRIDAY AS VARCHAR)
	PRINT '@SATURDAY: ' + CAST(@SATURDAY AS VARCHAR)
	PRINT '@SQL: ' + @SQL
	--
	EXEC SP_EXECUTESQL @SQL

END
