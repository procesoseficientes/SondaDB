﻿CREATE TABLE [DIPROCOM].[SWIFT_FREQUENCY_BY_POLYGON] (
    [POLYGON_ID]   INT NOT NULL,
    [ID_FREQUENCY] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([POLYGON_ID] ASC, [ID_FREQUENCY] ASC),
    FOREIGN KEY ([ID_FREQUENCY]) REFERENCES [DIPROCOM].[SWIFT_FREQUENCY] ([ID_FREQUENCY]),
    FOREIGN KEY ([POLYGON_ID]) REFERENCES [DIPROCOM].[SWIFT_POLYGON] ([POLYGON_ID])
);

