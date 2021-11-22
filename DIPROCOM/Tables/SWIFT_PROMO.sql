﻿CREATE TABLE [PACASA].[SWIFT_PROMO] (
    [PROMO_ID]    INT           IDENTITY (1, 1) NOT NULL,
    [PROMO_NAME]  VARCHAR (250) NOT NULL,
    [PROMO_TYPE]  VARCHAR (50)  NOT NULL,
    [LAST_UPDATE] DATETIME      DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([PROMO_ID] ASC),
    CONSTRAINT [UQ_SWIFT_PROMO_PROMO_NAME] UNIQUE NONCLUSTERED ([PROMO_NAME] ASC, [PROMO_TYPE] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_PROMO_LAST_UPDATE]
    ON [PACASA].[SWIFT_PROMO]([LAST_UPDATE] ASC);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_PROMO_PROMO_TYPE]
    ON [PACASA].[SWIFT_PROMO]([PROMO_TYPE] ASC);

