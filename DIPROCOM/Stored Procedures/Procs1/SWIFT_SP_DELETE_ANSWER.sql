﻿-- =============================================
-- Autor:				      rudi.garcia
-- Fecha de Creacion: 02-Oct-2018 G-Force@Koala
-- Description:			  SP que borra la respuesta

CREATE PROCEDURE [PACASA].[SWIFT_SP_DELETE_ANSWER] (@ANSWER_ID INT)
AS
BEGIN TRY

  DELETE [PACASA].[SWIFT_ANSWER]
  WHERE [ANSWER_ID] = @ANSWER_ID

  SELECT
    1 AS Resultado
   ,'Proceso Exitoso' Mensaje
   ,0 Codigo
   ,CAST(@ANSWER_ID AS VARCHAR) DbData

END TRY
BEGIN CATCH
  SELECT
    -1 AS Resultado
   ,ERROR_MESSAGE() Mensaje
   ,@@ERROR Codigo
END CATCH