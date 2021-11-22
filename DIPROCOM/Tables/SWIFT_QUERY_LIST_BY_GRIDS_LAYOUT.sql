﻿CREATE TABLE [PACASA].[SWIFT_QUERY_LIST_BY_GRIDS_LAYOUT] (
    [QUERY_LIST_ID] INT          NOT NULL,
    [LOGIN_ID]      VARCHAR (25) NOT NULL,
    [LAYOUT_XML]    XML          NULL,
    PRIMARY KEY CLUSTERED ([QUERY_LIST_ID] ASC, [LOGIN_ID] ASC)
);

