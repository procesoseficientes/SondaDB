﻿CREATE TABLE [PACASA].[SWIFT_TXN_X_DOC_ERP] (
    [DOC_ENTRY] NUMERIC (18) NOT NULL,
    [ERP_DOC]   NUMERIC (18) NOT NULL,
    [CODE_SKU]  VARCHAR (50) NOT NULL,
    [QTY]       NUMERIC (18) NOT NULL,
    [LINE_NUM]  INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([DOC_ENTRY] ASC, [ERP_DOC] ASC, [CODE_SKU] ASC, [LINE_NUM] ASC)
);

