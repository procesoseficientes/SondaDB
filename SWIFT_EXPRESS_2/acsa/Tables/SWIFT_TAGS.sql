﻿CREATE TABLE [SONDA].[SWIFT_TAGS] (
    [TAG_COLOR]      VARCHAR (8)   NOT NULL,
    [TAG_VALUE_TEXT] VARCHAR (50)  NOT NULL,
    [TAG_PRIORITY]   INT           NULL,
    [TAG_COMMENTS]   VARCHAR (150) NULL,
    [LAST_UPDATE]    DATETIME      NULL,
    [LAST_UPDATE_BY] VARCHAR (20)  NULL,
    [TYPE]           VARCHAR (20)  NULL,
    [QRY_GROUP]      INT           NULL,
    PRIMARY KEY CLUSTERED ([TAG_COLOR] ASC)
);

