﻿CREATE TABLE [DIPROCOM].[SWIFT_BONUS_LIST_BY_COMBO] (
    [BONUS_LIST_ID]            INT           NOT NULL,
    [COMBO_ID]                 INT           NOT NULL,
    [BONUS_TYPE]               VARCHAR (50)  NULL,
    [BONUS_SUB_TYPE]           VARCHAR (50)  NULL,
    [IS_BONUS_BY_LOW_PURCHASE] INT           NULL,
    [IS_BONUS_BY_COMBO]        INT           NULL,
    [LOW_QTY]                  INT           NULL,
    [PROMO_ID]                 INT           NULL,
    [PROMO_NAME]               VARCHAR (250) NULL,
    [PROMO_TYPE]               VARCHAR (50)  NULL,
    [FREQUENCY]                VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([BONUS_LIST_ID] ASC, [COMBO_ID] ASC),
    FOREIGN KEY ([BONUS_LIST_ID]) REFERENCES [DIPROCOM].[SWIFT_BONUS_LIST] ([BONUS_LIST_ID]),
    CONSTRAINT [FK_SWIFT_BONUS_LIST_BY_COMBO_SWIFT_COMBO] FOREIGN KEY ([COMBO_ID]) REFERENCES [DIPROCOM].[SWIFT_COMBO] ([COMBO_ID])
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_BONUS_LIST_BY_COMBO_BONUS_LIST_ID]
    ON [DIPROCOM].[SWIFT_BONUS_LIST_BY_COMBO]([BONUS_LIST_ID] ASC)
    INCLUDE([COMBO_ID], [BONUS_TYPE], [BONUS_SUB_TYPE], [IS_BONUS_BY_LOW_PURCHASE], [IS_BONUS_BY_COMBO], [LOW_QTY], [PROMO_ID], [PROMO_NAME], [PROMO_TYPE]);
