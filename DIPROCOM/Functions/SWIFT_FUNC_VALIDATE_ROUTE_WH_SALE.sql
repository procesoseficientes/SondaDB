﻿/*
	-- =============================================
-- Autor:				JOSE ROBERTO
-- Fecha de Creacion: 	10-12-2015
-- Description:			Función que valida que la ruta VENTA-DIRECTA tenga una bodega asignada
--						una bodega de venta.

-- Ejemplo de Ejecucion:	
							SELECT [PACASA].[SWIFT_FUNC_VALIDATE_ROUTE_WH_SALE]('001')
-- =============================================
*/
CREATE FUNCTION [PACASA].[SWIFT_FUNC_VALIDATE_ROUTE_WH_SALE]
( 
	@CODE_ROUTE VARCHAR(50)
)

RETURNS BIT
AS
BEGIN
	DECLARE @WH BIT = 0
	--
	SELECT @WH = COUNT(*)
	FROM  [PACASA].[SWIFT_ROUTES] RT
		INNER JOIN [PACASA].[SWIFT_VIEW_USERS] VU ON (RT.CODE_ROUTE = VU.SELLER_ROUTE)
		INNER JOIN [PACASA].SWIFT_VIEW_WAREHOUSES VH ON (VU.DEFAULT_WAREHOUSE = VH.DESCRIPTION_WAREHOUSE)
	WHERE RT.CODE_ROUTE = @CODE_ROUTE
	--
	RETURN @WH
 END;

