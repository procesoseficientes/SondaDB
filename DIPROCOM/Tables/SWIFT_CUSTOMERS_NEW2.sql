﻿CREATE TABLE [DIPROCOM].[SWIFT_CUSTOMERS_NEW2] (
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
    [POS_SALE_NAME]           VARCHAR (150) NULL,
    [INVOICE_NAME]            VARCHAR (150) NULL,
    [INVOICE_ADDRESS]         VARCHAR (150) NULL,
    [NIT]                     VARCHAR (50)  NULL,
    [CONTACT_ID]              VARCHAR (150) NULL,
    [COMMENTS]                VARCHAR (250) NULL,
    [ATTEMPTED_WITH_ERROR]    INT           NULL,
    [IS_POSTED_ERP]           INT           NULL,
    [POSTED_ERP]              DATETIME      NULL,
    [POSTED_RESPONSE]         VARCHAR (150) NULL,
    [LATITUDE]                VARCHAR (MAX) NULL,
    [LONGITUDE]               VARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([CUSTOMER] ASC)
);

