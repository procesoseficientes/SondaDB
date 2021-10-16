﻿CREATE PROC [DIPROCOM].[SWIFT_SP_DELETE_ALL_CUSTOMER_BY_PAYMENT_METHOD]
	@CODE_PAYMENT VARCHAR(25)	
	, @pResult VARCHAR(250) OUTPUT
AS
BEGIN
	
	BEGIN TRAN t1
		BEGIN
			
			DELETE [DIPROCOM].[SWIFT_PAYMENT_METHODS_BY_CUSTOMER]
			WHERE CODE_PAYMENT = @CODE_PAYMENT;
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



