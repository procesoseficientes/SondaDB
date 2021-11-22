﻿CREATE TABLE [PACASA].[SWIFT_CUSTOMER_ACCOUNTING_INFORMATION] (
    [ID]                  INT             IDENTITY (1, 1) NOT NULL,
    [CODE_CUSTOMER]       VARCHAR (250)   NOT NULL,
    [GROUP_NUM]           INT             NOT NULL,
    [CREDIT_LIMIT]        NUMERIC (18, 6) NULL,
    [OUTSTANDING_BALANCE] NUMERIC (18, 6) NULL,
    [EXTRA_DAYS]          INT             NULL,
    PRIMARY KEY CLUSTERED ([ID] ASC, [CODE_CUSTOMER] ASC, [GROUP_NUM] ASC)
);

