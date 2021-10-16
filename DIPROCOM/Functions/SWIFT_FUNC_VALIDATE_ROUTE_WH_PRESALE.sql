﻿/*
	-- =============================================
-- Autor:				JOSE ROBERTO
-- Fecha de Creacion: 	09-12-2015
-- Description:			Función que valida que la ruta tenga una bodega asignada.

-- Ejemplo de Ejecucion:	
							SELECT [DIPROCOM].[SWIFT_FUNC_VALIDATE_ROUTE_WH_PRESALE]('001')
-- =============================================
*/
CREATE FUNCTION [DIPROCOM].[SWIFT_FUNC_VALIDATE_ROUTE_WH_PRESALE]
( 
	@CODE_ROUTE VARCHAR(50)
)

RETURNS BIT
AS
BEGIN
	DECLARE @WH BIT = 0
	--
	SELECT @WH = COUNT(*)
	FROM  [DIPROCOM].[SWIFT_ROUTES] RT
		INNER JOIN [DIPROCOM].[SWIFT_VIEW_USERS] VU ON (RT.CODE_ROUTE = VU.SELLER_ROUTE)
		INNER JOIN [DIPROCOM].SWIFT_VIEW_WAREHOUSES VH ON (VU.PRESALE_WAREHOUSE = VH.DESCRIPTION_WAREHOUSE)
	WHERE RT.CODE_ROUTE = @CODE_ROUTE



	--
	RETURN @WH
 END;

