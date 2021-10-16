﻿CREATE TABLE [DIPROCOM].[SONDA_SALES_ORDER_HEADER_REQUESTED] (
    [ORDER_ID]                   INT           IDENTITY (1, 1) NOT NULL,
    [SALES_ORDER_ID]             INT           NOT NULL,
    [TERMS]                      VARCHAR (15)  NULL,
    [POSTED_DATETIME]            DATETIME      NULL,
    [CLIENT_ID]                  VARCHAR (50)  NULL,
    [POS_TERMINAL]               VARCHAR (25)  NULL,
    [GPS_URL]                    VARCHAR (150) NULL,
    [TOTAL_AMOUNT]               MONEY         NULL,
    [STATUS]                     INT           NULL,
    [POSTED_BY]                  VARCHAR (25)  NULL,
    [IMAGE_1]                    VARCHAR (MAX) NULL,
    [IMAGE_2]                    VARCHAR (MAX) NULL,
    [IMAGE_3]                    VARCHAR (MAX) NULL,
    [DEVICE_BATTERY_FACTOR]      INT           NULL,
    [VOID_DATETIME]              DATETIME      NULL,
    [VOID_REASON]                VARCHAR (25)  NULL,
    [VOID_NOTES]                 VARCHAR (MAX) NULL,
    [VOIDED]                     INT           NULL,
    [CLOSED_ROUTE_DATETIME]      DATETIME      NULL,
    [IS_ACTIVE_ROUTE]            INT           NULL,
    [GPS_EXPECTED]               VARCHAR (MAX) NULL,
    [DELIVERY_DATE]              DATETIME      NULL,
    [SALES_ORDER_ID_HH]          INT           NULL,
    [IS_PARENT]                  INT           NULL,
    [REFERENCE_ID]               VARCHAR (150) NULL,
    [WAREHOUSE]                  VARCHAR (50)  NULL,
    [TIMES_PRINTED]              INT           NULL,
    [DOC_SERIE]                  VARCHAR (100) NULL,
    [DOC_NUM]                    INT           NULL,
    [IS_VOID]                    INT           NULL,
    [SALES_ORDER_TYPE]           VARCHAR (250) NULL,
    [DISCOUNT]                   NUMERIC (18)  NULL,
    [IS_DRAFT]                   INT           NULL,
    [ASSIGNED_BY]                VARCHAR (50)  NULL,
    [TASK_ID]                    INT           NULL,
    [COMMENT]                    VARCHAR (250) NULL,
    [PAYMENT_TIMES_PRINTED]      INT           NULL,
    [PAID_TO_DATE]               NUMERIC (18)  NULL,
    [TO_BILL]                    INT           NULL,
    [HAVE_PICKING]               INT           NULL,
    [DISCOUNT_BY_GENERAL_AMOUNT] NUMERIC (18)  NULL,
    [SERVER_POSTED_DATETIME]     DATETIME      NULL,
    [DEVICE_NETWORK_TYPE]        VARCHAR (15)  NULL,
    [IS_POSTED]                  INT           NULL,
    [IS_POSTED_OFFLINE]          INT           NULL,
    CONSTRAINT [PK_SONDA_SALES_ORDER_HEADER_REQUESTED] PRIMARY KEY CLUSTERED ([ORDER_ID] ASC)
);

