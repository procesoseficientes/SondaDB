﻿CREATE TABLE [PACASA].[SWIFT_ORDER_FOR_DISCOUNT_HEADER] (
    [ORDER_FOR_DISCOUNT_HEADER_ID] INT           IDENTITY (1, 1) NOT NULL,
    [NAME]                         VARCHAR (50)  NOT NULL,
    [DESCRIPTION]                  VARCHAR (256) NOT NULL,
    PRIMARY KEY CLUSTERED ([ORDER_FOR_DISCOUNT_HEADER_ID] ASC)
);

