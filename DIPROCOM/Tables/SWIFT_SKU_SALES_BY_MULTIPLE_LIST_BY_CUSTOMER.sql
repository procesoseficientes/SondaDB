﻿CREATE TABLE [DIPROCOM].[SWIFT_SKU_SALES_BY_MULTIPLE_LIST_BY_CUSTOMER] (
    [SALES_BY_MULTIPLE_LIST_ID] INT          NOT NULL,
    [CODE_CUSTOMER]             VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([SALES_BY_MULTIPLE_LIST_ID] ASC, [CODE_CUSTOMER] ASC),
    FOREIGN KEY ([SALES_BY_MULTIPLE_LIST_ID]) REFERENCES [DIPROCOM].[SWIFT_SKU_SALES_BY_MULTIPLE_LIST] ([SALES_BY_MULTIPLE_LIST_ID])
);


GO
CREATE NONCLUSTERED INDEX [IDX_SWIFT_SKU_SALES_BY_MULTIPLE_LIST_BY_CUSTOMER_T0]
    ON [DIPROCOM].[SWIFT_SKU_SALES_BY_MULTIPLE_LIST_BY_CUSTOMER]([CODE_CUSTOMER] ASC)
    INCLUDE([SALES_BY_MULTIPLE_LIST_ID]);

