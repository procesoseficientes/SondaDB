﻿CREATE TABLE [DIPROCOM].[SWIFT_CUSTOMERS_NEW_TEMP] (
    [CUSTOMER]                INT           IDENTITY (1, 1) NOT NULL,
    [CODE_CUSTOMER]           VARCHAR (50)  NULL,
    [NAME_CUSTOMER]           VARCHAR (50)  NULL,
    [PHONE_CUSTOMER]          VARCHAR (50)  NULL,
    [ADRESS_CUSTOMER]         VARCHAR (MAX) NULL,
    [CLASSIFICATION_CUSTOMER] VARCHAR (50)  NULL,
    [CONTACT_CUSTOMER]        VARCHAR (50)  NULL,
    [CODE_ROUTE]              VARCHAR (50)  NULL,
    [LAST_UPDATE]             DATETIME      NULL,
    [LAST_UPDATE_BY]          VARCHAR (50)  NULL,
    [SELLER_DEFAULT_CODE]     VARCHAR (50)  NULL,
    [CREDIT_LIMIT]            FLOAT (53)    NULL,
    [SIGN]                    VARCHAR (MAX) NULL,
    [PHOTO]                   VARCHAR (MAX) NULL,
    [STATUS]                  VARCHAR (20)  NULL,
    [NEW]                     INT           NULL,
    [GPS]                     VARCHAR (MAX) NULL,
    [CODE_CUSTOMER_HH]        VARCHAR (50)  NULL,
    [REFERENCE]               VARCHAR (150) NULL,
    [POST_DATETIME]           DATETIME      NULL,
    [POS_SALE_NAME]           VARCHAR (150) CONSTRAINT [DF_SWIFT_CUSTOMERS_NEW_TEMP_POS_SALE_NAME] DEFAULT ('...') NULL,
    [INVOICE_NAME]            VARCHAR (150) CONSTRAINT [DF_SWIFT_CUSTOMERS_NEW_TEMP_INVOICE_NAME] DEFAULT ('...') NULL,
    [INVOICE_ADDRESS]         VARCHAR (150) CONSTRAINT [DF_SWIFT_CUSTOMERS_NEW_TEMP_INVOICE_ADDRESS] DEFAULT ('...') NULL,
    [NIT]                     VARCHAR (50)  CONSTRAINT [DF_SWIFT_CUSTOMERS_NEW_TEMP_NIT] DEFAULT ('...') NULL,
    [CONTACT_ID]              VARCHAR (150) CONSTRAINT [DF_SWIFT_CUSTOMERS_NEW_TEMP_CONTACT_ID] DEFAULT ('...') NULL,
    [COMMENTS]                VARCHAR (250) CONSTRAINT [DF_SWIFT_CUSTOMERS_NEW_TEMP_COMMENTS] DEFAULT ('') NULL,
    [ATTEMPTED_WITH_ERROR]    INT           CONSTRAINT [DF_SWIFT_CUSTOMERS_NEW_TEMP_ATTEMPTED_WITH_ERROR] DEFAULT ((0)) NULL,
    [IS_POSTED_ERP]           INT           CONSTRAINT [DF_SWIFT_CUSTOMERS_NEW_TEMP_IS_POSTED_ERP] DEFAULT ((-1)) NULL,
    [POSTED_ERP]              DATETIME      NULL,
    [POSTED_RESPONSE]         VARCHAR (150) NULL,
    [LATITUDE]                VARCHAR (MAX) CONSTRAINT [DF_SWIFT_CUSTOMERS_NEW_TEMP_LATITUDE] DEFAULT ((0)) NULL,
    [LONGITUDE]               VARCHAR (MAX) CONSTRAINT [DF_SWIFT_CUSTOMERS_NEW_TEMP_LONGITUDE] DEFAULT ((0)) NULL,
    [DEPARTAMENT]             VARCHAR (250) DEFAULT ('NO ESPECIFICADO') NULL,
    [MUNICIPALITY]            VARCHAR (250) DEFAULT ('NO ESPECIFICADO') NULL,
    [COLONY]                  VARCHAR (250) DEFAULT ('NO ESPECIFICADO') NULL,
    [UPDATED_FROM_BO]         INT           NULL,
    [SYNC_ID]                 VARCHAR (250) NULL,
    [IS_POSTED]               INT           NULL,
    PRIMARY KEY CLUSTERED ([CUSTOMER] ASC)
);
