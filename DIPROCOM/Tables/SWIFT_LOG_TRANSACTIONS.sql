﻿CREATE TABLE [SONDA].[SWIFT_LOG_TRANSACTIONS] (
    [TXNID]                  INT           IDENTITY (1, 1) NOT NULL,
    [CODE_CUSTOMER]          VARCHAR (50)  NULL,
    [TXN_TYPE]               VARCHAR (50)  NULL,
    [TXN_DESCRIPTION]        VARCHAR (MAX) NULL,
    [TXN_GPS]                VARCHAR (50)  NULL,
    [TXN_CREATED_STAMP]      VARCHAR (50)  NULL,
    [TXN_CREATED_ON_ANDROID] VARCHAR (50)  NULL,
    [TXN_BATTERY_LEVEL]      VARCHAR (50)  NULL,
    [TXN_IMAGE_1]            IMAGE         NULL,
    [TXN_IMAGE_2]            IMAGE         NULL,
    [TXN_IMAGE_3]            IMAGE         NULL,
    [TXN_REASON_NO_TRANS]    VARCHAR (50)  NULL,
    [TXN_CODE_DRIVER]        VARCHAR (50)  NULL,
    [TXN_CODE_INCOME]        VARCHAR (50)  NULL,
    [TXN_CODE_PICKING]       VARCHAR (50)  NULL,
    [LAST_UPDATE]            DATETIME      NULL,
    [LAST_UPDATE_BY]         VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([TXNID] ASC)
);

