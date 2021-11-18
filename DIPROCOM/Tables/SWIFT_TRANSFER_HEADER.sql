﻿CREATE TABLE [acsa].[SWIFT_TRANSFER_HEADER] (
    [TRANSFER_ID]           NUMERIC (18)  NOT NULL,
    [SELLER_CODE]           VARCHAR (50)  NULL,
    [SELLER_ROUTE]          VARCHAR (50)  NULL,
    [CODE_WAREHOUSE_SOURCE] VARCHAR (50)  NULL,
    [CODE_WAREHOUSE_TARGET] VARCHAR (50)  NULL,
    [STATUS]                VARCHAR (20)  NULL,
    [LAST_UPDATE]           DATETIME      NULL,
    [LAST_UPDATE_BY]        VARCHAR (50)  NULL,
    [COMMENT]               VARCHAR (250) NULL,
    [IS_ONLINE]             INT           DEFAULT ((0)) NULL,
    [CREATION_DATE]         DATETIME      NULL,
    CONSTRAINT [PK_TRANSFER_HEADER_1] PRIMARY KEY CLUSTERED ([TRANSFER_ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_TRANSFER_HEADER_SELLER_ROUTE]
    ON [acsa].[SWIFT_TRANSFER_HEADER]([SELLER_ROUTE] ASC)
    INCLUDE([TRANSFER_ID]);

