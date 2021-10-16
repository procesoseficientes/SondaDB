﻿CREATE TABLE [DIPROCOM].[SWIFT_CUSTOMER_FREQUENCY_NEW_TEMP] (
    [CODE_FREQUENCY]    INT           IDENTITY (1, 1) NOT NULL,
    [CODE_CUSTOMER]     VARCHAR (50)  NOT NULL,
    [SUNDAY]            VARCHAR (10)  CONSTRAINT [DF_SWIFT_CUSTOMER_FREQUENCY_SUNDAY_NEW_TEMP] DEFAULT ((0)) NULL,
    [MONDAY]            VARCHAR (10)  CONSTRAINT [DF_SWIFT_CUSTOMER_FREQUENCY_MONDAY_NEW_TEMP] DEFAULT ((0)) NULL,
    [TUESDAY]           VARCHAR (10)  CONSTRAINT [DF_SWIFT_CUSTOMER_FREQUENCY_TUESDAY_NEW_TEMP] DEFAULT ((0)) NULL,
    [WEDNESDAY]         VARCHAR (10)  CONSTRAINT [DF_SWIFT_CUSTOMER_FREQUENCY_WEDNESDAY_NEW_TEMP] DEFAULT ((0)) NULL,
    [THURSDAY]          VARCHAR (10)  CONSTRAINT [DF_SWIFT_CUSTOMER_FREQUENCY_THURSDAY_NEW_TEMP] DEFAULT ((0)) NULL,
    [FRIDAY]            VARCHAR (10)  CONSTRAINT [DF_SWIFT_CUSTOMER_FREQUENCY_FRIDAY_NEW_TEMP] DEFAULT ((0)) NULL,
    [SATURDAY]          VARCHAR (10)  CONSTRAINT [DF_SWIFT_CUSTOMER_FREQUENCY_SATURDAY_NEW_TEMP] DEFAULT ((0)) NULL,
    [FREQUENCY_WEEKS]   VARCHAR (10)  NULL,
    [LAST_DATE_VISITED] DATE          NULL,
    [LAST_UPDATED]      DATETIME      NULL,
    [LAST_UPDATED_BY]   NVARCHAR (25) NULL,
    CONSTRAINT [PK_SWIFT_CUSTOMER_FREQUENCY_NEW_TEMP] PRIMARY KEY CLUSTERED ([CODE_FREQUENCY] ASC)
);

