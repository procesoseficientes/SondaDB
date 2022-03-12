﻿CREATE TABLE [SONDA].[SWIFT_TRADE_AGREEMENT] (
    [TRADE_AGREEMENT_ID]          INT           IDENTITY (1, 1) NOT NULL,
    [CODE_TRADE_AGREEMENT]        VARCHAR (50)  NOT NULL,
    [NAME_TRADE_AGREEMENT]        VARCHAR (250) NOT NULL,
    [DESCRIPTION_TRADE_AGREEMENT] VARCHAR (250) NULL,
    [VALID_START_DATETIME]        DATETIME      NOT NULL,
    [VALID_END_DATETIME]          DATETIME      NOT NULL,
    [STATUS]                      INT           DEFAULT ((0)) NOT NULL,
    [LAST_UPDATE]                 DATETIME      NOT NULL,
    [LAST_UPDATE_BY]              VARCHAR (50)  NOT NULL,
    [LINKED_TO]                   VARCHAR (250) NULL,
    PRIMARY KEY CLUSTERED ([TRADE_AGREEMENT_ID] ASC),
    UNIQUE NONCLUSTERED ([CODE_TRADE_AGREEMENT] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_TRADE_AGREEMENT_VALID_START_DATETIME_VALID_END_DATETIME]
    ON [SONDA].[SWIFT_TRADE_AGREEMENT]([VALID_START_DATETIME] ASC, [VALID_END_DATETIME] ASC)
    INCLUDE([CODE_TRADE_AGREEMENT], [LINKED_TO], [STATUS], [TRADE_AGREEMENT_ID]);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_TRADE_AGREEMENT_LAST_UPDATE]
    ON [SONDA].[SWIFT_TRADE_AGREEMENT]([LAST_UPDATE] ASC);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_TRADE_AGREEMENT_CODE_TRADE_AGREEMENT]
    ON [SONDA].[SWIFT_TRADE_AGREEMENT]([CODE_TRADE_AGREEMENT] ASC);

