-- =============================================
-- Autor:				Jose Roberto
-- Fecha de Creacion: 	13-11-2015
-- Description:			Llama todas las ordenes de compras

/*
-- Ejemplo de Ejecucion:
				exec [PACASA].SONDA_SP_GET_ORDER_SALE
*/
-- =============================================
CREATE PROCEDURE [PACASA].SONDA_SP_GET_ORDER_SALE
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT * 
	FROM [PACASA].[SONDA_SALES_ORDER_HEADER]
	WHERE IS_READY_TO_SEND=1
END
