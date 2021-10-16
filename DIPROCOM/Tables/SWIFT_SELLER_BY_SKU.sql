﻿CREATE TABLE [SONDA].[SWIFT_SELLER_BY_SKU] (
    [CODE_RELATION]  INT           IDENTITY (1, 1) NOT NULL,
    [CODE_SKU]       NVARCHAR (40) NULL,
    [CODE_SELLER]    NVARCHAR (40) NULL,
    [LAST_UPDATE]    DATETIME      NULL,
    [LAST_UPDATE_BY] NVARCHAR (30) NULL,
    [FREQUENT]       VARCHAR (1)   CONSTRAINT [DF_SWIFT_SELLER_BY_SKU_FREQUENT] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_SWIFT_SELLER_BY_SKU] PRIMARY KEY CLUSTERED ([CODE_RELATION] ASC)
);

