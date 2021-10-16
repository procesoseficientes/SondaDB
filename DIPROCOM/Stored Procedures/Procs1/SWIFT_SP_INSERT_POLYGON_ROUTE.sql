﻿CREATE PROC [DIPROCOM].[SWIFT_SP_INSERT_POLYGON_ROUTE]
@POSITION INT,
@CODE_ROUTE VARCHAR(50),
@LATITUDE decimal(19,6),
@LONGITUDE decimal(19,6)
AS
BEGIN TRY
INSERT INTO [DIPROCOM].[SWIFT_POLYGON_X_ROUTE]
           ([POSITION]
		   ,[CODE_ROUTE]
           ,[LATITUDE]
           ,[LONGITUDE])
     VALUES
           (@POSITION
		   ,@CODE_ROUTE
           ,@LATITUDE
           ,@LONGITUDE)
END TRY
BEGIN CATCH
     ROLLBACK TRAN t1
	 SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo 
END CATCH



