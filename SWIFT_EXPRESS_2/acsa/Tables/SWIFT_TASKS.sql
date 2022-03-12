﻿CREATE TABLE [SONDA].[SWIFT_TASKS] (
    [TASK_ID]                INT           IDENTITY (1, 1) NOT NULL,
    [TASK_TYPE]              VARCHAR (15)  NULL,
    [TASK_DATE]              DATE          NULL,
    [SCHEDULE_FOR]           DATE          NULL,
    [CREATED_STAMP]          DATETIME      NULL,
    [ASSIGEND_TO]            VARCHAR (25)  NULL,
    [ASSIGNED_BY]            VARCHAR (25)  NULL,
    [ASSIGNED_STAMP]         DATETIME      NULL,
    [CANCELED_STAMP]         DATETIME      NULL,
    [CANCELED_BY]            VARCHAR (25)  NULL,
    [ACCEPTED_STAMP]         DATETIME      NULL,
    [COMPLETED_STAMP]        DATETIME      NULL,
    [RELATED_PROVIDER_CODE]  VARCHAR (25)  NULL,
    [RELATED_PROVIDER_NAME]  VARCHAR (250) NULL,
    [EXPECTED_GPS]           VARCHAR (100) NULL,
    [POSTED_GPS]             VARCHAR (100) NULL,
    [TASK_STATUS]            VARCHAR (10)  NULL,
    [TASK_COMMENTS]          VARCHAR (150) NULL,
    [TASK_SEQ]               INT           NULL,
    [REFERENCE]              VARCHAR (150) NULL,
    [SAP_REFERENCE]          VARCHAR (150) NULL,
    [COSTUMER_CODE]          VARCHAR (25)  NULL,
    [COSTUMER_NAME]          VARCHAR (250) NULL,
    [RECEPTION_NUMBER]       INT           NULL,
    [PICKING_NUMBER]         INT           NULL,
    [COUNT_ID]               VARCHAR (50)  NULL,
    [ACTION]                 VARCHAR (50)  NULL,
    [SCANNING_STATUS]        VARCHAR (50)  NULL,
    [ALLOW_STORAGE_ON_DIFF]  INT           CONSTRAINT [DF_SWIFT_TASKS_ALLOW_STORAGE_ON_DIFF] DEFAULT ((1)) NULL,
    [CUSTOMER_PHONE]         VARCHAR (50)  NULL,
    [TASK_ADDRESS]           VARCHAR (250) NULL,
    [VISIT_HOUR]             DATETIME      NULL,
    [ROUTE_IS_COMPLETED]     INT           NULL,
    [EMAIL_TO_CONFIRM]       VARCHAR (150) NULL,
    [DISTANCE_IN_KMS]        FLOAT (53)    NULL,
    [DOC_RESOLUTION]         VARCHAR (50)  NULL,
    [DOC_SERIE]              VARCHAR (100) NULL,
    [DOC_NUM]                INT           NULL,
    [COMPLETED_SUCCESSFULLY] NUMERIC (18)  NULL,
    [REASON]                 VARCHAR (250) NULL,
    [TASK_ID_HH]             INT           NULL,
    [IN_PLAN_ROUTE]          INT           NULL,
    [CREATE_BY]              VARCHAR (250) NULL,
    [DEVICE_NETWORK_TYPE]    VARCHAR (15)  NULL,
    [IS_POSTED_OFFLINE]      INT           DEFAULT ((0)) NOT NULL,
    [CODE_ROUTE]             VARCHAR (50)  NULL,
    CONSTRAINT [PK_SONDA_TASKS] PRIMARY KEY CLUSTERED ([TASK_ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_TASKS_TASK_TYPE_ASSIGNED_TO]
    ON [SONDA].[SWIFT_TASKS]([TASK_TYPE] ASC, [ASSIGEND_TO] ASC)
    INCLUDE([COSTUMER_CODE], [TASK_DATE], [TASK_ID], [TASK_STATUS]);


GO
CREATE NONCLUSTERED INDEX [IX_SWIFT_TASKS_CODE_ROUTE]
    ON [SONDA].[SWIFT_TASKS]([CODE_ROUTE] ASC)
    INCLUDE([TASK_ID], [TASK_DATE], [ASSIGNED_BY], [COMPLETED_STAMP], [POSTED_GPS], [TASK_STATUS], [COSTUMER_CODE], [COSTUMER_NAME], [COMPLETED_SUCCESSFULLY], [REASON]);


GO
CREATE NONCLUSTERED INDEX [IDX_TASKS]
    ON [SONDA].[SWIFT_TASKS]([TASK_TYPE] ASC, [SCHEDULE_FOR] ASC, [ASSIGEND_TO] ASC, [TASK_STATUS] ASC)
    INCLUDE([TASK_ID], [TASK_DATE], [CREATED_STAMP], [ASSIGNED_BY], [ACCEPTED_STAMP], [COMPLETED_STAMP], [EXPECTED_GPS], [POSTED_GPS], [TASK_COMMENTS], [TASK_SEQ], [COSTUMER_CODE], [COSTUMER_NAME], [TASK_ADDRESS]);


GO
CREATE NONCLUSTERED INDEX [IDX_TASK_ID_TASK_DATE_ASSIGNED_TO]
    ON [SONDA].[SWIFT_TASKS]([TASK_DATE] ASC, [ASSIGEND_TO] ASC)
    INCLUDE([TASK_ID]);


GO
CREATE NONCLUSTERED INDEX [IDX_STATUS_TASK_ID]
    ON [SONDA].[SWIFT_TASKS]([TASK_ID] ASC)
    INCLUDE([TASK_STATUS], [ASSIGEND_TO], [TASK_DATE]);


GO
CREATE NONCLUSTERED INDEX [IDX_STATUS_TASK]
    ON [SONDA].[SWIFT_TASKS]([TASK_ID] ASC, [TASK_STATUS] ASC);
