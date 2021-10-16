﻿-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		12-05-2016
-- Description:			    SP que envia la lista de precios por escalas y unidad de medida

-- Modificacion 17-Feb-17 @ A-Team Sprint Chatulika
					-- alberto.ruiz
					-- Se agrego distinct al select final
/*
-- Ejemplo de Ejecucion:
        EXEC [DIPROCOM].[SWIFT_SP_GET_PRICE_LIST_BY_SKU_PACK_SCALE]
			@CODE_ROUTE = 'HUE0003@DIPROCOM'
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_PRICE_LIST_BY_SKU_PACK_SCALE_bk_anterior] (
	@CODE_ROUTE VARCHAR(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT DISTINCT
		splbc.CODE_PRICE_LIST
	INTO #PRICE_LIST
	FROM DIPROCOM.SONDA_ROUTE_PLAN srp
	INNER JOIN DIPROCOM.SWIFT_PRICE_LIST_BY_CUSTOMER splbc ON (
		srp.RELATED_CLIENT_CODE = splbc.CODE_CUSTOMER
	)
	WHERE srp.CODE_ROUTE = @CODE_ROUTE
	--

	DECLARE @WAREHOUSES VARCHAR(50)
	SELECT @WAREHOUSES =PRESALE_WAREHOUSE FROM DIPROCOM.USERS
	WHERE SELLER_ROUTE=@CODE_ROUTE

	

	INSERT INTO #PRICE_LIST (CODE_PRICE_LIST)

	SELECT  DIPROCOM.[SWIFT_FN_GET_PRICE_LIST_BY_WH](@WAREHOUSES)
	--SELECT DIPROCOM.SWIFT_FN_GET_PARAMETER('ERP_HARDCODE_VALUES','PRICE_LIST');
	--
	SELECT DISTINCT
		PL.[CODE_PRICE_LIST]
		,PL.[CODE_SKU]
		,PL.[CODE_PACK_UNIT]
		,PL.[PRIORITY]
		,PL.[LOW_LIMIT]
		,PL.[HIGH_LIMIT]
		,PL.[PRICE]
	FROM [DIPROCOM].[SWIFT_PRICE_LIST_BY_SKU_PACK_SCALE] AS PL
	INNER JOIN #PRICE_LIST l ON (l.CODE_PRICE_LIST = PL.CODE_PRICE_LIST)  

END
