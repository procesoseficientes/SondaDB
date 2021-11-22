-- =============================================
-- Author:         diego.as
-- Create date:    10-02-2016
-- Description:    Actualiza el campo STATUS_DOC de la tabla 
--				   [PACASA].SONDA_DOC_ROUTE_RETURN_HEADER
--				   recibiendo como parametro el Identity de la fila a actualizar 

/*
Ejemplo de Ejecucion:
	
	DECLARE @ID_HEADER INT = 1
			,@STATE VARCHAR(20) = 'PENDING'

					EXEC [PACASA].[SONDA_SP_INSERT_RETURN_RECEPTION_HEADER] 
					@IDENTITY_HEADER = @ID_HEADER
					,@STATUS = @STATE

					SELECT * FROM [PACASA].[SONDA_DOC_ROUTE_RETURN_HEADER]
		
				
*/
-- =============================================


CREATE PROCEDURE [PACASA].[SONDA_SP_UPDATE_STATUS_ROUTE_RETURN]
     @IDENTITY_HEADER AS INT
	,@STATUS AS VARCHAR(20)
		
AS
BEGIN 

	SET NOCOUNT ON;

	UPDATE [PACASA].[SONDA_DOC_ROUTE_RETURN_HEADER]
	   SET [STATUS_DOC] = @STATUS
	 WHERE [ID_DOC_RETURN_HEADER] = @IDENTITY_HEADER

END
