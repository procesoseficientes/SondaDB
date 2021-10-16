﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	18-Nov-16 @ A-TEAM Sprint 5 
-- Description:			SP que obtiene las liquidaciones en un rango de fechas

/*
-- Ejemplo de Ejecucion:
				EXEC [DIPROCOM].[SWIFT_SP_GET_COMPLETED_LIQUIDATION]
					@INITIAL_DATE = '20160101 00:00:00.000'
					,@END_DATE = '20170101 00:00:00.000'
					,@ROUTES = 'RUDI@DIPROCOM'
				--
				EXEC [DIPROCOM].[SWIFT_SP_GET_COMPLETED_LIQUIDATION]
					@INITIAL_DATE = '20160101 00:00:00.000'
					,@END_DATE = '20170101 00:00:00.000'
					,@ROUTES = 'RUDI@DIPROCOM|ALBERTO@DIPROCOM'
				--
				EXEC [DIPROCOM].[SWIFT_SP_GET_COMPLETED_LIQUIDATION]
					@INITIAL_DATE = '20160101 00:00:00.000'
					,@END_DATE = '20170101 00:00:00.000'
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_COMPLETED_LIQUIDATION](
	@INITIAL_DATE DATETIME
	,@END_DATE DATETIME 
	,@ROUTES VARCHAR(MAX) = NULL 
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	DECLARE @DELIMETER VARCHAR(50)
	--
	SELECT @DELIMETER = [DIPROCOM].[SWIFT_FN_GET_PARAMETER]('DELIMITER','DEFAULT_DELIMITER')
	--
	DECLARE @ROUTE TABLE (
		[CODE_ROUTE] VARCHAR(50)
	)
	--
	IF @ROUTES IS NULL
	BEGIN
		INSERT INTO @ROUTE
				([CODE_ROUTE])
		SELECT [CODE_ROUTE]
		FROM [DIPROCOM].[SWIFT_ROUTES]
	END
	ELSE
	BEGIN
		INSERT INTO @ROUTE
				([CODE_ROUTE])
		SELECT [VALUE]
		FROM [DIPROCOM].[SWIFT_FN_SPLIT_2](@ROUTES,@DELIMETER)
	END
	--
	SELECT
		[L].[LIQUIDATION_ID]
		,[L].[CODE_ROUTE]
		,[SR].[NAME_ROUTE]
		,[L].[LOGIN]
		,[U1].[NAME_USER]
		,[S].[SELLER_CODE]
		,[S].[SELLER_NAME]
		,[L].[LIQUIDATION_DATE]
		,[L].[LAST_UPDATE]
		,[U2].[NAME_USER] [LAST_UPDATE_NAME]
		,[L].[LAST_UPDATE_BY]
		,[L].[LIQUIDATION_STATUS]
		,[L].[STATUS]
		,[U1].[USER_TYPE]
		,[C].[VALUE_TEXT_CLASSIFICATION] [TYPE_USER_DESCRIPTION]
		,[L].[LIQUIDATION_COMMENT]
	FROM [DIPROCOM].[SONDA_LIQUIDATION] [L]
	INNER JOIN @ROUTE [TR] ON (
		[TR].[CODE_ROUTE] = [L].[CODE_ROUTE]
	)
	INNER JOIN [DIPROCOM].[USERS] [U1] ON (
		[U1].[LOGIN] = [L].[LOGIN]
	)
	INNER JOIN [DIPROCOM].[SWIFT_SELLER] [S] ON (
		[U1].[RELATED_SELLER] = [S].[SELLER_CODE]
	)
	INNER JOIN [DIPROCOM].[USERS] [U2] ON (
		[U2].[LOGIN] = [L].[LOGIN]
	)
	INNER JOIN [DIPROCOM].[SWIFT_ROUTES] [SR] ON (
		[SR].[CODE_ROUTE] = [L].[CODE_ROUTE]
	)
	LEFT JOIN [DIPROCOM].[SWIFT_CLASSIFICATION] [C] ON (
		[C].[GROUP_CLASSIFICATION] = 'USER_ROLE'
		AND [C].[NAME_CLASSIFICATION] = [U1].[USER_TYPE]
	)
	WHERE [L].[LIQUIDATION_ID] > 0
		AND [L].[LIQUIDATION_DATE] BETWEEN @INITIAL_DATE AND dateadd(HOUR,23,@END_DATE)
		AND [L].[STATUS] = 'COMPLETED'
END



