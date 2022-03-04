﻿CREATE TABLE [acsa].[SWIFT_PRICE_LIST_BY_CUSTOMER] (
    [CODE_PRICE_LIST] VARCHAR (50) NOT NULL,
    [CODE_CUSTOMER]   VARCHAR (50) NOT NULL,
    [OWNER]           VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_SWIFT_PRICE_LIST_BY_CUSTOMER] PRIMARY KEY CLUSTERED ([OWNER] ASC, [CODE_PRICE_LIST] ASC, [CODE_CUSTOMER] ASC),
    CONSTRAINT [UC_SWIFT_PRICE_LIST_BY_CUSTOMER_OWNER_CODE_CUSTOMER] UNIQUE NONCLUSTERED ([OWNER] ASC, [CODE_CUSTOMER] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_SWIFT_PRICE_LIST_BY_CUSTOMER_CODE_CUSTOMER]
    ON [acsa].[SWIFT_PRICE_LIST_BY_CUSTOMER]([CODE_CUSTOMER] ASC)
    INCLUDE([CODE_PRICE_LIST], [OWNER]);
