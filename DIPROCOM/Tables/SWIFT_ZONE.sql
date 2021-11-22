﻿CREATE TABLE [PACASA].[SWIFT_ZONE] (
    [ZONE_ID]          INT           IDENTITY (1, 1) NOT NULL,
    [CODE_ZONE]        VARCHAR (50)  NULL,
    [DESCRIPTION_ZONE] VARCHAR (200) NULL,
    [LAST_UPDATED_BY]  VARCHAR (50)  NULL,
    [LAST_UPDATE]      DATETIME      NULL,
    PRIMARY KEY CLUSTERED ([ZONE_ID] ASC),
    CONSTRAINT [U_SWIFT_ZONE_CODE_ZONE] UNIQUE NONCLUSTERED ([CODE_ZONE] ASC)
);

