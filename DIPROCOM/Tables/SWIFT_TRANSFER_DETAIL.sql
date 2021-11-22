﻿CREATE TABLE [PACASA].[SWIFT_TRANSFER_DETAIL] (
    [TRANSFER_ID] NUMERIC (18)  NULL,
    [SKU_CODE]    VARCHAR (50)  NULL,
    [QTY]         FLOAT (53)    NULL,
    [STATUS]      VARCHAR (20)  CONSTRAINT [DF_SWIFT_TRANSFER_DETAIL_STATUS] DEFAULT ('PENDIENTE') NULL,
    [SERIE]       VARCHAR (150) NULL,
    CONSTRAINT [FK_SWIFT_TRANSFER_DETAIL_SWIFT_TRANSFER_HEADER] FOREIGN KEY ([TRANSFER_ID]) REFERENCES [PACASA].[SWIFT_TRANSFER_HEADER] ([TRANSFER_ID]),
    CONSTRAINT [UC_SWIFT_TRANSFER_DETAIL] UNIQUE NONCLUSTERED ([TRANSFER_ID] ASC, [SKU_CODE] ASC, [SERIE] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_TRANSFER_DETAIL_TRANSFER_ID]
    ON [PACASA].[SWIFT_TRANSFER_DETAIL]([TRANSFER_ID] ASC)
    INCLUDE([SKU_CODE]);

