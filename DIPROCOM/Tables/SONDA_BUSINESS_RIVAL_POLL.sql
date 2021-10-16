﻿CREATE TABLE [DIPROCOM].[SONDA_BUSINESS_RIVAL_POLL] (
    [BUSINESS_RIVAL_POLL]          INT             IDENTITY (1, 1) NOT NULL,
    [INVOICE_RESOLUTION]           VARCHAR (50)    NULL,
    [INVOICE_SERIE]                VARCHAR (50)    NOT NULL,
    [INVOICE_NUM]                  INT             NOT NULL,
    [CODE_CUSTOMER]                VARCHAR (50)    NOT NULL,
    [BUSSINESS_RIVAL_NAME]         VARCHAR (50)    NOT NULL,
    [BUSSINESS_RIVAL_TOTAL_AMOUNT] NUMERIC (18, 6) NOT NULL,
    [CUSTOMER_TOTAL_AMOUNT]        NUMERIC (18, 6) NOT NULL,
    [COMMENT]                      VARCHAR (50)    NOT NULL,
    [ROUTE]                        INT             NOT NULL,
    [POSTED_DATETIME]              DATETIME        NOT NULL,
    PRIMARY KEY CLUSTERED ([BUSINESS_RIVAL_POLL] ASC),
    FOREIGN KEY ([ROUTE]) REFERENCES [DIPROCOM].[SWIFT_ROUTES] ([ROUTE])
);

