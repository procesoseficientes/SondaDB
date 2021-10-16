﻿CREATE TABLE [DIPROCOM].[SONDA_OVERDUE_INVOICE_PAYMENT_HEADER] (
    [ID]                   INT             IDENTITY (1, 1) NOT NULL,
    [CODE_CUSTOMER]        VARCHAR (250)   NOT NULL,
    [DOC_SERIE]            VARCHAR (250)   NOT NULL,
    [DOC_NUM]              INT             NOT NULL,
    [CREATED_DATE]         DATETIME        NOT NULL,
    [POSTED_DATE]          DATETIME        DEFAULT (getdate()) NOT NULL,
    [CODE_ROUTE]           VARCHAR (250)   NOT NULL,
    [LOGIN_ID]             VARCHAR (250)   NOT NULL,
    [PAYMENT_AMOUNT]       NUMERIC (18, 6) NOT NULL,
    [COMMENT]              VARCHAR (250)   NULL,
    [IS_POSTED_ERP]        INT             DEFAULT ((0)) NOT NULL,
    [POSTED_DATETIME_ERP]  DATETIME        NULL,
    [POSTING_RESPONSE]     VARCHAR (250)   NULL,
    [ATTEMPTED_WITH_ERROR] INT             DEFAULT ((0)) NOT NULL,
    [ERP_REFERENCE]        VARCHAR (250)   NULL,
    PRIMARY KEY CLUSTERED ([CODE_CUSTOMER] ASC, [DOC_SERIE] ASC, [DOC_NUM] ASC, [CODE_ROUTE] ASC)
);

