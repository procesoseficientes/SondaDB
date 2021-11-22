﻿CREATE TABLE [PACASA].[SWIFT_PROMO_DISCOUNT_BY_PAYMENT_TYPE_AND_FAMILY] (
    [PROMO_DISCOUNT_ID] INT             IDENTITY (1, 1) NOT NULL,
    [PROMO_ID]          INT             NOT NULL,
    [CODE_FAMILY_SKU]   VARCHAR (50)    NOT NULL,
    [PAYMENT_TYPE]      VARCHAR (50)    NOT NULL,
    [DISCOUNT_TYPE]     VARCHAR (50)    NOT NULL,
    [DISCOUNT]          NUMERIC (18, 6) NOT NULL,
    [LAST_UPDATE]       DATETIME        NOT NULL,
    PRIMARY KEY CLUSTERED ([PROMO_DISCOUNT_ID] ASC)
);

