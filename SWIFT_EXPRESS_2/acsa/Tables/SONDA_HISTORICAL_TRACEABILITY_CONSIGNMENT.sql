﻿CREATE TABLE [SONDA].[SONDA_HISTORICAL_TRACEABILITY_CONSIGNMENT] (
    [HISTORICAL_ID]    INT           IDENTITY (1, 1) NOT NULL,
    [CONSIGNMENT_ID]   INT           NULL,
    [DOC_SERIE]        VARCHAR (50)  NULL,
    [DOC_NUM]          INT           NULL,
    [CODE_SKU]         VARCHAR (250) NULL,
    [QTY_SKU]          INT           NULL,
    [ACTION]           VARCHAR (50)  NULL,
    [DOC_SERIE_TARGET] VARCHAR (50)  NULL,
    [DOC_NUM_TARGET]   INT           NULL,
    [DATE_TRANSACTION] DATETIME      NULL,
    [POSTED_DATETIME]  DATETIME      NULL,
    [POSTED_BY]        VARCHAR (50)  NULL,
    [IS_POSTED]        INT           NULL,
    [SERIAL_NUMBER]    VARCHAR (150) NULL,
    [HANDLE_SERIAL]    INT           DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([HISTORICAL_ID] ASC)
);

