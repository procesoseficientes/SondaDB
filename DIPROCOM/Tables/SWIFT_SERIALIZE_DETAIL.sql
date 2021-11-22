﻿CREATE TABLE [PACASA].[SWIFT_SERIALIZE_DETAIL] (
    [SERIALIZE_DETAIL] INT           IDENTITY (1, 1) NOT NULL,
    [SERIALIZE_HEADER] INT           NULL,
    [CODE_SKU]         VARCHAR (50)  NULL,
    [DESCRIPTION_SKU]  VARCHAR (MAX) NULL,
    [EXPECTED]         FLOAT (53)    NULL,
    [SCANNED]          FLOAT (53)    NULL,
    [RESULT]           VARCHAR (50)  NULL,
    [COMMENTS]         VARCHAR (MAX) NULL,
    [LAST_UPDATE]      DATETIME      NULL,
    [LAST_UPDATE_BY]   VARCHAR (50)  NULL,
    [DIFFERENCE]       FLOAT (53)    NULL,
    [ALLOCATED]        NUMERIC (18)  NULL
);

