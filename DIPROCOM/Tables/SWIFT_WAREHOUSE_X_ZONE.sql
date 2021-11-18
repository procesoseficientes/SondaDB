﻿CREATE TABLE [acsa].[SWIFT_WAREHOUSE_X_ZONE] (
    [WAREHOUSE_X_ZONE_ID] INT          IDENTITY (1, 1) NOT NULL,
    [ID_ZONE]             INT          NULL,
    [CODE_WAREHOUSE]      VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([WAREHOUSE_X_ZONE_ID] ASC),
    CONSTRAINT [FK_WAREHOUSE_X_ZONE_WAREHOUSE_ID] FOREIGN KEY ([CODE_WAREHOUSE]) REFERENCES [acsa].[SWIFT_WAREHOUSES] ([CODE_WAREHOUSE]),
    CONSTRAINT [FK_WAREHOUSE_X_ZONE_ZONE_ID] FOREIGN KEY ([ID_ZONE]) REFERENCES [acsa].[SWIFT_ZONE] ([ZONE_ID]),
    CONSTRAINT [UN_WAREHOUSE_X_ZONE] UNIQUE NONCLUSTERED ([ID_ZONE] ASC, [CODE_WAREHOUSE] ASC)
);

