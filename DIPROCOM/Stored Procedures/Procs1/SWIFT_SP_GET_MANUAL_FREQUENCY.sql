-- =============================================
-- Autor:				Christian Hernandez 
-- Fecha de Creacion: 	07-18-2018
-- Description:			Seleciona todoas las frecuencias que han sido insertadas manualmente 
--                      
/*
-- Ejemplo de Ejecucion:				
				--exec [PACASA].[SWIFT_SP_GET_MANUAL_FREQUENCY] 
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_MANUAL_FREQUENCY]
AS
	BEGIN
		SELECT
			[VAC].[CODE_CUSTOMER]
			,[VAC].[NAME_CUSTOMER]
		INTO
			[#CUSTOMERS]
		FROM
			[SWIFT_INTERFACES].[PACASA].[ERP_VIEW_COSTUMER] AS [VAC];

		SELECT
			[SF].[ID_FREQUENCY]
			,[US].[CODE_ROUTE] AS [SELLER_CODE]
			,[US].[NAME_ROUTE] AS [SELLER_NAME]
			,[US].[CODE_ROUTE]
			,[SF].[CODE_FREQUENCY]
			,[VAC].[CODE_CUSTOMER]
			,[VAC].[NAME_CUSTOMER]
			,[SF].[TYPE_TASK]
			,[SF].[MONDAY]
			,[SF].[TUESDAY]
			,[SF].[WEDNESDAY]
			,[SF].[THURSDAY]
			,[SF].[FRIDAY]
			,[SF].[SATURDAY]
			,[SF].[SUNDAY]
			,[SF].[FREQUENCY_WEEKS]
			,[FXC].[PRIORITY]
			,[FXC].[LAST_WEEK_VISITED]
		FROM
			[PACASA].[SWIFT_FREQUENCY] [SF]
		INNER JOIN [PACASA].[SWIFT_FREQUENCY_X_CUSTOMER] [FXC]
		ON	[SF].[ID_FREQUENCY] = [FXC].[ID_FREQUENCY]
		INNER JOIN [#CUSTOMERS] [VAC]
		ON	[VAC].[CODE_CUSTOMER] = [FXC].[CODE_CUSTOMER]COLLATE DATABASE_DEFAULT
		INNER JOIN [PACASA].[SWIFT_ROUTES] [US]
		ON	[US].[CODE_ROUTE] = [SF].[CODE_ROUTE] COLLATE DATABASE_DEFAULT
		WHERE
			[SF].[IS_BY_POLIGON] = 0
		ORDER BY
			[FXC].[ID_FREQUENCY]
			,[US].[CODE_ROUTE]
			,[FXC].[PRIORITY];
	END;