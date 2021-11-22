-- =============================================
-- Autor:				jonathan.salvador
-- Fecha de Creacion: 	22-10-2019
-- Description:			SP que obtiene los pedidos minimos por usuario
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_MINIMUM_ORDER_BY_USER]
AS
BEGIN

    SELECT [SMOU].[USER],
           [SMOU].[MINIMUM_ORDER],
           [U].[SELLER_ROUTE] AS [ROUTE_CODE],
           [SR].[NAME_ROUTE] AS [ROUTE_NAME]
    FROM [PACASA].[SWIFT_MINIMUM_ORDER_BY_USER] [SMOU]
        LEFT JOIN [PACASA].[USERS] [U]
            ON [U].[LOGIN] = [SMOU].[USER]
        LEFT JOIN [PACASA].[SWIFT_ROUTES] [SR]
            ON [U].[SELLER_ROUTE] = [SR].[CODE_ROUTE]
    ORDER BY [SMOU].[USER];
END;