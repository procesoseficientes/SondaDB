﻿CREATE TABLE [SONDA].[SWIFT_RECEPTION_HEADER] (
    [RECEPTION_HEADER]     INT           IDENTITY (1, 1) NOT NULL,
    [TYPE_RECEPTION]       VARCHAR (50)  NULL,
    [CODE_PROVIDER]        VARCHAR (50)  NULL,
    [CODE_USER]            VARCHAR (50)  NULL,
    [REFERENCE]            VARCHAR (50)  NULL,
    [DOC_SAP_RECEPTION]    VARCHAR (150) NULL,
    [STATUS]               VARCHAR (20)  NULL,
    [COMMENTS]             VARCHAR (MAX) NULL,
    [LAST_UPDATE]          DATETIME      NULL,
    [LAST_UPDATE_BY]       VARCHAR (50)  NULL,
    [SCHEDULE_FOR]         DATE          NULL,
    [SEQ]                  INT           NULL,
    [ATTEMPTED_WITH_ERROR] INT           NULL,
    [IS_POSTED_ERP]        INT           NULL,
    [POSTED_ERP]           DATETIME      NULL,
    [POSTED_RESPONSE]      VARCHAR (150) NULL,
    [SOURCE_DOC_TYPE]      VARCHAR (15)  NULL,
    [SOURCE_DOC]           INT           NULL,
    [TARGET_DOC]           INT           NULL,
    [ERP_REFERENCE]        VARCHAR (256) NULL,
    CONSTRAINT [PK__SWIFT_IN__2ED569982F10007B] PRIMARY KEY CLUSTERED ([RECEPTION_HEADER] ASC)
);

