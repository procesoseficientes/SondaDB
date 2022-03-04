-- =============================================
-- Autor:				        rudi.garcia
-- Fecha de Creacion:   12-Nov-2018 G-FORCE@Narwhal
-- Description:			    SP que obtiene el orden de aplicar los descuentos.

-- Modificacion 		10/25/2019 @ G-Force Team Sprint GEFORCE@MADRID
-- Autor: 				diego.as
-- Historia/Bug:		IMPLEMENTACION acsa HN
-- Descripcion: 		10/25/2019 - se agrega join a SWIFT_ROUTES para filtrar por el codigo de la ruta que esta iniciando en SONDA

/*
-- Ejemplo de Ejecucion:
				EXEC [acsa].SONDA_SP_GET_ORDER_FOR_DISCOUNT_FOR_APPLY
				@CODE_ROUTE = '540'
*/
-- =============================================
CREATE PROCEDURE [acsa].[SONDA_SP_GET_ORDER_FOR_DISCOUNT_FOR_APPLY] (@CODE_ROUTE VARCHAR(50))
AS
BEGIN
    SET NOCOUNT ON;
    --
    SELECT [ODD].[ORDER_FOR_DISCOUNT_HEADER_ID],
           [ODD].[ORDER_FOR_DISCOUNT_DETAIL_ID],
           [ODD].[ORDER],
           [ODD].[CODE_DISCOUNT],
           [ODD].[DESCRIPTION]
    FROM [acsa].[SWIFT_ORDER_FOR_DISCOUNT_DETAIL] [ODD]
        INNER JOIN [acsa].[SWIFT_ORDER_FOR_DISCOUNT_BY_ROUTE] [ODR]
            ON ([ODD].[ORDER_FOR_DISCOUNT_HEADER_ID] = [ODR].[ORDER_FOR_DISCOUNT_HEADER_ID])
        INNER JOIN [acsa].[SWIFT_ROUTES] AS [R]
            ON ([R].[ROUTE] = [ODR].[ROUTE_ID])
    WHERE [R].[CODE_ROUTE] = @CODE_ROUTE;
END;