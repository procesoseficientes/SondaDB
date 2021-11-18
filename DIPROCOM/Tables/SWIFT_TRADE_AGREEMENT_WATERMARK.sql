﻿CREATE TABLE [acsa].[SWIFT_TRADE_AGREEMENT_WATERMARK] (
    [WATER_MARK_ID] INT           IDENTITY (1, 1) NOT NULL,
    [WATER_MARK]    DATETIME      NULL,
    [CODE_ROUTE]    VARCHAR (25)  NOT NULL,
    [TIMES_REQUIRE] INT           NULL,
    [LAST_REQUIRE]  DATETIME      NULL,
    [MARKED_TABLE]  VARCHAR (250) NULL,
    PRIMARY KEY CLUSTERED ([WATER_MARK_ID] ASC, [CODE_ROUTE] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_TRADE_AGREEMENT_WATERMARK_CODE_ROUTE]
    ON [acsa].[SWIFT_TRADE_AGREEMENT_WATERMARK]([CODE_ROUTE] ASC)
    INCLUDE([WATER_MARK], [TIMES_REQUIRE], [LAST_REQUIRE], [MARKED_TABLE]);

