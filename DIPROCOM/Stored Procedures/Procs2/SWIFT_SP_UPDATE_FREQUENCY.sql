﻿
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_UPDATE_FREQUENCY]
    @ID_FREQUENCY AS INT,
    @CODE_FREQUENCY AS VARCHAR(50),
    @SUNDAY AS INT,
    @MONDAY AS INT,
    @TUESDAY AS INT,
    @WEDNESDAY AS INT,
    @THURSDAY AS INT,
	@FRIDAY AS INT,
    @SATURDAY AS INT,
    @FREQUENCY_WEEKS AS INT,
    @LAST_WEEK_VISITED AS DATE,    
    @LAST_UPDATED_BY AS VARCHAR(25),
    @CODE_ROUTE AS VARCHAR(50),
    @TYPE_TASK AS VARCHAR(20)
AS
BEGIN TRY
DECLARE @CODE_FREQUENCY_OLD VARCHAR(50)

SELECT @CODE_FREQUENCY_OLD = CODE_FREQUENCY FROM DIPROCOM.SWIFT_FREQUENCY WHERE ID_FREQUENCY= @ID_FREQUENCY		

	Update DIPROCOM.SWIFT_FREQUENCY Set 	
	  CODE_FREQUENCY= @CODE_FREQUENCY
	 , SUNDAY=@SUNDAY
	 , MONDAY=@MONDAY
	 , TUESDAY=@TUESDAY
	 , WEDNESDAY=@WEDNESDAY
	 , FRIDAY = @FRIDAY
	 , THURSDAY=@THURSDAY
	 , SATURDAY=@SATURDAY
	 , FREQUENCY_WEEKS=@FREQUENCY_WEEKS
	 , LAST_WEEK_VISITED=@LAST_WEEK_VISITED
	 , LAST_UPDATED=GETDATE()
	 , LAST_UPDATED_BY=@LAST_UPDATED_BY
	 , CODE_ROUTE=@CODE_ROUTE
	 , TYPE_TASK=@TYPE_TASK 
    WHERE ID_FREQUENCY= @ID_FREQUENCY
     
	EXEC [DIPROCOM].[SONDA_SP_GENERATE_ROUTE_PLAN] @CODE_FREQUENCY_OLD, @CODE_FREQUENCY
	IF @@error = 0 BEGIN
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo, '0' DbData
	END		
	ELSE BEGIN
		
		SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo
	END

END TRY
BEGIN CATCH     
	 SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo 
END CATCH



