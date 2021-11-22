﻿-- =============================================
-- Autor:				ppablo.loukota
-- Fecha de Creacion: 	07-01-2016
-- Description:			Valida la existencia del pallet

/*
-- Ejemplo de Ejecucion:				
				--
						EXECUTE  [PACASA].[SWIFT_SP_VALIDATE_PALLET] 
						@PALLET_ID = 2
			--				
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_VALIDATE_PALLET]
	 @PALLET_ID AS INT

AS
BEGIN 

  SET NOCOUNT ON;

  DECLARE  @RESULTADO AS INT = 0;
      
  SELECT  TOP 1 @RESULTADO = 1
	FROM  [PACASA].[SWIFT_PALLET] AS PA 
  WHERE PA.[PALLET_ID] = @PALLET_ID


  SELECT @RESULTADO AS EXISTENCE_PALLET


END






