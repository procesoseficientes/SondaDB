﻿CREATE TABLE [SONDA].[SWIFT_SELLER_CONFIGURATIONS] (
    [CODE_CONFIGURATION]           INT           IDENTITY (1, 1) NOT NULL,
    [CODE_SELLER]                  NVARCHAR (30) NULL,
    [ASSIGNED_VEHICLE_CODE]        INT           NULL,
    [ASSIGNED_DISTRIBUTION_CENTER] INT           NULL,
    [CODE_GEO_ROUTE]               INT           NULL,
    CONSTRAINT [PK_SWIFT_SELLER_CONFIGURATIONS] PRIMARY KEY CLUSTERED ([CODE_CONFIGURATION] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_SELLER_CONFIGURATIONS_CODE_SELLER]
    ON [SONDA].[SWIFT_SELLER_CONFIGURATIONS]([CODE_SELLER] ASC)
    INCLUDE([ASSIGNED_VEHICLE_CODE], [ASSIGNED_DISTRIBUTION_CENTER]);
