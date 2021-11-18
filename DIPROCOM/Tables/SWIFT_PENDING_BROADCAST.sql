﻿CREATE TABLE [acsa].[SWIFT_PENDING_BROADCAST] (
    [ID_BROADCAST]   INT           IDENTITY (1, 1) NOT NULL,
    [CODE_BROADCAST] VARCHAR (150) NOT NULL,
    [SOURCE_TABLE]   VARCHAR (250) NOT NULL,
    [SOURCE_KEY]     VARCHAR (250) NOT NULL,
    [SOURCE_VALUE]   VARCHAR (250) NOT NULL,
    [STATUS]         VARCHAR (50)  NOT NULL,
    [ADDRESS]        VARCHAR (50)  NOT NULL,
    [OPERATION_TYPE] VARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_SWIFT_PENDING_BROADCAST] PRIMARY KEY CLUSTERED ([ID_BROADCAST] ASC)
);

