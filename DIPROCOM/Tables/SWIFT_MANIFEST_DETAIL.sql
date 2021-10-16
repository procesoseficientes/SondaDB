﻿CREATE TABLE [DIPROCOM].[SWIFT_MANIFEST_DETAIL] (
    [MANIFEST_DETAIL]      INT           IDENTITY (1, 1) NOT NULL,
    [CODE_MANIFEST_HEADER] VARCHAR (50)  NULL,
    [CODE_PICKING]         VARCHAR (50)  NULL,
    [LAST_UPDATE]          DATETIME      NULL,
    [LAST_UPDATE_BY]       VARCHAR (50)  NULL,
    [CODE_CUSTOMER]        VARCHAR (50)  NULL,
    [REFERENCE]            VARCHAR (50)  NULL,
    [DOC_SAP_RECEPTION]    VARCHAR (150) NULL,
    [DOC_SAP_PICKING]      VARCHAR (150) NULL,
    [TYPE]                 VARCHAR (20)  NULL,
    [DELIVERY_TASK]        INT           NULL,
    [REJECT_COMMENT]       VARCHAR (250) NULL,
    [IMAGE_1]              VARCHAR (MAX) NULL,
    [GPS_EXPECTED]         VARCHAR (250) DEFAULT (NULL) NULL,
    [STATUS]               VARCHAR (50)  CONSTRAINT [DF_SWIFT_MANIFEST_DETAIL_STATUS] DEFAULT ('ON_WAREHOUSE') NULL,
    [POSTED_GPS]           VARCHAR (250) NULL,
    [ON_WAREHOUSE]         INT           NULL,
    [ON_ROAD]              INT           NULL,
    [IS_DELIVERED]         INT           NULL,
    PRIMARY KEY CLUSTERED ([MANIFEST_DETAIL] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_MANIFEST_DETAIL_CODE_CUSTOMER]
    ON [DIPROCOM].[SWIFT_MANIFEST_DETAIL]([CODE_CUSTOMER] ASC);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_MANIFEST_DETAIL_CODE_MANIFEST_HEADER]
    ON [DIPROCOM].[SWIFT_MANIFEST_DETAIL]([CODE_MANIFEST_HEADER] ASC);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_MANIFEST_DETAIL_CODE_PICKING]
    ON [DIPROCOM].[SWIFT_MANIFEST_DETAIL]([CODE_PICKING] ASC);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_MANIFEST_DETAIL_DOC_SAP_PICKING]
    ON [DIPROCOM].[SWIFT_MANIFEST_DETAIL]([DOC_SAP_PICKING] ASC);

