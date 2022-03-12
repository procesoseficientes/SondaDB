﻿CREATE TABLE [SONDA].[SWIFT_DISCOUNT_LIST] (
    [DISCOUNT_LIST_ID]   INT           IDENTITY (1, 1) NOT NULL,
    [NAME_DISCOUNT_LIST] VARCHAR (250) NULL,
    [CODE_ROUTE]         VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([DISCOUNT_LIST_ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_DISCOUNT_LIST_CODE_ROUTE_NAME_DISCOUNT_LIST]
    ON [SONDA].[SWIFT_DISCOUNT_LIST]([CODE_ROUTE] ASC, [NAME_DISCOUNT_LIST] ASC)
    INCLUDE([DISCOUNT_LIST_ID]);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_DISCOUNT_LIST_CODE_ROUTE]
    ON [SONDA].[SWIFT_DISCOUNT_LIST]([CODE_ROUTE] ASC)
    INCLUDE([DISCOUNT_LIST_ID]);

