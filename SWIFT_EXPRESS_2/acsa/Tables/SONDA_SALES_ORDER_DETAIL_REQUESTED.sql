﻿CREATE TABLE [SONDA].[SONDA_SALES_ORDER_DETAIL_REQUESTED] (
    [ORDER_DETAIL_ID] INT          IDENTITY (1, 1) NOT NULL,
    [ORDER_ID]        INT          NOT NULL,
    [SALES_ORDER_ID]  INT          NOT NULL,
    [SKU]             VARCHAR (25) NOT NULL,
    [LINE_SEQ]        INT          NOT NULL,
    [QTY]             NUMERIC (18) NULL,
    [PRICE]           MONEY        NULL,
    [DISCOUNT]        MONEY        NULL,
    [TOTAL_LINE]      MONEY        NULL,
    [POSTED_DATETIME] DATETIME     NULL,
    [SERIE]           VARCHAR (50) NULL,
    [SERIE_2]         VARCHAR (50) NULL,
    [REQUERIES_SERIE] INT          NULL,
    [COMBO_REFERENCE] VARCHAR (50) NULL,
    [IS_ACTIVE_ROUTE] INT          NULL,
    [CODE_PACK_UNIT]  VARCHAR (50) NULL,
    [IS_BONUS]        INT          NULL,
    [LONG]            NUMERIC (18) NULL,
    [INTERFACE_OWNER] VARCHAR (50) NULL,
    CONSTRAINT [PK_SONDA_SALES_ORDER_DETAIL_REQUESTED] PRIMARY KEY CLUSTERED ([ORDER_DETAIL_ID] ASC),
    CONSTRAINT [FK_SONDA_SALES_ORDER_DETAIL_REQUESTED] FOREIGN KEY ([ORDER_ID]) REFERENCES [SONDA].[SONDA_SALES_ORDER_HEADER_REQUESTED] ([ORDER_ID])
);

