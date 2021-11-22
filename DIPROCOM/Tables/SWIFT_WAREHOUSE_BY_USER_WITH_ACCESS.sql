﻿CREATE TABLE [PACASA].[SWIFT_WAREHOUSE_BY_USER_WITH_ACCESS] (
    [USER_CORRELATIVE] INT          NOT NULL,
    [CODE_WAREHOUSE]   VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([USER_CORRELATIVE] ASC, [CODE_WAREHOUSE] ASC),
    FOREIGN KEY ([USER_CORRELATIVE]) REFERENCES [PACASA].[USERS] ([CORRELATIVE]),
    CONSTRAINT [FK__SWIFT_WAR__CODE___43C366A3] FOREIGN KEY ([CODE_WAREHOUSE]) REFERENCES [PACASA].[SWIFT_WAREHOUSES] ([CODE_WAREHOUSE])
);

