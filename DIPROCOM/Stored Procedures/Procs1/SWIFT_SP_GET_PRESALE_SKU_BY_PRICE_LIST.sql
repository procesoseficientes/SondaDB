﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	13-04-2016
-- Description:			Crea detalle de la orden de venta

/*
-- EJEMPLO DE EJECUCION: 
		EXEC [DIPROCOM].[SWIFT_SP_GET_PRESALE_SKU_BY_PRICE_LIST]
			@LOGIN = 'RUDI@DIPROCOM'
			,@CODE_PRICE_LIST = '1'
*/		
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_PRESALE_SKU_BY_PRICE_LIST]
		@LOGIN VARCHAR(50)
		,@CODE_PRICE_LIST VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT
		S.SKU
		,S.SKU_DESCRIPTION
		,P.COST
		,CAST(S.ON_HAND AS INT) ON_HAND
		,CAST(S.IS_COMITED AS INT) IS_COMITED
		,CAST((S.ON_HAND - S.IS_COMITED) AS INT) DIFERENCE
	FROM DIPROCOM.[USERS] U
	INNER JOIN DIPROCOM.[SWIFT_VIEW_PRESALE_SKU] S ON (U.PRESALE_WAREHOUSE = S.WAREHOUSE)
	INNER JOIN DIPROCOM.[SWIFT_PRICE_LIST_BY_SKU] P ON (S.SKU = P.CODE_SKU)
	WHERE U.[LOGIN] = @LOGIN
		AND P.COST > 0
		AND [P].[CODE_PRICE_LIST] = @CODE_PRICE_LIST
END



