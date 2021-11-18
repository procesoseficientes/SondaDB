﻿
CREATE PROCEDURE [acsa].[SWIFT_SP_INSERT_SWIFT_UPDATE]
  @SUITE VARCHAR(50)
  ,@SPRINT VARCHAR(10)
  ,@LAST_SCRIPT VARCHAR (150)
  ,@UPDATE_BY VARCHAR(50)
  ,@COMMENT VARCHAR(MAX)
AS 
BEGIN
INSERT INTO  [acsa].SWIFT_UPDATE (	
   SUITE 
  ,SPRINT 
  ,LAST_SCRIPT 
  ,UPDATE_BY 
  ,LAST_UPDATE 
  ,COMMENT 
  ) VALUES
  (
   @SUITE 
  ,@SPRINT 
  ,@LAST_SCRIPT 
  ,@UPDATE_BY 
  ,GETDATE()
  ,@COMMENT 
  )

END
