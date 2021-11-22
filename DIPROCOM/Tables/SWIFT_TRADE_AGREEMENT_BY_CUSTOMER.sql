﻿CREATE TABLE [PACASA].[SWIFT_TRADE_AGREEMENT_BY_CUSTOMER] (
    [TRADE_AGREEMENT_ID] INT          NOT NULL,
    [CODE_CUSTOMER]      VARCHAR (50) NOT NULL,
    [LAST_UPDATE]        DATETIME     DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SWIFT_TRADE_AGREEMENT_BY_CUSTOMER] PRIMARY KEY CLUSTERED ([CODE_CUSTOMER] ASC),
    CONSTRAINT [FK_TRADE_AGREEMENT_BY_CUSTOMER] FOREIGN KEY ([TRADE_AGREEMENT_ID]) REFERENCES [PACASA].[SWIFT_TRADE_AGREEMENT] ([TRADE_AGREEMENT_ID])
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_TRADE_AGREEMENT_BY_CUSTOMER_CODE_CUSTOMER_TRADE_AGREEMENT_ID]
    ON [PACASA].[SWIFT_TRADE_AGREEMENT_BY_CUSTOMER]([TRADE_AGREEMENT_ID] ASC, [CODE_CUSTOMER] ASC);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_TRADE_AGREEMENT_BY_CUSTOMER_LAST_UPDATE]
    ON [PACASA].[SWIFT_TRADE_AGREEMENT_BY_CUSTOMER]([LAST_UPDATE] ASC);

