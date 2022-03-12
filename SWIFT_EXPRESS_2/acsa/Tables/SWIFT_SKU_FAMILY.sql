﻿CREATE TABLE [SONDA].[SWIFT_SKU_FAMILY] (
    [CODE_FAMILY_SKU]        INT           NULL,
    [DESCRIPTION_FAMILY_SKU] VARCHAR (255) NULL,
    [ORDER]                  INT           NULL,
    [LAST_UPDATE]            DATETIME      NULL,
    [LAST_UPDATE_BY]         VARCHAR (50)  NULL,
    CONSTRAINT [UQ__SWIFT_FA__D8193FC2656C112C] UNIQUE NONCLUSTERED ([CODE_FAMILY_SKU] ASC)
);
