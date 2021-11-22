﻿CREATE TABLE [PACASA].[SWIFT_PROMO_BY_BONUS_RULE] (
    [PROMO_ID]               INT      NOT NULL,
    [PROMO_RULE_BY_COMBO_ID] INT      NOT NULL,
    [LAST_UPDATE]            DATETIME DEFAULT (getdate()) NOT NULL,
    PRIMARY KEY CLUSTERED ([PROMO_ID] ASC, [PROMO_RULE_BY_COMBO_ID] ASC),
    FOREIGN KEY ([PROMO_ID]) REFERENCES [PACASA].[SWIFT_PROMO] ([PROMO_ID]),
    FOREIGN KEY ([PROMO_RULE_BY_COMBO_ID]) REFERENCES [PACASA].[SWIFT_PROMO_BY_COMBO_PROMO_RULE] ([PROMO_RULE_BY_COMBO_ID])
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_PROMO_BY_BONUS_RULE_LAST_UPDATE]
    ON [PACASA].[SWIFT_PROMO_BY_BONUS_RULE]([LAST_UPDATE] ASC);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_PROMO_BY_BONUS_RULE_PROMO_ID]
    ON [PACASA].[SWIFT_PROMO_BY_BONUS_RULE]([PROMO_ID] ASC);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_PROMO_BY_BONUS_RULE_PROMO_RULE_BY_COMBO_ID]
    ON [PACASA].[SWIFT_PROMO_BY_BONUS_RULE]([PROMO_RULE_BY_COMBO_ID] ASC);

