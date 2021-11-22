
-- =============================================
-- Autor:				ppablo.loukota
-- Fecha de Creacion: 	07-01-2016
-- Description:			Valida los pallets por lote

/*
-- Ejemplo de Ejecucion:				
				--
EXECUTE  [PACASA].[SWIFT_SP_GET_BATCH_PALLET] 
   @PALLET_ID = 2
  ,@BATCH_ID = 2

				--				
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_BATCH_PALLET]
     @PALLET_ID AS INT
	,@BATCH_ID AS INT
		
AS
BEGIN 

  SET NOCOUNT ON;

  SELECT COUNT(*) AS CANTIDAD_PALLET_LOTE
  FROM [PACASA].[SWIFT_PALLET]
  WHERE [PALLET_ID] = @PALLET_ID AND [BATCH_ID] = @BATCH_ID
      


END








