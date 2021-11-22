﻿CREATE TABLE [PACASA].[SWIFT_BONUS_PRIORITY] (
    [BONUS_PRIORITY_ID]                       INT           IDENTITY (1, 1) NOT NULL,
    [DESCRIPTION]                             VARCHAR (250) NULL,
    [ORDER]                                   INT           NULL,
    [ACTIVE_SWIFT_EXPRESS]                    INT           NULL,
    [ACTIVE_SWIFT_INTERFACE_ONLINE]           INT           NULL,
    [SP_SWIFT_EXPRESS]                        VARCHAR (250) NULL,
    [SP_SWIFT_INTERFACE_ONLINE]               VARCHAR (250) NULL,
    [SP_SWIFT_EXPRESS_BY_MULTIPLE]            VARCHAR (250) NULL,
    [SP_SWIFT_EXPRESS_BY_COMBO]               VARCHAR (250) NULL,
    [SP_SWIFT_EXPRES_BONUS_BY_GENERAL_AMOUNT] VARCHAR (250) NULL,
    PRIMARY KEY CLUSTERED ([BONUS_PRIORITY_ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_BONUS_PRIORITY_ORDER_ACTIVE_SWIFT_EXPRESS_ORDER_ACTIVE_SWIFT_EXPRESS]
    ON [PACASA].[SWIFT_BONUS_PRIORITY]([ORDER] ASC, [ACTIVE_SWIFT_EXPRESS] ASC)
    INCLUDE([BONUS_PRIORITY_ID], [SP_SWIFT_EXPRESS], [SP_SWIFT_EXPRESS_BY_MULTIPLE], [SP_SWIFT_EXPRESS_BY_COMBO], [SP_SWIFT_EXPRES_BONUS_BY_GENERAL_AMOUNT]);

