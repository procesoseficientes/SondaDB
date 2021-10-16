﻿CREATE TABLE [DIPROCOM].[SWIFT_POLYGON_X_ROUTE] (
    [POSITION]   INT             NULL,
    [CODE_ROUTE] VARCHAR (50)    NOT NULL,
    [LATITUDE]   DECIMAL (19, 6) NOT NULL,
    [LONGITUDE]  DECIMAL (19, 6) NOT NULL,
    CONSTRAINT [PK_SWIFT_POLYGON_X_ROUTE] PRIMARY KEY CLUSTERED ([CODE_ROUTE] ASC, [LATITUDE] ASC, [LONGITUDE] ASC)
);

