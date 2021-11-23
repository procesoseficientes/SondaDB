﻿CREATE TABLE [PACASA].[SWIFT_STATISTICS_GOALS_BY_SALES] (
    [STATISTICS_GOAL_BY_SALE_ID] INT             IDENTITY (1, 1) NOT NULL,
    [GOAL_HEADER_ID]             INT             NULL,
    [TEAM_ID]                    INT             NULL,
    [USER_ID]                    INT             NULL,
    [SELLER_CODE]                VARCHAR (50)    NULL,
    [SELLER_NAME]                VARCHAR (50)    NULL,
    [CODE_ROUTE]                 VARCHAR (50)    NULL,
    [NAME_ROUTE]                 VARCHAR (50)    NULL,
    [RANKING]                    INT             NULL,
    [DAILY_GOAL]                 NUMERIC (18, 6) NULL,
    [ACCUMULATED_BY_PERIOD]      NUMERIC (18, 6) NULL,
    [PERCENTAGE_GOAL_DAILY]      NUMERIC (18, 2) NULL,
    [DAYS_OF_SALE]               INT             NULL,
    [REMAINING_DAYS]             INT             NULL,
    [PERCENTAGE_OF_DAYS]         NUMERIC (18, 2) NULL,
    [GENERAL_GOAL]               NUMERIC (18, 2) NULL,
    [DIFFERENCE_FROM_THE_GOAL]   NUMERIC (18, 2) NULL,
    [NEXT_SALE_GOAL]             NUMERIC (18, 6) NULL,
    [PERCENTAGE_OF_GENERAL_GOAL] NUMERIC (18, 2) NULL,
    [SALE_OF_THE_DAY]            NUMERIC (18, 6) NULL,
    [SALES_DATE]                 DATE            NULL,
    [CREATED_DATE]               DATE            DEFAULT (getdate()) NULL,
    [LAST_CREATED]               INT             NULL,
    [SALE_TYPE]                  VARCHAR (50)    NULL,
    PRIMARY KEY CLUSTERED ([STATISTICS_GOAL_BY_SALE_ID] ASC)
);




GO
CREATE NONCLUSTERED INDEX [IX_SWIFT_STATISTICS_GOALS_BY_SALES_CODE_ROUTE_LAST_CREATED_SALE_TYPE]
    ON [PACASA].[SWIFT_STATISTICS_GOALS_BY_SALES]([CODE_ROUTE] ASC, [LAST_CREATED] ASC, [SALE_TYPE] ASC)
    INCLUDE([GOAL_HEADER_ID], [TEAM_ID], [USER_ID], [RANKING], [DAILY_GOAL], [ACCUMULATED_BY_PERIOD], [REMAINING_DAYS], [PERCENTAGE_OF_GENERAL_GOAL]);

