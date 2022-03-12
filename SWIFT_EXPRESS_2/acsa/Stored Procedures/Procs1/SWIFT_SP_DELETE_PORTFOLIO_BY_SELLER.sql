﻿CREATE PROC [SONDA].[SWIFT_SP_DELETE_PORTFOLIO_BY_SELLER]	
	 @CODE_SELLER VARCHAR(50)
	, @pResult VARCHAR(250) OUTPUT
AS
BEGIN
	
	BEGIN TRAN t1
		BEGIN
			DELETE [SONDA].SWIFT_PORTFOLIO_BY_SELLER
			WHERE CODE_SELLER = @CODE_SELLER			
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