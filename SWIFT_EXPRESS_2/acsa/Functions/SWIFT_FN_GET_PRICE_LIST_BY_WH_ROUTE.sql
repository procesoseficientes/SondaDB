﻿-- =============================================
-- Autor:				jose.garcia
-- Fecha de Creacion: 	09-12-2015
-- Description:			Obtiene lista de precios por  bodega regional

/*
-- Ejemplo de Ejecucion:
				SELECT [SONDA].[SWIFT_FN_GET_PRICE_LIST_BY_WH_ROUTE]('HUE0003@[SONDA]')
*/
-- =============================================
CREATE FUNCTION [SONDA].[SWIFT_FN_GET_PRICE_LIST_BY_WH_ROUTE]
(
	@RUTA VARCHAR(50) 
)
RETURNS VARCHAR(25)
AS
BEGIN
	DECLARE @CODE_PRICE_LIST VARCHAR(25)
	DECLARE @WH VARCHAR(25)
	--


	    
		SELECT @WH =PRESALE_WAREHOUSE
		FROM [SONDA].USERS
		WHERE SELLER_ROUTE=@RUTA


		SELECT @CODE_PRICE_LIST = VALUE_TEXT_CLASSIFICATION
		FROM [SONDA].SWIFT_CLASSIFICATION
		WHERE 
			GROUP_CLASSIFICATION ='WAREHOUSE_PRICELIST' 
			AND NAME_CLASSIFICATION =@WH
	
	--
	RETURN @CODE_PRICE_LIST
END