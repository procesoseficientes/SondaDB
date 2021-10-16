﻿CREATE TABLE [SONDA].[SWIFT_SKU_SALE_PACK_UNIT] (
    [CODE_PACK_UNIT] VARCHAR (25) NOT NULL,
    [CODE_SKU]       VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([CODE_PACK_UNIT] ASC, [CODE_SKU] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IDX_SWIFT_SKU_SALE_PACK_UNIT]
    ON [SONDA].[SWIFT_SKU_SALE_PACK_UNIT]([CODE_SKU] ASC)
    INCLUDE([CODE_PACK_UNIT]);

