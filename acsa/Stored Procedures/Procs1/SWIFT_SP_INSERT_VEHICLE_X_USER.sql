﻿CREATE PROCEDURE [acsa].[SWIFT_SP_INSERT_VEHICLE_X_USER]
(
   @CODE_VEHICLE VARCHAR(50)  
  ,@LOGIN VARCHAR(50)  
)
  AS
    SET NOCOUNT ON;


BEGIN TRY
            DECLARE @VEHICLE INT ;
            SET @VEHICLE = ( SELECT  TOP(1) VEHICLE FROM [acsa].SWIFT_VEHICLES WHERE CODE_VEHICLE = @CODE_VEHICLE )
            
            INSERT INTO [acsa].SWIFT_VEHICLE_X_USER VALUES(@VEHICLE, @LOGIN)

  IF @@error = 0
  BEGIN
    SELECT
      1 AS Resultado
     ,'Proceso Exitoso' Mensaje
  END
  ELSE
  BEGIN
    SELECT
      -1 AS Resultado
     ,ERROR_MESSAGE() Mensaje
     ,@@ERROR Codigo
  END
END TRY
BEGIN CATCH
  SELECT
    -1 AS Resultado
   ,ERROR_MESSAGE() Mensaje
   ,@@ERROR Codigo
END CATCH


