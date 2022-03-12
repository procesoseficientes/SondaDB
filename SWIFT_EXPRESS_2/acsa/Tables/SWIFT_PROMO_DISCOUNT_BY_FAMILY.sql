﻿CREATE TABLE [SONDA].[SWIFT_PROMO_DISCOUNT_BY_FAMILY] (
    [PROMO_DISCOUNT_ID] INT             IDENTITY (1, 1) NOT NULL,
    [PROMO_ID]          INT             NOT NULL,
    [CODE_FAMILY_SKU]   VARCHAR (50)    NOT NULL,
    [LOW_AMOUNT]        NUMERIC (18, 6) NOT NULL,
    [HIGH_AMOUNT]       NUMERIC (18, 6) NOT NULL,
    [DISCOUNT]          NUMERIC (18, 6) NOT NULL,
    [DISCOUNT_TYPE]     VARCHAR (50)    CONSTRAINT [DF__SWIFT_PRO__DISCO__371E63F3] DEFAULT ('PERCENTAGE') NOT NULL,
    [LAST_UPDATE]       DATETIME        CONSTRAINT [DF__SWIFT_PRO__LAST___3812882C] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK__SWIFT_PR__86779CDB05CE9C37] PRIMARY KEY CLUSTERED ([PROMO_DISCOUNT_ID] ASC),
    CONSTRAINT [FK__SWIFT_PRO__PROMO__3906AC65] FOREIGN KEY ([PROMO_ID]) REFERENCES [SONDA].[SWIFT_PROMO] ([PROMO_ID])
);


GO
CREATE NONCLUSTERED INDEX [IDX_SWIFT_PROMO_DISCOUNT_BY_FAMILY_T0]
    ON [SONDA].[SWIFT_PROMO_DISCOUNT_BY_FAMILY]([CODE_FAMILY_SKU] ASC, [PROMO_ID] ASC)
    INCLUDE([HIGH_AMOUNT], [LOW_AMOUNT], [PROMO_DISCOUNT_ID], [DISCOUNT], [DISCOUNT_TYPE]);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_PROMO_DISCOUNT_BY_FAMILY_LAST_UPDATE]
    ON [SONDA].[SWIFT_PROMO_DISCOUNT_BY_FAMILY]([LAST_UPDATE] ASC);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_PROMO_DISCOUNT_BY_FAMILY_PROMO_ID]
    ON [SONDA].[SWIFT_PROMO_DISCOUNT_BY_FAMILY]([PROMO_ID] ASC)
    INCLUDE([CODE_FAMILY_SKU], [LOW_AMOUNT], [HIGH_AMOUNT], [DISCOUNT], [DISCOUNT_TYPE]);

