﻿CREATE TABLE [DIPROCOM].[SONDA_DEVOLUTION_INVENTORY_DETAIL] (
    [DEVOLUTION_ID]   INT             NOT NULL,
    [CODE_SKU]        VARCHAR (250)   NOT NULL,
    [QTY_SKU]         INT             NOT NULL,
    [IS_GOOD_STATE]   INT             NULL,
    [POSTED_DATETIME] DATETIME        NULL,
    [POSTED_BY]       VARCHAR (250)   NULL,
    [LAST_UPDATE]     DATETIME        NULL,
    [LAST_UPDATE_BY]  VARCHAR (250)   NULL,
    [TOTAL_AMOUNT]    NUMERIC (18, 6) NULL,
    [SOURCE_DOC_TYPE] VARCHAR (50)    NULL,
    [SOURCE_DOC_NUM]  INT             NULL,
    [HANDLE_SERIAL]   INT             NULL,
    [SERIAL_NUMBER]   VARCHAR (150)   NULL
);

