﻿CREATE TABLE [DIPROCOM].[SWIFT_CHANNEL] (
    [CHANNEL_ID]          INT           IDENTITY (1, 1) NOT NULL,
    [CODE_CHANNEL]        VARCHAR (50)  NOT NULL,
    [NAME_CHANNEL]        VARCHAR (250) NOT NULL,
    [DESCRIPTION_CHANNEL] VARCHAR (250) NULL,
    [TYPE_CHANNEL]        VARCHAR (50)  NOT NULL,
    [LAST_UPDATE]         DATETIME      NULL,
    [LAST_UPDATE_BY]      VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([CHANNEL_ID] ASC),
    UNIQUE NONCLUSTERED ([CODE_CHANNEL] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_CHANNEL_TYPE_CHANNEL]
    ON [DIPROCOM].[SWIFT_CHANNEL]([TYPE_CHANNEL] ASC)
    INCLUDE([CHANNEL_ID], [CODE_CHANNEL], [NAME_CHANNEL], [DESCRIPTION_CHANNEL]);

