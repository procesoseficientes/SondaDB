﻿CREATE TABLE [SONDA].[SONDA_PHRASES_AND_SCENARIOS_FEL] (
    [ID]                INT           IDENTITY (1, 1) NOT NULL,
    [FEL_DOCUMENT_TYPE] VARCHAR (250) NOT NULL,
    [PHRASE_CODE]       INT           NOT NULL,
    [SCENARIO_CODE]     INT           NOT NULL,
    [DESCRIPTION]       VARCHAR (250) NOT NULL,
    [TEXT_TO_SHOW]      VARCHAR (250) NOT NULL,
    CONSTRAINT [PK_PHRASE_AND_SCENARIO_FEL] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [UK_DOC_TYPE_PHRASE_CODE_SCENARIO_CODE] UNIQUE NONCLUSTERED ([FEL_DOCUMENT_TYPE] ASC, [PHRASE_CODE] ASC, [SCENARIO_CODE] ASC)
);

