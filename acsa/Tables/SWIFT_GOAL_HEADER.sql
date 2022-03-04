﻿CREATE TABLE [acsa].[SWIFT_GOAL_HEADER] (
    [GOAL_HEADER_ID]   INT             IDENTITY (1, 1) NOT NULL,
    [GOAL_NAME]        VARCHAR (120)   NOT NULL,
    [TEAM_ID]          INT             NOT NULL,
    [SUPERVISOR_ID]    INT             NOT NULL,
    [GOAL_AMOUNT]      DECIMAL (18, 6) NOT NULL,
    [GOAL_DATE_FROM]   DATETIME        NOT NULL,
    [GOAL_DATE_TO]     DATETIME        NOT NULL,
    [GOAL_CLOSE_DATE]  VARCHAR (250)   NULL,
    [STATUS]           VARCHAR (25)    NOT NULL,
    [INCLUDE_SATURDAY] INT             NOT NULL,
    [LAST_UPDATE]      DATETIME        NULL,
    [LAST_UPDATE_BY]   VARCHAR (50)    NULL,
    [CLOSED_BY]        VARCHAR (50)    NULL,
    [SALE_TYPE]        VARCHAR (25)    DEFAULT ('PRE') NOT NULL,
    [PERIOD_DAYS]      INT             CONSTRAINT [DF_swiftGoalHeader_periodDays] DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([GOAL_HEADER_ID] ASC)
);
