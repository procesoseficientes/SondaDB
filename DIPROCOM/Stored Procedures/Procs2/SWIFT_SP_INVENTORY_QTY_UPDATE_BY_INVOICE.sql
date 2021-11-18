﻿-- =============================================
-- Author:		rudi.garcia
-- Create date: 30-01-2016
-- Description:	Actualiza el el inventario

-- Modificacion 07-Mar-17 @ A-Team Sprint Ebonne
					-- alberto.ruiz
					-- Se agrega parametro de serie

/*
--Ejemplo de Ejecucion:
		--Sin serie
		SELECT * FROM [acsa].[SWIFT_INVENTORY] WHERE [WAREHOUSE] = 'C001' AND [LOCATION] = 'C001' AND [SKU] = '100017'
		--
		EXEC [acsa].[SWIFT_SP_INVENTORY_QTY_UPDATE_BY_INVOICE] 
			@WAREHOUSE = 'C001', -- varchar(50)
			@LOCATION = 'C001', -- varchar(50)
			@SKU = '100017', -- varchar(50)
			@QTY = 25 -- int
		--
		SELECT * FROM [acsa].[SWIFT_INVENTORY] WHERE [WAREHOUSE] = 'C001' AND [LOCATION] = 'C001' AND [SKU] = '100017'

		--Con serie
		SELECT * FROM [acsa].[SWIFT_INVENTORY] WHERE [WAREHOUSE] = 'C001' AND [LOCATION] = 'A3' AND [SKU] = '100030' AND [SERIAL_NUMBER] = '1000000000'
		--
		EXEC [acsa].[SWIFT_SP_INVENTORY_QTY_UPDATE_BY_INVOICE] 
			@WAREHOUSE = 'C001', -- varchar(50)
			@LOCATION = 'A3', -- varchar(50)
			@SKU = '100030', -- varchar(50)
			@QTY = 1, -- int
			@SERIAL_NUMBER = '1000000000' -- varchar(150)
		--
		SELECT * FROM [acsa].[SWIFT_INVENTORY] WHERE [WAREHOUSE] = 'C001' AND [LOCATION] = 'A3' AND [SKU] = '100030' AND [SERIAL_NUMBER] = '1000000000'
*/	
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_INVENTORY_QTY_UPDATE_BY_INVOICE]
	@WAREHOUSE VARCHAR(50)
	,@LOCATION VARCHAR(50)
	,@SKU VARCHAR(50)
	,@QTY INT
	,@SERIAL_NUMBER VARCHAR(150) = NULL
AS
BEGIN	
	SET NOCOUNT ON;
	--
	DECLARE @HANDLE_SERIAL_NUMBER INT = 0
	--
	SELECT TOP 1
		@HANDLE_SERIAL_NUMBER = [S].[HANDLE_SERIAL_NUMBER]
	FROM [acsa].[SWIFT_VIEW_ALL_SKU] [S]
	WHERE [S].[CODE_SKU] = @SKU
	--
	SET ROWCOUNT 1
	--
    UPDATE [acsa].[SWIFT_INVENTORY] 
	SET [ON_HAND] = ([ON_HAND] + @QTY)
	WHERE WAREHOUSE = @WAREHOUSE
	AND LOCATION = @LOCATION
	AND SKU = @SKU
	AND (
		@HANDLE_SERIAL_NUMBER = 0
		OR
		[SERIAL_NUMBER] = @SERIAL_NUMBER
	)
	--
	SET ROWCOUNT 0
END



