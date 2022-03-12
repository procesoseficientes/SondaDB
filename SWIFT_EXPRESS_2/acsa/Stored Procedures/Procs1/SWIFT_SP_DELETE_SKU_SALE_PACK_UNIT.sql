﻿CREATE PROCEDURE [SONDA].[SWIFT_SP_DELETE_SKU_SALE_PACK_UNIT]
    @CODE_PACK_UNIT VARCHAR(25) 
	  ,@CODE_SKU VARCHAR(50) 

AS
BEGIN TRY
		DELETE FROM [SONDA].SWIFT_SKU_SALE_PACK_UNIT 
		WHERE CODE_PACK_UNIT = @CODE_PACK_UNIT
		AND CODE_SKU  = @CODE_SKU

	IF @@error = 0 BEGIN		
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo
	END		
	ELSE BEGIN
		
		SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo
	END

END TRY
BEGIN CATCH     
	 SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo 
END CATCH