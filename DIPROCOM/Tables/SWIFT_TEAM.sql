﻿CREATE TABLE [PACASA].[SWIFT_TEAM] (
    [TEAM_ID]        INT           IDENTITY (1, 1) NOT NULL,
    [NAME_TEAM]      VARCHAR (100) NOT NULL,
    [SUPERVISOR]     INT           NOT NULL,
    [CREATE_DATE]    DATETIME      NULL,
    [CREATE_BY]      VARCHAR (50)  NULL,
    [LAST_UPDATE]    DATETIME      NULL,
    [LAST_UPDATE_BY] VARCHAR (50)  NULL,
    CONSTRAINT [PK_SWIFT_TEAM] PRIMARY KEY CLUSTERED ([TEAM_ID] ASC)
);

