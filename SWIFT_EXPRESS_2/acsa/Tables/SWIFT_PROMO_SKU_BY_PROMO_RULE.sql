﻿CREATE TABLE [SONDA].[SWIFT_PROMO_SKU_BY_PROMO_RULE] (
    [PROMO_RULE_BY_COMBO_ID] INT          NOT NULL,
    [CODE_SKU]               VARCHAR (50) NOT NULL,
    [PACK_UNIT]              INT          NOT NULL,
    [QTY]                    INT          NOT NULL,
    [IS_MULTIPLE]            INT          DEFAULT ((0)) NOT NULL,
    [LAST_UPDATE]            DATETIME     DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([PROMO_RULE_BY_COMBO_ID] ASC, [CODE_SKU] ASC, [PACK_UNIT] ASC),
    FOREIGN KEY ([PACK_UNIT]) REFERENCES [SONDA].[SONDA_PACK_UNIT] ([PACK_UNIT]),
    FOREIGN KEY ([PROMO_RULE_BY_COMBO_ID]) REFERENCES [SONDA].[SWIFT_PROMO_BY_COMBO_PROMO_RULE] ([PROMO_RULE_BY_COMBO_ID])
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_PROMO_SKU_BY_PROMO_RULE_LAST_UPDATE]
    ON [SONDA].[SWIFT_PROMO_SKU_BY_PROMO_RULE]([LAST_UPDATE] ASC);
