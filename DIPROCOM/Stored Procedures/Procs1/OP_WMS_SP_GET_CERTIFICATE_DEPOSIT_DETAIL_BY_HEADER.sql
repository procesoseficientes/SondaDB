-- =============================================
-- Author:         diego.as
-- Create date:    15-02-2016
-- Description:    Trae TODOS los registros de la Tabla 
--				   [PACASA].[OP_WMS_CERTIFICATE_DEPOSIT_DETAIL] 
--				   con transacción y control de errores.
--				   Recibe como parámetro:
/*
					@ID_DEPOSIT_HEADER INT
				
*/
/*
Ejemplo de Ejecucion:
				--
				EXEC [PACASA].OP_WMS_SP_GET_CERTIFICATE_DEPOSIT_DETAIL_BY_HEADER
					@ID_DEPOSIT_HEADER = 1
				--	
*/
-- =============================================

CREATE PROCEDURE [PACASA].[OP_WMS_SP_GET_CERTIFICATE_DEPOSIT_DETAIL_BY_HEADER]
(
	@ID_DEPOSIT_HEADER INT

)
AS
BEGIN
    SET NOCOUNT ON;

        SELECT 
			[CDD].[CERTIFICATE_DEPOSIT_ID_DETAIL]
			,[CDD].[CERTIFICATE_DEPOSIT_ID_HEADER]
			,[CDD].[DOC_ID]
			,[CDD].[MATERIAL_CODE]
			,[CDD].[SKU_DESCRIPTION]
			,[CDD].[LOCATIONS]
			,[CDD].[BULTOS]
			,[CDD].[QTY]
			,[CDD].[CUSTOMS_AMOUNT]	
		FROM [PACASA].[OP_WMS_CERTIFICATE_DEPOSIT_DETAIL] AS CDD
		WHERE CDD.CERTIFICATE_DEPOSIT_ID_HEADER = @ID_DEPOSIT_HEADER
END
