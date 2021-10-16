﻿CREATE TABLE [SONDA].[SWIFT_HIST_INVENTORY] (
    [INVENTORY]       INT           IDENTITY (1, 1) NOT NULL,
    [SERIAL_NUMBER]   VARCHAR (150) NULL,
    [WAREHOUSE]       VARCHAR (50)  NULL,
    [LOCATION]        VARCHAR (50)  NULL,
    [SKU]             VARCHAR (50)  NULL,
    [SKU_DESCRIPTION] VARCHAR (MAX) NULL,
    [ON_HAND]         FLOAT (53)    NULL,
    [BATCH_ID]        VARCHAR (150) NULL,
    [LAST_UPDATE]     DATETIME      NULL,
    [LAST_UPDATE_BY]  VARCHAR (50)  NULL,
    [PROC_DATE]       DATETIME      NULL,
    [INV_DATE]        DATE          NULL,
    [COST]            FLOAT (53)    NULL,
    [TOTAL]           FLOAT (53)    NULL,
    CONSTRAINT [PK_SWIFT_HIST_INVENTORY] PRIMARY KEY CLUSTERED ([INVENTORY] ASC)
);

