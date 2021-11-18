﻿-- =============================================
-- Autor:				rodrigo.gomez
-- Fecha de Creacion: 	1/23/2017 @ A-TEAM Sprint Bankole 
-- Description:			Obtiene todos los datos de la tabla SWIFT_TRANSFER_HEADER filtrados por fecha

/*
-- Ejemplo de Ejecucion:
				EXEC [acsa].[SWIFT_SP_GET_TRANSFER_HEADER]
				@START_DATETIME = '20170101 00:00:00.000'
				,@END_DATETIME = '20170201 00:00:00.000'
*/
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_GET_TRANSFER_HEADER](
	@START_DATETIME DATETIME = NULL	
	,@END_DATETIME DATETIME = NULL	
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT 
		[TH].[TRANSFER_ID]
		,[TH].[SELLER_CODE]
		,[S].[SELLER_NAME]
		,[TH].[SELLER_ROUTE]
		,[R].[NAME_ROUTE]
		,[TH].[CODE_WAREHOUSE_SOURCE]
		,[CWS].[DESCRIPTION_WAREHOUSE] AS NAME_WAREHOUSE_SOURCE
		,[TH].[CODE_WAREHOUSE_TARGET]
		,[CWT].[DESCRIPTION_WAREHOUSE] AS NAME_WAREHOUSE_TARGET
		,[TH].[STATUS]
		,[TH].[LAST_UPDATE]
		,[TH].[LAST_UPDATE_BY]
		,[TH].[COMMENT]
		,[TH].[IS_ONLINE]
		,CASE CAST([TH].[IS_ONLINE] AS VARCHAR)
			WHEN '0' THEN 'Inicio de Ruta'
			WHEN '1' THEN 'En linea'
			ELSE CAST([TH].[IS_ONLINE] AS VARCHAR)
		END [IS_ONLINE_DESCRIPTION]
		,[TH].[CREATION_DATE]
	FROM [acsa].[SWIFT_TRANSFER_HEADER] [TH]
		INNER JOIN [acsa].[SWIFT_SELLER] [S] ON [S].[SELLER_CODE] = [TH].[SELLER_CODE]
		INNER JOIN [acsa].[SWIFT_ROUTES] [R] ON [R].[CODE_ROUTE] = [TH].[SELLER_ROUTE]
		INNER JOIN [acsa].[SWIFT_WAREHOUSES] [CWS] ON [CWS].[CODE_WAREHOUSE] = [TH].[CODE_WAREHOUSE_SOURCE]
		INNER JOIN [acsa].[SWIFT_WAREHOUSES] [CWT] ON [CWT].[CODE_WAREHOUSE] = [TH].[CODE_WAREHOUSE_TARGET]
	WHERE [TH].[CREATION_DATE] BETWEEN @START_DATETIME AND @END_DATETIME
	ORDER BY [TH].[TRANSFER_ID] ASC	
END



