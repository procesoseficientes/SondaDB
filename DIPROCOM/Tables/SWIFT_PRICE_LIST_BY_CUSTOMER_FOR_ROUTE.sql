﻿CREATE TABLE [DIPROCOM].[SWIFT_PRICE_LIST_BY_CUSTOMER_FOR_ROUTE] (
    [CODE_ROUTE]      VARCHAR (50) NOT NULL,
    [CODE_PRICE_LIST] VARCHAR (25) NOT NULL,
    [CODE_CUSTOMER]   VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([CODE_ROUTE] ASC, [CODE_PRICE_LIST] ASC, [CODE_CUSTOMER] ASC),
    UNIQUE NONCLUSTERED ([CODE_ROUTE] ASC, [CODE_CUSTOMER] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_SWIFT_PRICE_LIST_BY_CUSTOMER_FOR_ROUTE_T0]
    ON [DIPROCOM].[SWIFT_PRICE_LIST_BY_CUSTOMER_FOR_ROUTE]([CODE_CUSTOMER] ASC)
    INCLUDE([CODE_PRICE_LIST]);

