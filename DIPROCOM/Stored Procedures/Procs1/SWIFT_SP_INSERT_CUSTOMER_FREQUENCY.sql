﻿CREATE PROCEDURE [SONDA].[SWIFT_SP_INSERT_CUSTOMER_FREQUENCY] (
   @CODE_CUSTOMER VARCHAR(50)
   ,@SUNDAY VARCHAR(10)
   ,@MONDAY VARCHAR(10)
   ,@TUESDAY VARCHAR(10)
   ,@WEDNESDAY VARCHAR(10)
   ,@THURSDAY VARCHAR(10)
   ,@FRIDAY VARCHAR(10)
   ,@SATURDAY VARCHAR(10)
   ,@FREQUENCY_WEEKS VARCHAR(10)
   ,@LAST_DATE_VISITED DATE
   ,@LAST_UPDATED_BY VARCHAR(25)
)
AS
  SET NOCOUNT ON;

  BEGIN TRY
       
    DECLARE @ID INT

    INSERT INTO [SONDA].SWIFT_CUSTOMER_FREQUENCY(
      CODE_CUSTOMER
      ,SUNDAY
      ,MONDAY
      ,TUESDAY
      ,WEDNESDAY
      ,THURSDAY
      ,FRIDAY
      ,SATURDAY
      ,FREQUENCY_WEEKS
      ,LAST_DATE_VISITED
      ,LAST_UPDATED_BY
      ,LAST_UPDATED
    )
    VALUES(
      @CODE_CUSTOMER
      ,@SUNDAY
      ,@MONDAY
      ,@TUESDAY
      ,@WEDNESDAY
      ,@THURSDAY
      ,@FRIDAY
      ,@SATURDAY
      ,@FREQUENCY_WEEKS
      ,@LAST_DATE_VISITED
      ,@LAST_UPDATED_BY
      ,GETDATE()
    )     

    SET @ID = SCOPE_IDENTITY()

    IF @@error = 0
    BEGIN
      SELECT 1 AS Resultado, 'Proceso Exitoso' Mensaje, 0 CODIGO, CONVERT(VARCHAR(16), @ID)  AS DbData

    END
    ELSE
    BEGIN
      SELECT -1 AS Resultado, ERROR_MESSAGE() Mensaje, @@ERROR Codigo
    END
  END TRY
  BEGIN CATCH
    SELECT -1 AS Resultado, ERROR_MESSAGE() Mensaje, @@ERROR Codigo
  END CATCH



