-- =============================================
-- Autor:				rudi.garcia
-- Fecha de Creacion: 	12-11-2015
-- Description:			Se insertar los sku para la preventa

/*
-- Ejemplo de Ejecucion:
				exec [PACASA].[SWIFT_SP_INSERT_IS_COMITED_PRESALE]
				select * from [PACASA].[SONDA_IS_COMITED_BY_WAREHOUSE]
*/

CREATE PROC [PACASA].[SWIFT_SP_INSERT_IS_COMITED_PRESALE]
	  
AS
BEGIN	
	TRUNCATE TABLE  [PACASA].[SONDA_IS_COMITED_BY_WAREHOUSE]
	--
	INSERT INTO [PACASA].[SONDA_IS_COMITED_BY_WAREHOUSE]
	SELECT DISTINCT I.WAREHOUSE , I.SKU, 0
	FROM  [PACASA].[SWIFT_INVENTORY] I
	INNER JOIN [PACASA].[USERS] U ON (U.PRESALE_WAREHOUSE = I.WAREHOUSE)
	GROUP BY  I.WAREHOUSE , I.SKU	
END



