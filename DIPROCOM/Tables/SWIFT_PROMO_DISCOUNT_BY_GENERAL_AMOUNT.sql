﻿CREATE TABLE [acsa].[SWIFT_PROMO_DISCOUNT_BY_GENERAL_AMOUNT] (
    [PROMO_ID]                      INT             NOT NULL,
    [LOW_AMOUNT]                    NUMERIC (18, 6) NOT NULL,
    [HIGH_AMOUNT]                   NUMERIC (18, 6) NOT NULL,
    [DISCOUNT]                      NUMERIC (18, 6) NOT NULL,
    [DISCOUNT_BY_GENERAL_AMOUNT_ID] INT             IDENTITY (1, 1) NOT NULL,
    [LAST_UPDATE]                   DATETIME        DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([PROMO_ID] ASC, [LOW_AMOUNT] ASC, [HIGH_AMOUNT] ASC),
    FOREIGN KEY ([PROMO_ID]) REFERENCES [acsa].[SWIFT_PROMO] ([PROMO_ID])
);


GO
CREATE NONCLUSTERED INDEX [ID_SWIFT_PROMO_DISCOUNT_BY_GENERAL_AMOUNT_LAST_UPDATE]
    ON [acsa].[SWIFT_PROMO_DISCOUNT_BY_GENERAL_AMOUNT]([LAST_UPDATE] ASC);


GO
CREATE NONCLUSTERED INDEX [IDX_SWIFT_PROMO_DISCOUNT_BY_GENERAL_AMOUNT_DISCOUNT_BY_GENERAL_AMOUNT_ID]
    ON [acsa].[SWIFT_PROMO_DISCOUNT_BY_GENERAL_AMOUNT]([DISCOUNT_BY_GENERAL_AMOUNT_ID] ASC)
    INCLUDE([PROMO_ID], [LOW_AMOUNT], [HIGH_AMOUNT], [DISCOUNT]);

