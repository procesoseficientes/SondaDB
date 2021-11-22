﻿CREATE TABLE [PACASA].[SWIFT_PICKING_DETAIL] (
    [PICKING_DETAIL]     INT           IDENTITY (1, 1) NOT NULL,
    [PICKING_HEADER]     INT           NULL,
    [CODE_SKU]           VARCHAR (50)  NULL,
    [DESCRIPTION_SKU]    VARCHAR (MAX) NULL,
    [DISPATCH]           FLOAT (53)    NULL,
    [SCANNED]            FLOAT (53)    NULL,
    [RESULT]             FLOAT (53)    NULL,
    [COMMENTS]           VARCHAR (MAX) NULL,
    [LAST_UPDATE]        DATETIME      NULL,
    [LAST_UPDATE_BY]     VARCHAR (50)  NULL,
    [DIFFERENCE]         FLOAT (53)    NULL,
    [LP_TARGET_LOCATION] VARCHAR (50)  NULL,
    CONSTRAINT [PK__SWIFT_PI__A8DFA51D5CA1C101] PRIMARY KEY CLUSTERED ([PICKING_DETAIL] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_PICKING_DETAILL_PICKING_HEADER]
    ON [PACASA].[SWIFT_PICKING_DETAIL]([PICKING_HEADER] ASC);

