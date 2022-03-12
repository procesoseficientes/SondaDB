﻿CREATE TABLE [SONDA].[SONDA_PAYMENT_TYPE_DETAIL_FOR_OVERDUE_INVOICE_PAYMENT] (
    [PAYMENT_TYPE_ID]   INT             IDENTITY (1, 1) NOT NULL,
    [PAYMENT_HEADER_ID] INT             NULL,
    [PAYMENT_TYPE]      VARCHAR (100)   NULL,
    [FRONT_IMAGE]       VARCHAR (MAX)   NULL,
    [BACK_IMAGE]        VARCHAR (MAX)   NULL,
    [DOCUMENT_NUMBER]   VARCHAR (250)   NULL,
    [BANK_ACCOUNT]      VARCHAR (100)   NULL,
    [BANK_NAME]         VARCHAR (250)   NULL,
    [AMOUNT]            NUMERIC (18, 6) NULL,
    PRIMARY KEY CLUSTERED ([PAYMENT_TYPE_ID] ASC)
);
