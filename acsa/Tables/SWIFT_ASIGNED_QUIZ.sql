﻿CREATE TABLE [acsa].[SWIFT_ASIGNED_QUIZ] (
    [ASIGNED_QUIZ_ID] INT           IDENTITY (1, 1) NOT NULL,
    [QUIZ_ID]         INT           NOT NULL,
    [ROUTE_CODE]      VARCHAR (250) NULL,
    [LAST_UPDATE]     DATETIME      NULL,
    [LAST_UPDATE_BY]  VARCHAR (50)  NULL,
    [CODE_CHANNEL]    VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([ASIGNED_QUIZ_ID] ASC)
);
