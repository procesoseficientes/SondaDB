﻿CREATE TABLE [DIPROCOM].[SONDA_DEVOLUTION_INVENTORY_HEADER] (
    [DEVOLUTION_ID]   INT             IDENTITY (1, 1) NOT NULL,
    [CODE_CUSTOMER]   VARCHAR (250)   NOT NULL,
    [DOC_SERIE]       VARCHAR (250)   NOT NULL,
    [DOC_NUM]         INT             NOT NULL,
    [CODE_ROUTE]      VARCHAR (50)    NULL,
    [GPS_URL]         VARCHAR (250)   NULL,
    [POSTED_DATETIME] DATETIME        NULL,
    [POSTED_BY]       VARCHAR (250)   NULL,
    [LAST_UPDATE]     DATETIME        NULL,
    [LAST_UPDATE_BY]  VARCHAR (250)   NULL,
    [TOTAL_AMOUNT]    NUMERIC (18, 6) NULL,
    [IS_POSTED]       INT             NULL,
    [IMG_1]           VARCHAR (MAX)   NULL,
    [IMG_2]           VARCHAR (MAX)   NULL,
    [IMG_3]           VARCHAR (MAX)   NULL,
    [IS_ACTIVE_ROUTE] INT             DEFAULT ((1)) NOT NULL,
    [LIQUIDATION_ID]  BIGINT          NULL,
    PRIMARY KEY CLUSTERED ([CODE_CUSTOMER] ASC, [DOC_SERIE] ASC, [DOC_NUM] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SONDA_DEVOLUTION_INVENTORY_DEVOLUTION_ID]
    ON [DIPROCOM].[SONDA_DEVOLUTION_INVENTORY_HEADER]([DEVOLUTION_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IN_SONDA_DEVOLUTION_INVENTORY_HEADER_CODE_ROUTE]
    ON [DIPROCOM].[SONDA_DEVOLUTION_INVENTORY_HEADER]([CODE_ROUTE] ASC);

