﻿CREATE FUNCTION [acsa].[SWIFT_FUNC_GET_MY_TODAY_ROUTE_PLAN] (
	@pLoginID VARCHAR(50)
) RETURNS TABLE
AS RETURN (
	SELECT
		ROW_NUMBER() OVER (ORDER BY [TASK_ID]) AS [TASK_PRIORITY]
		,[T].[TASK_ID]
		,[T].[TASK_TYPE]
		,[T].[TASK_DATE]
		,[T].[SCHEDULE_FOR]
		,[T].[CREATED_STAMP]
		,[T].[ASSIGEND_TO] AS [ASSIGNED_TO]
		,[T].[ASSIGNED_BY]
		,[T].[ASSIGNED_STAMP]
		,[T].[CANCELED_STAMP]
		,[T].[CANCELED_BY]
		,[T].[ACCEPTED_STAMP]
		,[T].[COMPLETED_STAMP]
		,[T].[RELATED_PROVIDER_CODE]
		,[T].[RELATED_PROVIDER_NAME]
		,[T].[EXPECTED_GPS]
		,[T].[POSTED_GPS]
		,[T].[TASK_STATUS]
		,[dbo].[FUNC_REMOVE_SPECIAL_CHARS]([TASK_COMMENTS]) AS [TASK_COMMENTS]
		,[T].[TASK_SEQ]
		,[T].[REFERENCE]
		,[T].[SAP_REFERENCE]
		,[T].[COSTUMER_CODE] AS [CUSTOMER_CODE]
		,[dbo].[FUNC_REMOVE_SPECIAL_CHARS]([COSTUMER_NAME]) AS [CUSTOMER_NAME]
		,[T].[RECEPTION_NUMBER]
		,[T].[PICKING_NUMBER]
		,[T].[COUNT_ID]
		,[T].[ACTION]
		,[T].[SCANNING_STATUS]
		,[T].[ALLOW_STORAGE_ON_DIFF]
		,[T].[CUSTOMER_PHONE]
		,[dbo].[FUNC_REMOVE_SPECIAL_CHARS]([TASK_ADDRESS]) AS [TASK_ADDRESS]
		,[T].[VISIT_HOUR]
		,[T].[ROUTE_IS_COMPLETED]
		,[T].[EMAIL_TO_CONFIRM]
		,[acsa].[SWIFT_FN_GET_RGA_CODE_BY_CUSTOMER]([COSTUMER_CODE]) AS [RGA_CODE]
	FROM [acsa].[SWIFT_TASKS] [T]
	WHERE [ASSIGEND_TO] = UPPER(@pLoginID)
		AND CONVERT(DATE, [SCHEDULE_FOR]) = CONVERT(DATE, GETDATE())
		AND [TASK_TYPE] IN ('PRESALE', 'DELIVERY', 'SALES')
		AND [ROUTE_IS_COMPLETED] = 0
);
