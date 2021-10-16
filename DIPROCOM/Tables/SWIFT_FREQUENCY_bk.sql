CREATE TABLE [SONDA].[SWIFT_FREQUENCY_bk] (
    [ID_FREQUENCY]      INT           IDENTITY (1, 1) NOT NULL,
    [CODE_FREQUENCY]    VARCHAR (50)  NOT NULL,
    [SUNDAY]            INT           NOT NULL,
    [MONDAY]            INT           NOT NULL,
    [TUESDAY]           INT           NOT NULL,
    [WEDNESDAY]         INT           NOT NULL,
    [THURSDAY]          INT           NOT NULL,
    [FRIDAY]            INT           NOT NULL,
    [SATURDAY]          INT           NOT NULL,
    [FREQUENCY_WEEKS]   INT           NOT NULL,
    [LAST_WEEK_VISITED] DATE          NOT NULL,
    [LAST_UPDATED]      DATETIME      NOT NULL,
    [LAST_UPDATED_BY]   NVARCHAR (25) NULL,
    [CODE_ROUTE]        VARCHAR (50)  NOT NULL,
    [TYPE_TASK]         VARCHAR (20)  NOT NULL,
    [REFERENCE_SOURCE]  VARCHAR (150) NULL,
    [POLYGON_ID]        INT           NULL
);

