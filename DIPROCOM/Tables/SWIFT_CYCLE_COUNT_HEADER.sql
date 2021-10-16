﻿CREATE TABLE [SONDA].[SWIFT_CYCLE_COUNT_HEADER] (
    [COUNT_ID]                INT          IDENTITY (1, 1) NOT NULL,
    [COUNT_TYPE]              VARCHAR (20) NULL,
    [COUNT_ASSIGNED_DATE]     DATETIME     NULL,
    [COUNT_STARTED_DATE]      DATETIME     NULL,
    [COUNT_COMPLETED_DATE]    DATETIME     NULL,
    [COUNT_CANCELED_DATETIME] DATETIME     NULL,
    [COUNT_HITS]              INT          NULL,
    [COUNT_MISS]              INT          NULL,
    [COUNT_RESULT]            FLOAT (53)   NULL,
    [COUNT_ASSIGNED_TO]       VARCHAR (50) NULL,
    [COUNT_NAME]              VARCHAR (50) NULL,
    [COUNT_STATUS]            VARCHAR (50) NULL,
    [SEQ]                     INT          NULL,
    CONSTRAINT [PK_DIPROCOM_SWIFT_CYCLE_COUNT_HEADER] PRIMARY KEY CLUSTERED ([COUNT_ID] ASC)
);

