﻿CREATE PROCEDURE [PACASA].[SWIFT_SP_INSERT_FREQUENCY]	
  @CODE_FRECUENCY AS VARCHAR(50),
    @SUNDAY AS INT,
    @MONDAY AS INT,
    @TUESDAY AS INT,
    @WEDNESDAY AS INT,
    @THURSDAY AS INT,
	@FRIDAY AS INT,
    @SATURDAY AS INT,
    @FRECUENCY_WEEKS AS INT,
    @LAST_WEEK_VISITED AS DATE,    
    @LAST_UPDATED_BY AS NVARCHAR(25),
    @CODE_ROUTE AS VARCHAR(50),
    @TYPE_TASK AS VARCHAR(20)	


AS
BEGIN TRY
IF EXISTS(SELECT 1 FROM [PACASA].[SWIFT_FREQUENCY] WHERE CODE_FREQUENCY = @CODE_FRECUENCY)BEGIN
	SELECT  -1 as Resultado , 'La Frecuencia Ya Existe' Mensaje ,  0 Codigo
END


DECLARE @ID NUMERIC(18, 0)
		
		SELECT @LAST_WEEK_VISITED = 
		CASE 
			WHEN @FRECUENCY_WEEKS = 1 THEN
				CAST(DATEADD(DAY,1-DATEPART(WEEKDAY,GETDATE()),GETDATE()) AS DATE)
			ELSE
				@LAST_WEEK_VISITED
		END;
			
			 INSERT INTO [PACASA].SWIFT_FREQUENCY
			  (			   
			   [CODE_FREQUENCY]
			  , [SUNDAY]
			  , [MONDAY]
			  , [TUESDAY]
			  , [WEDNESDAY]
			  , [THURSDAY]
			  , [FRIDAY]
			  , [SATURDAY]
			  , [FREQUENCY_WEEKS]
			  , [LAST_WEEK_VISITED]
			  , [LAST_UPDATED]
			  , [LAST_UPDATED_BY]
			  , [CODE_ROUTE]
			  , [TYPE_TASK]
			  ) 
			  VALUES 
			  (		  
			   @CODE_FRECUENCY
			  , @SUNDAY
			  , @MONDAY
			  , @TUESDAY
			  , @WEDNESDAY
			  , @THURSDAY
			  , @FRIDAY
			  , @SATURDAY
			  , @FRECUENCY_WEEKS
			  , @LAST_WEEK_VISITED
			  , GETDATE()
			  , @LAST_UPDATED_BY
			  , @CODE_ROUTE
			  , @TYPE_TASK
			  )
	SET @ID = SCOPE_IDENTITY();	
	exec [PACASA].[SONDA_SP_GENERATE_ROUTE_PLAN] @CODE_FREQUENCY_NEW = @CODE_FRECUENCY
	IF @@error = 0 BEGIN		
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo, CONVERT(VARCHAR(50),@ID) DbData
	END		
	ELSE BEGIN
		
		SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo
	END

END TRY
BEGIN CATCH     
	 SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo 
END CATCH


