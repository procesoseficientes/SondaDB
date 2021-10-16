﻿CREATE PROCEDURE [SONDA].[SWIFT_SP_ELIMINAR_CLIENTE]
	@CODE_CUSTOMER VARCHAR(25)	
	, @pResult VARCHAR(250) OUTPUT
AS
BEGIN
	
	BEGIN TRAN t1
		BEGIN			
			
			DELETE [SONDA].[SWIFT_CUSTOMERS]
		
		WHERE CODE_CUSTOMER = @CODE_CUSTOMER;
		END
	
	
	IF @@error = 0 BEGIN
		SELECT @pResult = 'OK'
		COMMIT TRAN t1
	END		
	ELSE BEGIN
		ROLLBACK TRAN t1
		SELECT	@pResult	= ERROR_MESSAGE()
	END
END




