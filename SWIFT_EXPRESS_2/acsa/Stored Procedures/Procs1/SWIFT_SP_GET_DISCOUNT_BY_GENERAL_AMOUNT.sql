﻿-- =============================================
-- Autor:				diego.as
-- Fecha de Creacion: 	2/15/2017 @ A-TEAM Sprint  Chatuluka
-- Description:			Sp que obtiene todos los Descuentos por mostos Generales del AC

/*
-- Ejemplo de Ejecucion:
				EXEC [SONDA].[SWIFT_SP_GET_DISCOUNT_BY_GENERAL_AMOUNT]
					@TRADE_AGREEMENT_ID = 21
*/
-- =============================================
CREATE PROCEDURE [SONDA].[SWIFT_SP_GET_DISCOUNT_BY_GENERAL_AMOUNT](
	@TRADE_AGREEMENT_ID INT
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	DECLARE 
		@DEFAULT_DISPLAY_DECIMALS INT
		,@QUERY NVARCHAR(2000)	
	--
	SELECT @DEFAULT_DISPLAY_DECIMALS = [SONDA].[SWIFT_FN_GET_PARAMETER]('CALCULATION_RULES','DEFAULT_DISPLAY_DECIMALS')

	--
	SET @QUERY = N'SELECT
		ROW_NUMBER() OVER (ORDER BY [DGA].[TRADE_AGREEMENT_ID]) [ID]
		,[DGA].[TRADE_AGREEMENT_ID]
		,CONVERT(DECIMAL(18,' + CAST(@DEFAULT_DISPLAY_DECIMALS AS VARCHAR) + '),[SONDA].SWIFT_FN_GET_DISPLAY_NUMBER([DGA].[LOW_AMOUNT])) [LOW_AMOUNT]
		,CONVERT(DECIMAL(18,' + CAST(@DEFAULT_DISPLAY_DECIMALS AS VARCHAR) + '),[SONDA].SWIFT_FN_GET_DISPLAY_NUMBER([DGA].[HIGH_AMOUNT])) [HIGH_AMOUNT]
		,CONVERT(DECIMAL(18,' + CAST(@DEFAULT_DISPLAY_DECIMALS AS VARCHAR) + '),[SONDA].SWIFT_FN_GET_DISPLAY_NUMBER([DGA].[DISCOUNT])) [DISCOUNT]
	FROM [SONDA].[SWIFT_TRADE_AGREEMENT_DISCOUNT_BY_GENERAL_AMOUNT] [DGA]
	WHERE [DGA].[TRADE_AGREEMENT_ID] = ' + CAST(@TRADE_AGREEMENT_ID AS VARCHAR)
	--
	PRINT '----> @QUERY: ' + @QUERY
	--
	EXEC(@QUERY)
END