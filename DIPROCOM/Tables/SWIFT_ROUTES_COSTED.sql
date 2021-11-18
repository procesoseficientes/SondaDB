﻿CREATE TABLE [acsa].[SWIFT_ROUTES_COSTED] (
    [VEHICULE_ID]         INT           NOT NULL,
    [ROUTED_DATETIME]     DATETIME      NOT NULL,
    [CONSUMMED_GAS]       MONEY         NULL,
    [INDIRECT_COST]       MONEY         NULL,
    [ROUTE_ID]            VARCHAR (50)  NULL,
    [ACCUMULATED_KMS]     INT           NULL,
    [ACCUMULATED_COSTS]   MONEY         NULL,
    [STARTING_LAT_LON]    VARCHAR (150) NULL,
    [ENDING_LAT_LON]      VARCHAR (150) NULL,
    [VEHICULE_CLASS]      VARCHAR (50)  NULL,
    [VEHICULE_BRAND]      VARCHAR (50)  NULL,
    [VEHICULE_ROUTE_TYPE] VARCHAR (50)  NULL,
    CONSTRAINT [PK_SWIFT_ROUTES_COSTED] PRIMARY KEY CLUSTERED ([VEHICULE_ID] ASC, [ROUTED_DATETIME] ASC)
);

