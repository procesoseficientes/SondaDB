-- =============================================
-- Autor:				rodrigo.gomez
-- Fecha de Creacion: 	7/5/2018 @ GFORCE-Team Sprint Faisan
-- Description:			Obtiene estadisticas de meta por equipo

/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].[SWIFT_SP_GET_TEAM_GOAL_REPORT]
					@TEAM_ID = 2
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_TEAM_GOAL_REPORT] (@TEAM_ID INT)
AS
BEGIN
    SET NOCOUNT ON;
	--
    DECLARE @CURRENCY VARCHAR(5);

    DECLARE @RESULT TABLE
        (
         [TEAM_ID] INT
        ,[SUPER_NAME] VARCHAR(100)
        ,[TEAM_NAME] VARCHAR(100)
        ,[DOCUMENT_QTY] INT
        ,[DOCUMENT_TOTAL] DECIMAL(18, 6)
        ,[DOCUMENT_TYPE] VARCHAR(50)
        );
	--
    SELECT TOP 1
        @CURRENCY = [SYMBOL_CURRENCY]
    FROM
        [PACASA].[SWIFT_CURRENCY]
    WHERE
        [IS_DEFAULT] = 1;
	--
    INSERT  INTO @RESULT
            (
             [TEAM_ID]
            ,[SUPER_NAME]
            ,[TEAM_NAME]
            ,[DOCUMENT_QTY]
            ,[DOCUMENT_TOTAL]
            ,[DOCUMENT_TYPE]
	        )
    SELECT
        @TEAM_ID [TEAM_ID]
       ,[S].[NAME_USER] [SUPER_NAME]
       ,[T].[NAME_TEAM] [TEAM_NAME]
       ,COUNT([SOH].[SALES_ORDER_ID]) [DOCUMENT_QTY]
       ,SUM([PACASA].[SWIFT_FN_GET_SALES_ORDER_TOTAL]([SOH].[SALES_ORDER_ID])) [DOCUMENT_TOTAL]
       ,'PRE'
    FROM
        [PACASA].[SONDA_SALES_ORDER_HEADER] [SOH]
    INNER JOIN [PACASA].[SWIFT_TASKS] [TS] ON [TS].[TASK_ID] = [SOH].[TASK_ID]
    INNER JOIN [PACASA].[USERS] [U] ON [SOH].[POSTED_BY] = [U].[LOGIN]
    INNER JOIN [PACASA].[SWIFT_USER_BY_TEAM] [UT] ON [UT].[USER_ID] = [U].[CORRELATIVE]
    INNER JOIN [PACASA].[SWIFT_TEAM] [T] ON [T].[TEAM_ID] = [UT].[TEAM_ID]
    INNER JOIN [PACASA].[USERS] [S] ON [S].[CORRELATIVE] = [T].[SUPERVISOR]
    WHERE
        [UT].[TEAM_ID] = @TEAM_ID
        AND FORMAT([TS].[TASK_DATE], 'yyyyMMdd') = FORMAT(GETDATE(),
                                                          'yyyyMMdd')
        AND [SOH].[IS_READY_TO_SEND] = 1
    GROUP BY
        [S].[NAME_USER]
       ,[T].[NAME_TEAM];

    INSERT  INTO @RESULT
            (
             [TEAM_ID]
            ,[SUPER_NAME]
            ,[TEAM_NAME]
            ,[DOCUMENT_QTY]
            ,[DOCUMENT_TOTAL]
            ,[DOCUMENT_TYPE]
	        )
    SELECT
        @TEAM_ID [TEAM_ID]
       ,[S].[NAME_USER] [SUPER_NAME]
       ,[T].[NAME_TEAM] [TEAM_NAME]
       ,COUNT([SPH].[INVOICE_ID]) [DOCUMENT_QTY]
       ,SUM([SPH].[TOTAL_AMOUNT]) [DOCUMENT_TOTAL]
       ,'VEN'
    FROM
        [PACASA].[SONDA_POS_INVOICE_HEADER] [SPH]
    INNER JOIN [PACASA].[USERS] [U] ON [SPH].[POSTED_BY] = [U].[LOGIN]
    INNER JOIN [PACASA].[SWIFT_USER_BY_TEAM] [UT] ON [UT].[USER_ID] = [U].[CORRELATIVE]
    INNER JOIN [PACASA].[SWIFT_TEAM] [T] ON [T].[TEAM_ID] = [UT].[TEAM_ID]
    INNER JOIN [PACASA].[USERS] [S] ON [S].[CORRELATIVE] = [T].[SUPERVISOR]
    WHERE
        [UT].[TEAM_ID] = @TEAM_ID
        AND FORMAT([SPH].[POSTED_DATETIME], 'yyyyMMdd') = FORMAT(GETDATE(),
                                                              'yyyyMMdd')
        AND [SPH].[IS_READY_TO_SEND] = 1
    GROUP BY
        [S].[NAME_USER]
       ,[T].[NAME_TEAM];


	-- ------------------------------------------------------------------------------------
	-- Resultado final
	-- ------------------------------------------------------------------------------------
	
    SELECT
        [GH].[GOAL_HEADER_ID]
       ,[GH].[GOAL_NAME]
       ,[GH].[GOAL_AMOUNT]
       ,SUM([DG].[DOCUMENT_TOTAL]) + ISNULL([R].[DOCUMENT_TOTAL], 0) [TO_DATE]
       ,[GH].[GOAL_AMOUNT] - (SUM([DG].[DOCUMENT_TOTAL])
                              + ISNULL([R].[DOCUMENT_TOTAL], 0)) [LEFT]
       ,[PACASA].[SWIFT_FN_GET_GOAL_WORK_DAYS](GETDATE(), [GH].[GOAL_DATE_TO],
                                              [GH].[INCLUDE_SATURDAY]) [DAYS_LEFT]
       ,[PACASA].[SWIFT_FN_GET_GOAL_WORK_DAYS]([GH].[GOAL_DATE_FROM], GETDATE(),
                                              [GH].[INCLUDE_SATURDAY]) [DAYS_PASSED]
       ,SUM([GD].[DAILY_GOAL_BY_SELLER]) [DAILY_GOAL]
       ,ISNULL([R].[DOCUMENT_TOTAL], 0) [SALES]
       ,SUM([GD].[DAILY_GOAL_BY_SELLER]) - ISNULL([R].[DOCUMENT_TOTAL], 0) [DAILY_GOAL_LEFT]
       ,@CURRENCY [CURRENCY]
    FROM
        [PACASA].[SWIFT_GOAL_HEADER] [GH]
    INNER JOIN [PACASA].[SWIFT_GOAL_DETAIL] [GD] ON [GD].[GOAL_HEADER_ID] = [GH].[GOAL_HEADER_ID]
    INNER JOIN [PACASA].[USERS] [U] ON [U].[CORRELATIVE] = [GD].[SELLER_ID]
    LEFT JOIN [PACASA].[SWIFT_DAILY_GOAL_BY_SELLER] [DG] ON [DG].[TEAM_ID] = [GH].[TEAM_ID]
                                                           AND [DG].[DOC_TYPE] = CASE
                                                              WHEN [GH].[SALE_TYPE] = 'PRE'
                                                              THEN 'PRESALE'
                                                              ELSE 'VEN'
                                                              END
                                                           AND [DG].[DATE] BETWEEN [GH].[GOAL_DATE_FROM]
                                                              AND
                                                              [GH].[GOAL_DATE_TO]
                                                           AND [DG].[LOGIN] = [U].[LOGIN]
    LEFT JOIN @RESULT [R] ON [R].[TEAM_ID] = [GH].[TEAM_ID]
                             AND [R].[DOCUMENT_TYPE] = [GH].[SALE_TYPE]
    WHERE
        [GH].[STATUS] = 1
        AND [GH].[TEAM_ID] = @TEAM_ID
    GROUP BY
        [GH].[GOAL_DATE_TO]
       ,[GH].[GOAL_DATE_FROM]
       ,[GH].[GOAL_HEADER_ID]
       ,[GH].[GOAL_AMOUNT]
       ,[R].[DOCUMENT_TOTAL]
       ,[GH].[GOAL_NAME]
       ,[GH].[INCLUDE_SATURDAY];
END;