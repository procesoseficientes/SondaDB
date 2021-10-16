﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	31-08-2016
-- Description:			SP que coloca la prioridad en una frecuencia

-- Modificacion:				hector.gonzalez
-- Fecha de Creacion: 	05-09-2016
-- Description:			    Se agrego UPDATE a SWIFT_CUSTOMER_FREQUENCY 


/*
-- Ejemplo de Ejecucion:
				-- 
				EXEC [DIPROCOM].[SWIFT_SP_SET_CUSTOMER_PRIORITY_IN_FREQUENCY]
					@ID_FREQUENCY = 3069
					,@CODE_CUSTOMER = 'BO-2082'
					,@PRIORITY = 20
          ,@DISTANCE = 12
				--
				SELECT * FROM [DIPROCOM].SWIFT_FREQUENCY_X_CUSTOMER WHERE ID_FREQUENCY = 3069 AND CODE_CUSTOMER = 'BO-2082'
        SELECT * FROM [DIPROCOM].SWIFT_CUSTOMER_FREQUENCY WHERE CODE_CUSTOMER = 'BO-2082'
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_SET_CUSTOMER_PRIORITY_IN_FREQUENCY] (
	@ID_FREQUENCY INT
	,@CODE_CUSTOMER VARCHAR(50)
	,@PRIORITY INT
  ,@DISTANCE FLOAT
)
AS
BEGIN
	
  UPDATE [DIPROCOM].SWIFT_FREQUENCY_X_CUSTOMER
	SET [PRIORITY] = @PRIORITY
	WHERE ID_FREQUENCY = @ID_FREQUENCY
		AND CODE_CUSTOMER = @CODE_CUSTOMER

  UPDATE [DIPROCOM].SWIFT_CUSTOMER_FREQUENCY
	SET DISTANCE = @DISTANCE, 
    LAST_OPTIMIZATION= GETDATE()
	WHERE CODE_CUSTOMER = @CODE_CUSTOMER

END