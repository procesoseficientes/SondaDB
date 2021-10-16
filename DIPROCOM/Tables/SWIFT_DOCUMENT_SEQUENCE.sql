﻿CREATE TABLE [DIPROCOM].[SWIFT_DOCUMENT_SEQUENCE] (
    [ID_DOCUMENT_SECUENCE] INT           IDENTITY (1, 1) NOT NULL,
    [DOC_TYPE]             VARCHAR (50)  CONSTRAINT [DF_SWIFT_DOCUMENT_SEQUENCE_TYPE] DEFAULT ('HANDHELD') NOT NULL,
    [ASSIGNED_DATETIME]    DATETIME      NULL,
    [POST_DATETIME]        DATETIME      NULL,
    [ASSIGNED_BY]          VARCHAR (100) NULL,
    [DOC_FROM]             BIGINT        NULL,
    [DOC_TO]               BIGINT        NULL,
    [SERIE]                VARCHAR (100) NOT NULL,
    [ASSIGNED_TO]          VARCHAR (100) NULL,
    [CURRENT_DOC]          BIGINT        NULL,
    [STATUS]               VARCHAR (15)  NULL,
    [BRANCH_NAME]          VARCHAR (50)  NULL,
    [BRANCH_ADDRESS]       VARCHAR (150) NULL,
    CONSTRAINT [PK_SWIFT_DOCUMENT_SEQUENCE] PRIMARY KEY CLUSTERED ([ID_DOCUMENT_SECUENCE] ASC)
);




GO
CREATE NONCLUSTERED INDEX [IN_SONDA_SALES_ORDER_HEADER_POS_TERMINAL_CLIENT_ID_DOC_SERIE_NUM]
    ON [DIPROCOM].[SWIFT_DOCUMENT_SEQUENCE]([DOC_TYPE] ASC, [SERIE] ASC);

