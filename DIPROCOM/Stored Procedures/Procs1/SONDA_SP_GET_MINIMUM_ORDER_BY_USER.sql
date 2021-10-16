﻿-- =============================================================================
-- AUTHOR:		denis.villagrán
-- CREATE DATE:	2019-10-30 16:58:22
-- DATABASE:	SWIFT_EXPRESS
-- DESCRIPTION:	SP que obtiene el monto mínimo para venta de ruta
-- Historia: 33185: Restriccion de Pedido Minimo en el movil - G-Force@Madrid
-- =============================================================================
CREATE PROCEDURE [DIPROCOM].[SONDA_SP_GET_MINIMUM_ORDER_BY_USER] @USER VARCHAR(50)
AS
BEGIN

    SELECT [SMOU].[USER],
           [SMOU].[MINIMUM_ORDER],
           [U].[SELLER_ROUTE] AS [ROUTE_CODE],
           [SR].[NAME_ROUTE] AS [ROUTE_NAME]
    FROM [DIPROCOM].[SWIFT_MINIMUM_ORDER_BY_USER] [SMOU]
        LEFT JOIN [DIPROCOM].[USERS] [U]
            ON [U].[LOGIN] = [SMOU].[USER]
        LEFT JOIN [DIPROCOM].[SWIFT_ROUTES] [SR]
            ON [U].[SELLER_ROUTE] = [SR].[CODE_ROUTE]
    WHERE [SMOU].[USER] = @USER;
END;