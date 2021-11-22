-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	30-Jan-17 @ A-TEAM Sprint Bankole 
-- Description:			SP que obtiene el detalle de una transferencia 

/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].[SWIFT_SP_GET_TRANSFER_DETAIL_BY_TRANSFER_ID]
					@TRANSFER_ID = 119
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_TRANSFER_DETAIL_BY_TRANSFER_ID](
	@TRANSFER_ID INT
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT
        [TD].[TRANSFER_ID]
        ,[TD].[SKU_CODE]
        ,S.[DESCRIPTION_SKU]
        ,[TD].[QTY]
        ,[TD].[STATUS]
        ,[TD].[SERIE]
        ,[s].[CODE_PACK_UNIT] AS [SALES_PACK_UNIT]
        ,'ST' AS [CODE_PACK_UNIT_STOCK] 
		,[S].[VAT_CODE]
    FROM [PACASA].[SWIFT_TRANSFER_DETAIL] [TD]
    INNER JOIN [PACASA].[SWIFT_VIEW_ALL_SKU] [S] ON([S].[CODE_SKU] = [TD].[SKU_CODE])
	INNER JOIN [PACASA].[SWIFT_TRANSFER_HEADER] [TH] ON (TH.TRANSFER_ID = TD.TRANSFER_ID)
	
    WHERE [TD].[TRANSFER_ID] = @TRANSFER_ID and [TH].[STATUS] <> 'CANCELADO'
END






