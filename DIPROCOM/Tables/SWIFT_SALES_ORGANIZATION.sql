﻿CREATE TABLE [DIPROCOM].[SWIFT_SALES_ORGANIZATION] (
    [SALES_ORGANIZATION_ID]          INT          IDENTITY (1, 1) NOT NULL,
    [NAME_SALES_ORGANIZATION]        VARCHAR (50) NOT NULL,
    [DESCRIPTION_SALES_ORGANIZATION] VARCHAR (50) NOT NULL,
    [SOURCE]                         VARCHAR (50) DEFAULT ('BO') NULL,
    PRIMARY KEY CLUSTERED ([SALES_ORGANIZATION_ID] ASC),
    UNIQUE NONCLUSTERED ([NAME_SALES_ORGANIZATION] ASC)
);

