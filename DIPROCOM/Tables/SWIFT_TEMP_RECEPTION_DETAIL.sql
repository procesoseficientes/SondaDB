﻿CREATE TABLE [DIPROCOM].[SWIFT_TEMP_RECEPTION_DETAIL] (
    [RECEPTION_DETAIL_TEMP] INT           IDENTITY (1, 1) NOT NULL,
    [RECEPTION_HEADER]      INT           NULL,
    [CODE_SKU]              VARCHAR (50)  NULL,
    [DESCRIPTION_SKU]       VARCHAR (MAX) NULL,
    [EXPECTED]              FLOAT (53)    NULL,
    [SCANNED]               FLOAT (53)    NULL,
    [RESULT]                VARCHAR (50)  NULL,
    [OBSERVATIONS]          VARCHAR (MAX) NULL,
    [LAST_UPDATE]           DATETIME      NULL,
    [LAST_UPDATE_BY]        VARCHAR (50)  NULL,
    [DIFFERENCE]            FLOAT (53)    NULL,
    CONSTRAINT [PK_SWIFT_TEMP_RECEPTION_DETAIL] PRIMARY KEY CLUSTERED ([RECEPTION_DETAIL_TEMP] ASC)
);

