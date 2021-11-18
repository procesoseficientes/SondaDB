﻿CREATE TABLE [acsa].[SONDA_TAG_X_CUSTOMER_NEW] (
    [TAG_COLOR]   VARCHAR (8) NOT NULL,
    [CUSTOMER_ID] INT         NOT NULL,
    PRIMARY KEY CLUSTERED ([TAG_COLOR] ASC, [CUSTOMER_ID] ASC),
    FOREIGN KEY ([CUSTOMER_ID]) REFERENCES [acsa].[SONDA_CUSTOMER_NEW] ([CUSTOMER_ID]),
    FOREIGN KEY ([TAG_COLOR]) REFERENCES [acsa].[SWIFT_TAGS] ([TAG_COLOR])
);

