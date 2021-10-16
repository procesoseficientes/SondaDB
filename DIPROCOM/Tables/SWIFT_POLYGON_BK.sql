﻿CREATE TABLE [DIPROCOM].[SWIFT_POLYGON_BK] (
    [POLYGON_ID]           INT           IDENTITY (1, 1) NOT NULL,
    [POLYGON_NAME]         VARCHAR (250) NOT NULL,
    [POLYGON_DESCRIPTION]  VARCHAR (250) NOT NULL,
    [COMMENT]              VARCHAR (250) NULL,
    [LAST_UPDATE_BY]       VARCHAR (50)  NOT NULL,
    [LAST_UPDATE_DATETIME] DATETIME      NOT NULL,
    [POLYGON_ID_PARENT]    INT           NULL,
    [POLYGON_TYPE]         VARCHAR (250) NOT NULL,
    [SUB_TYPE]             VARCHAR (250) NULL,
    [OPTIMIZE]             INT           NULL,
    [TYPE_TASK]            VARCHAR (20)  NULL,
    [CODE_WAREHOUSE]       VARCHAR (50)  NULL,
    [LAST_OPTIMIZATION]    DATETIME      NULL,
    [AVAILABLE]            INT           NULL,
    [IS_MULTISELLER]       INT           NOT NULL
);

