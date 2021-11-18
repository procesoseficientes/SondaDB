﻿CREATE TABLE [acsa].[SWIFT_BONUS_LIST_BY_SKU_MULTIPLE] (
    [BONUS_LIST_BY_SKU_MULTIPLE_ID] INT           IDENTITY (1, 1) NOT NULL,
    [BONUS_LIST_ID]                 INT           NOT NULL,
    [CODE_SKU]                      VARCHAR (50)  NOT NULL,
    [CODE_PACK_UNIT]                VARCHAR (25)  NOT NULL,
    [MULTIPLE]                      INT           NOT NULL,
    [CODE_SKU_BONUS]                VARCHAR (50)  NOT NULL,
    [CODE_PACK_UNIT_BONUES]         VARCHAR (25)  NOT NULL,
    [BONUS_QTY]                     INT           NOT NULL,
    [PROMO_ID]                      INT           NULL,
    [PROMO_NAME]                    VARCHAR (250) NULL,
    [PROMO_TYPE]                    VARCHAR (50)  NULL,
    [FREQUENCY]                     VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([BONUS_LIST_BY_SKU_MULTIPLE_ID] ASC),
    CONSTRAINT [FK_SWIFT_BONUS_LIST_BY_SKU_MULTIPLE_SWIFT_BONUS_LIST] FOREIGN KEY ([BONUS_LIST_ID]) REFERENCES [acsa].[SWIFT_BONUS_LIST] ([BONUS_LIST_ID]),
    UNIQUE NONCLUSTERED ([BONUS_LIST_ID] ASC, [CODE_SKU] ASC, [CODE_PACK_UNIT] ASC, [CODE_SKU_BONUS] ASC, [CODE_PACK_UNIT_BONUES] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_BONUS_LIST_BY_SKU_MULTIPLE_BONUS_LIST_ID]
    ON [acsa].[SWIFT_BONUS_LIST_BY_SKU_MULTIPLE]([BONUS_LIST_ID] ASC)
    INCLUDE([CODE_SKU], [CODE_PACK_UNIT], [MULTIPLE], [CODE_SKU_BONUS], [CODE_PACK_UNIT_BONUES], [BONUS_QTY], [PROMO_ID], [PROMO_NAME], [PROMO_TYPE], [FREQUENCY]);

