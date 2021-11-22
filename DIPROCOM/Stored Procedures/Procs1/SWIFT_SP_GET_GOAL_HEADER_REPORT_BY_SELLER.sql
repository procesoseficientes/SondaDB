-- =============================================
-- Autor:				rodrigo.gomez
-- Fecha de Creacion: 	7/5/2018 @ GFORCE-Team Sprint Faisan 
-- Description:			Obtiene las estadisticas semanales

/*
		-- Ejemplo de Ejecucion:
		EXEC [PACASA].[SWIFT_SP_GET_GOAL_HEADER_REPORT_BY_SELLER] @LOGIN = 'rudi@DIPROCOM',
			@TASK_TYPE = 'PRESALE'
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_GOAL_HEADER_REPORT_BY_SELLER]
    (
     @LOGIN VARCHAR(50)
    ,@TASK_TYPE VARCHAR(15)
    )
AS
BEGIN
    SET NOCOUNT ON;
	--
    DECLARE @TYPE VARCHAR(25) = '';
    SELECT
        @TYPE = CASE WHEN @TASK_TYPE = 'PRESALE' THEN 'PRE'
                     ELSE 'VEN'
                END;

    SELECT
        [DG].[TEAM_ID]
       ,[T].[NAME_TEAM]
       ,[DG].[DOC_TYPE]
       ,[DG].[LOGIN]
       ,[DG].[SELLER_NAME]
       ,SUM([DG].[DOCUMENT_QTY]) [DOCUMENT_QTY]
       ,SUM([DG].[DOCUMENT_TOTAL]) [DOCUMENT_TOTAL]
       ,[GH].[INCLUDE_SATURDAY]
       ,[GD].[GOAL_BY_SELLER] [GOAL]
       ,[GD].[DAILY_GOAL_BY_SELLER] [DAILY_GOAL]
    FROM
        [PACASA].[SWIFT_DAILY_GOAL_BY_SELLER] [DG]
    INNER JOIN [PACASA].[SWIFT_GOAL_HEADER] [GH] ON [GH].[TEAM_ID] = [DG].[TEAM_ID]
                                                   AND [GH].[STATUS] = 1
                                                   AND [GH].[SALE_TYPE] = @TYPE
                                                   AND [DG].[DATE] BETWEEN [GH].[GOAL_DATE_FROM]
                                                              AND
                                                              [GH].[GOAL_DATE_TO]
    INNER JOIN [PACASA].[USERS] [U] ON [U].[LOGIN] = [DG].[LOGIN]
    INNER JOIN [PACASA].[SWIFT_TEAM] [T] ON [T].[TEAM_ID] = [DG].[TEAM_ID]
    INNER JOIN [PACASA].[SWIFT_GOAL_DETAIL] [GD] ON [GD].[GOAL_HEADER_ID] = [GH].[GOAL_HEADER_ID]
                                                   AND [U].[CORRELATIVE] = [GD].[SELLER_ID]
    WHERE
        [DG].[LOGIN] = @LOGIN
        AND [DG].[DOC_TYPE] = @TASK_TYPE
    GROUP BY
        [DG].[TEAM_ID]
       ,[T].[NAME_TEAM]
       ,[DG].[DOC_TYPE]
       ,[DG].[LOGIN]
       ,[DG].[SELLER_NAME]
       ,[GH].[INCLUDE_SATURDAY]
       ,[GD].[GOAL_BY_SELLER]
       ,[GD].[DAILY_GOAL_BY_SELLER];

END;