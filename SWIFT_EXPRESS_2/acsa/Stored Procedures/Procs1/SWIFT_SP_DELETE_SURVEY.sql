﻿CREATE PROC [SONDA].[SWIFT_SP_DELETE_SURVEY]
	@SURVEY_ID NUMERIC(18,0)	
AS
BEGIN TRY
BEGIN	
	BEGIN TRAN;
			DELETE [SONDA].SWIFT_SURVEY
			WHERE SURVEY_ID = @SURVEY_ID;
	
	IF @@error = 0 BEGIN
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo 	
		COMMIT TRAN;
	END		
	ELSE BEGIN
		ROLLBACK TRAN;
		SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo 
	END
END
END TRY
BEGIN CATCH
     ROLLBACK TRAN;
	 SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo 
END CATCH