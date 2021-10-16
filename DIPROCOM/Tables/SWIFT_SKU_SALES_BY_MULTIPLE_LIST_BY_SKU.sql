﻿CREATE TABLE [SONDA].[SWIFT_SKU_SALES_BY_MULTIPLE_LIST_BY_SKU] (
    [SALES_BY_MULTIPLE_LIST_ID] INT           NOT NULL,
    [CODE_SKU]                  VARCHAR (50)  NOT NULL,
    [CODE_PACK_UNIT]            VARCHAR (50)  NOT NULL,
    [MULTIPLE]                  INT           NOT NULL,
    [PROMO_ID]                  INT           NULL,
    [PROMO_NAME]                VARCHAR (250) NULL,
    [PROMO_TYPE]                VARCHAR (50)  NULL,
    [FREQUENCY]                 VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([SALES_BY_MULTIPLE_LIST_ID] ASC, [CODE_SKU] ASC, [CODE_PACK_UNIT] ASC),
    FOREIGN KEY ([SALES_BY_MULTIPLE_LIST_ID]) REFERENCES [SONDA].[SWIFT_SKU_SALES_BY_MULTIPLE_LIST] ([SALES_BY_MULTIPLE_LIST_ID])
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_SKU_SALES_BY_MULTIPLE_LIST_BY_SKU_SALES_BY_MULTIPLE_LIST_ID]
    ON [SONDA].[SWIFT_SKU_SALES_BY_MULTIPLE_LIST_BY_SKU]([SALES_BY_MULTIPLE_LIST_ID] ASC)
    INCLUDE([CODE_SKU], [CODE_PACK_UNIT], [MULTIPLE], [PROMO_ID], [PROMO_NAME], [PROMO_TYPE]);

