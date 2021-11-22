﻿-- =============================================
-- Autor:				      rudi.garcia
-- Fecha de Creacion: 02-Oct-2018 G-Force@Koala
-- Description:			  SP que inserta una encuesta

CREATE PROCEDURE [PACASA].[SWIFT_SP_INSERT_QUIZ] (@NAME_QUIZ VARCHAR(50)
, @VALID_START_DATETIME DATETIME
, @VALID_END_DATETIME DATETIME
, @ORDER INT
, @REQUIRED INT
, @QUIZ_START INT
, @LAST_UPDATE VARCHAR(50))
AS
BEGIN TRY

  DECLARE @ID INT

  INSERT INTO [PACASA].[SWIFT_QUIZ] ([NAME_QUIZ], [VALID_START_DATETIME], [VALID_END_DATETIME], [ORDER], [REQUIRED], [QUIZ_START], [LAST_UPDATE], [LAST_UPDATE_BY])
    VALUES (@NAME_QUIZ, @VALID_START_DATETIME, @VALID_END_DATETIME, @ORDER, @REQUIRED, @QUIZ_START, GETDATE(), @LAST_UPDATE);

  SET @ID = SCOPE_IDENTITY()

  SELECT
    1 AS Resultado
   ,'Proceso Exitoso' Mensaje
   ,0 Codigo
   ,CAST(@ID AS VARCHAR) DbData
END TRY
BEGIN CATCH
  SELECT
    -1 AS Resultado
   ,ERROR_MESSAGE() Mensaje
   ,@@ERROR Codigo
END CATCH