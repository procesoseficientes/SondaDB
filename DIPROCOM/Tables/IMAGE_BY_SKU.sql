﻿CREATE TABLE [PACASA].[IMAGE_BY_SKU] (
    [ID]       INT           IDENTITY (1, 1) NOT NULL,
    [CODE_SKU] VARCHAR (250) NOT NULL,
    [IMAGE1]   VARCHAR (MAX) NULL,
    [IMAGE2]   VARCHAR (MAX) NULL,
    [IMAGE3]   VARCHAR (MAX) NULL,
    [IMAGE4]   VARCHAR (MAX) NULL,
    [IMAGE5]   VARCHAR (MAX) NULL,
    CONSTRAINT [PK_IMAGE_BY_SKU_CODE_SKU] PRIMARY KEY CLUSTERED ([CODE_SKU] ASC)
);

