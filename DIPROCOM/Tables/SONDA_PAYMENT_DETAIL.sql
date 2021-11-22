﻿CREATE TABLE [PACASA].[SONDA_PAYMENT_DETAIL] (
    [ID]               NUMERIC (18)  NOT NULL,
    [PAYMENT_NUM]      NUMERIC (18)  NOT NULL,
    [PAYMENT_TYPE]     VARCHAR (20)  NULL,
    [LINE_NUM]         INT           NULL,
    [DOC_DATE]         DATETIME      NULL,
    [DOC_NUM]          INT           NULL,
    [IMAGE]            VARCHAR (MAX) NULL,
    [BANK_ID]          VARCHAR (20)  NULL,
    [ACCOUNT_NUM]      VARCHAR (20)  NULL,
    [INVOICE_NUM]      INT           NULL,
    [INVOICE_SERIE]    VARCHAR (50)  NULL,
    [AMOUNT_PAID]      FLOAT (53)    NULL,
    [DOCUMENT_NUMBER]  VARCHAR (250) NULL,
    [SOURCE_DOC_TYPE]  VARCHAR (50)  NULL,
    [SOURCE_DOC_SERIE] VARCHAR (50)  NULL,
    [SOURCE_DOC_NUM]   INT           NULL,
    [IMAGE_1]          VARCHAR (MAX) NULL,
    [IMAGE_2]          VARCHAR (MAX) NULL,
    CONSTRAINT [PK_SONDA_PAYMENT_DETAIL] PRIMARY KEY CLUSTERED ([ID] ASC, [PAYMENT_NUM] ASC)
);

