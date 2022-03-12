﻿-- =============================================
-- Autor:				rodrigo.gomez
-- Fecha de Creacion: 	12/29/2016 @ A-TEAM Sprint  
-- Description:			obtiene las bodegas para preventa por centro de distribucion

/*
-- Ejemplo de Ejecucion:
				EXEC [SONDA].[SWIFT_SP_GET_UNASSIGNED_PRESALE_WAREHOUSE_BY_DISTRIBUTION_CENTER]
					@DISTRIBUTION_CENTER_ID = 1
					,@LOGIN = 'rudi@[SONDA]'
*/
-- =============================================
CREATE PROCEDURE [SONDA].[SWIFT_SP_GET_UNASSIGNED_PRESALE_WAREHOUSE_BY_DISTRIBUTION_CENTER](
	@DISTRIBUTION_CENTER_ID INT
	,@LOGIN VARCHAR(50) = NULL	
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT [W].[WAREHOUSE]
			,[W].[CODE_WAREHOUSE]
			,[W].[DESCRIPTION_WAREHOUSE]
			,[W].[WEATHER_WAREHOUSE]
			,[W].[STATUS_WAREHOUSE]
			,[W].[LAST_UPDATE]
			,[W].[LAST_UPDATE_BY]
			,[W].[IS_EXTERNAL]
			,[W].[BARCODE_WAREHOUSE]
			,[W].[SHORT_DESCRIPTION_WAREHOUSE]
			,[W].[TYPE_WAREHOUSE]
			,[W].[ERP_WAREHOUSE]
			,[W].[ADDRESS_WAREHOUSE]
			,[W].[GPS_WAREHOUSE]
			,[SWDC].[DISTRIBUTION_CENTER_ID]
			,[SWDC].[CODE_WAREHOUSE] 
	FROM [SONDA].[SWIFT_WAREHOUSES] [W]
		INNER JOIN [SONDA].[SWIFT_WAREHOUSE_X_DISTRIBUTION_CENTER] [SWDC] ON [SWDC].[CODE_WAREHOUSE] = [W].[CODE_WAREHOUSE]
	WHERE [SWDC].[DISTRIBUTION_CENTER_ID] = @DISTRIBUTION_CENTER_ID 
			OR [W].[CODE_WAREHOUSE] IN (
				SELECT [PRESALE_WAREHOUSE]
				FROM [SONDA].[USERS]
				WHERE @LOGIN = [LOGIN]
			)
		--AND [W].[CODE_WAREHOUSE] NOT IN (
		--							SELECT [CODE_WAREHOUSE] 
		--							FROM [SONDA].[SWIFT_WAREHOUSE_BY_USER_WITH_ACCESS]
		--							)

END