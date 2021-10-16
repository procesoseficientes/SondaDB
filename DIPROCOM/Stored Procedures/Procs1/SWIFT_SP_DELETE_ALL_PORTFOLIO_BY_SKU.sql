﻿create PROC [SONDA].[SWIFT_SP_DELETE_ALL_PORTFOLIO_BY_SKU]	
	 @CODE_PORTFOLIO VARCHAR(25)	
	, @pResult VARCHAR(250) OUTPUT
AS
BEGIN
	
	BEGIN TRAN t1
		BEGIN
			DELETE [SONDA].SWIFT_PORTFOLIO_BY_SKU
			WHERE CODE_PORTFOLIO = @CODE_PORTFOLIO			
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




