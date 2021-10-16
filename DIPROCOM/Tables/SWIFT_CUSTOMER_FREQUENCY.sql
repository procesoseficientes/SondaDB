﻿CREATE TABLE [DIPROCOM].[SWIFT_CUSTOMER_FREQUENCY] (
    [CODE_FREQUENCY]    INT           IDENTITY (1, 1) NOT NULL,
    [CODE_CUSTOMER]     VARCHAR (50)  NOT NULL,
    [SUNDAY]            VARCHAR (10)  CONSTRAINT [DF_SWIFT_CUSTOMER_FREQUENCY_SUNDAY] DEFAULT ((0)) NULL,
    [MONDAY]            VARCHAR (10)  CONSTRAINT [DF_SWIFT_CUSTOMER_FREQUENCY_MONDAY] DEFAULT ((0)) NULL,
    [TUESDAY]           VARCHAR (10)  CONSTRAINT [DF_SWIFT_CUSTOMER_FREQUENCY_TUESDAY] DEFAULT ((0)) NULL,
    [WEDNESDAY]         VARCHAR (10)  CONSTRAINT [DF_SWIFT_CUSTOMER_FREQUENCY_WEDNESDAY] DEFAULT ((0)) NULL,
    [THURSDAY]          VARCHAR (10)  CONSTRAINT [DF_SWIFT_CUSTOMER_FREQUENCY_THURSDAY] DEFAULT ((0)) NULL,
    [FRIDAY]            VARCHAR (10)  CONSTRAINT [DF_SWIFT_CUSTOMER_FREQUENCY_FRIDAY] DEFAULT ((0)) NULL,
    [SATURDAY]          VARCHAR (10)  CONSTRAINT [DF_SWIFT_CUSTOMER_FREQUENCY_SATURDAY] DEFAULT ((0)) NULL,
    [FREQUENCY_WEEKS]   VARCHAR (10)  NULL,
    [LAST_DATE_VISITED] DATE          NULL,
    [LAST_UPDATED]      DATETIME      NULL,
    [LAST_UPDATED_BY]   NVARCHAR (25) NULL,
    [DISTANCE]          FLOAT (53)    NULL,
    [LAST_OPTIMIZATION] DATETIME      NULL,
    CONSTRAINT [PK_SWIFT_CUSTOMER_FREQUENCY] PRIMARY KEY CLUSTERED ([CODE_FREQUENCY] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_CUSTOMER_FREQUENCY_CODE_CUSTOMER]
    ON [DIPROCOM].[SWIFT_CUSTOMER_FREQUENCY]([CODE_CUSTOMER] ASC)
    INCLUDE([SUNDAY], [MONDAY], [TUESDAY], [WEDNESDAY], [THURSDAY], [FRIDAY], [SATURDAY], [FREQUENCY_WEEKS], [LAST_DATE_VISITED], [LAST_OPTIMIZATION], [DISTANCE]);

