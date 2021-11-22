﻿CREATE PROC [PACASA].[SWIFT_SP_DELETE_RESOLUTION]
	@AUTH_ID VARCHAR(25)
	, @AUTH_SERIE VARCHAR(25)	
	, @pResult VARCHAR(250) OUTPUT
AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM SONDA_POS_RES_SAT S
							WHERE AUTH_ID = @AUTH_ID
							AND AUTH_SERIE = @AUTH_SERIE
							AND S.AUTH_DOC_FROM = S.AUTH_CURRENT_DOC) BEGIN 
				SELECT @pResult = 'La resolución ya esta en uso.'
				RETURN -1
	END		
	BEGIN TRAN t1
		BEGIN				
			DELETE SONDA_POS_RES_SAT
			WHERE AUTH_ID = @AUTH_ID
			AND AUTH_SERIE = @AUTH_SERIE
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



