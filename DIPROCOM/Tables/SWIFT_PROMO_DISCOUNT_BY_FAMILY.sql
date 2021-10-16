﻿CREATE TABLE [DIPROCOM].[SWIFT_PROMO_DISCOUNT_BY_FAMILY] (
    [PROMO_DISCOUNT_ID] INT             IDENTITY (1, 1) NOT NULL,
    [PROMO_ID]          INT             NOT NULL,
    [CODE_FAMILY_SKU]   VARCHAR (50)    NOT NULL,
    [LOW_AMOUNT]        NUMERIC (18, 6) NOT NULL,
    [HIGH_AMOUNT]       NUMERIC (18, 6) NOT NULL,
    [DISCOUNT]          NUMERIC (18, 6) NOT NULL,
    [DISCOUNT_TYPE]     VARCHAR (50)    NOT NULL,
    [LAST_UPDATE]       DATETIME        NOT NULL,
    CONSTRAINT [PK__SWIFT_PR__86779CDB05CE9C37] PRIMARY KEY CLUSTERED ([PROMO_DISCOUNT_ID] ASC)
);
