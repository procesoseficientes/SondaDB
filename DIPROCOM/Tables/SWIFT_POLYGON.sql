﻿CREATE TABLE [SONDA].[SWIFT_POLYGON] (
    [POLYGON_ID]           INT           IDENTITY (1, 1) NOT NULL,
    [POLYGON_NAME]         VARCHAR (250) NOT NULL,
    [POLYGON_DESCRIPTION]  VARCHAR (250) NOT NULL,
    [COMMENT]              VARCHAR (250) NULL,
    [LAST_UPDATE_BY]       VARCHAR (50)  NOT NULL,
    [LAST_UPDATE_DATETIME] DATETIME      NOT NULL,
    [POLYGON_ID_PARENT]    INT           NULL,
    [POLYGON_TYPE]         VARCHAR (250) NOT NULL,
    [SUB_TYPE]             VARCHAR (250) NULL,
    [OPTIMIZE]             INT           DEFAULT ((0)) NULL,
    [TYPE_TASK]            VARCHAR (20)  NULL,
    [CODE_WAREHOUSE]       VARCHAR (50)  NULL,
    [LAST_OPTIMIZATION]    DATETIME      NULL,
    [AVAILABLE]            INT           DEFAULT ((0)) NULL,
    [IS_MULTISELLER]       INT           DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([POLYGON_ID] ASC),
    FOREIGN KEY ([POLYGON_ID_PARENT]) REFERENCES [SONDA].[SWIFT_POLYGON] ([POLYGON_ID]),
    FOREIGN KEY ([POLYGON_ID_PARENT]) REFERENCES [SONDA].[SWIFT_POLYGON] ([POLYGON_ID]),
    CONSTRAINT [UC_SWIFT_POLYGON] UNIQUE NONCLUSTERED ([POLYGON_NAME] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_POLYGON_POLYGON_ID_PARENT]
    ON [SONDA].[SWIFT_POLYGON]([POLYGON_ID_PARENT] ASC);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_POLYGON_POLYGON_NAME]
    ON [SONDA].[SWIFT_POLYGON]([POLYGON_NAME] ASC);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_POLYGON_POLYGON_POLYGON_ID_PARENT_SUB_TYPE]
    ON [SONDA].[SWIFT_POLYGON]([POLYGON_ID_PARENT] ASC, [SUB_TYPE] ASC);


GO
CREATE NONCLUSTERED INDEX [IN_SWIFT_POLYGON_POLYGON_POLYGON_TYPE]
    ON [SONDA].[SWIFT_POLYGON]([POLYGON_TYPE] ASC);


GO

CREATE trigger [SONDA].[POLYGON_borrar]
  on [SONDA].[SWIFT_POLYGON]
  for delete
  as
   --Creado por Arleny Sabillon y Marvin para evitar que los clientes puedan borrar poligonos ticket #4442
   if (select count(*) from deleted) > 0
   begin
    raiserror('No se puede borrar este registro',16,1)
    rollback transaction
   end;
