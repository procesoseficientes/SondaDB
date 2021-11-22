﻿CREATE TABLE [PACASA].[SWIFT_TRADE_AGREEMENT_BONUS] (
    [TRADE_AGREEMENT_BONUS_ID] INT          IDENTITY (1, 1) NOT NULL,
    [TRADE_AGREEMENT_ID]       INT          NOT NULL,
    [CODE_SKU]                 VARCHAR (50) NOT NULL,
    [PACK_UNIT]                INT          NULL,
    [LOW_LIMIT]                NUMERIC (18) NOT NULL,
    [HIGH_LIMIT]               NUMERIC (18) NOT NULL,
    [CODE_SKU_BONUS]           VARCHAR (50) NOT NULL,
    [PACK_UNIT_BONUS]          INT          NULL,
    [BONUS_QTY]                NUMERIC (18) NOT NULL,
    PRIMARY KEY CLUSTERED ([TRADE_AGREEMENT_BONUS_ID] ASC),
    CONSTRAINT [FK__SWIFT_TRA__PACK___66EBDBF8] FOREIGN KEY ([PACK_UNIT]) REFERENCES [PACASA].[SONDA_PACK_UNIT] ([PACK_UNIT]),
    CONSTRAINT [FK__SWIFT_TRA__PACK___67E00031] FOREIGN KEY ([PACK_UNIT_BONUS]) REFERENCES [PACASA].[SONDA_PACK_UNIT] ([PACK_UNIT]),
    CONSTRAINT [FK__SWIFT_TRA__TRADE__65F7B7BF] FOREIGN KEY ([TRADE_AGREEMENT_ID]) REFERENCES [PACASA].[SWIFT_TRADE_AGREEMENT] ([TRADE_AGREEMENT_ID]),
    CONSTRAINT [UC_SWIFT_TRADE_AGREEMENT_BONUS] UNIQUE NONCLUSTERED ([TRADE_AGREEMENT_ID] ASC, [CODE_SKU] ASC, [PACK_UNIT] ASC, [LOW_LIMIT] ASC, [CODE_SKU_BONUS] ASC, [PACK_UNIT_BONUS] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_TRADE_AGREEMENT_BONUS_TRADE_AGREEMENT_ID]
    ON [PACASA].[SWIFT_TRADE_AGREEMENT_BONUS]([TRADE_AGREEMENT_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_TRADE_AGREEMENT_BONUS_TRADE_AGREEMENT_ID_CODE_SKU]
    ON [PACASA].[SWIFT_TRADE_AGREEMENT_BONUS]([TRADE_AGREEMENT_ID] ASC, [CODE_SKU] ASC);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_TRADE_AGREEMENT_BONUS_TRADE_AGREEMENT_ID_CODE_SKU_PACK_UNIT]
    ON [PACASA].[SWIFT_TRADE_AGREEMENT_BONUS]([TRADE_AGREEMENT_ID] ASC, [CODE_SKU] ASC, [PACK_UNIT] ASC);

