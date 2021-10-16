﻿CREATE TABLE [DIPROCOM].[SWIFT_TEMP_PICKING_HEADER] (
    [PICKING_HEADER]         INT           IDENTITY (1, 1) NOT NULL,
    [CLASSIFICATION_PICKING] VARCHAR (50)  NULL,
    [CODE_CLIENT]            VARCHAR (50)  NULL,
    [CODE_USER]              VARCHAR (50)  NULL,
    [REFERENCE]              VARCHAR (50)  NULL,
    [DOC_SAP_RECEPTION]      VARCHAR (150) NULL,
    [STATUS]                 VARCHAR (50)  NULL,
    [LAST_UPDATE]            DATETIME      NULL,
    [LAST_UPDATE_BY]         VARCHAR (50)  NULL,
    [OBSERVATIONS]           VARCHAR (50)  NULL,
    [SCHEDULE_FOR]           DATE          NULL,
    [SEQ]                    INT           NULL,
    CONSTRAINT [PK__SWIFT_TE__7D84B13D76619304] PRIMARY KEY CLUSTERED ([PICKING_HEADER] ASC)
);

