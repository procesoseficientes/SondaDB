﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	04-04-2016
-- Description:			Crea encabezado del picking

--Modificacion 19/04/2016 
--rudi.garcia
--Se agregaron los campos CODE_SELLER y CODE_ROUTE

--Modificacion 01/09/2016 
--pablo.aguilar
--Se corrigio el result de errores para que devuelva un dbdata vacio. 

-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_INSERT_PICKING_HEADER] @CLASSIFICATION_PICKING INT
, @CODE_CLIENT VARCHAR(50)
, @CODE_USER VARCHAR(50)
, @REFERENCE VARCHAR(50)
, @DOC_SAP_RECEPTION VARCHAR(150)
, @STATUS VARCHAR(50)
, @LAST_UPDATE_BY VARCHAR(50)
, @COMMENTS VARCHAR(1000) = ''
, @SCHEDULE_FOR DATE
, @SEQ INT
, @FF VARCHAR(1) = NULL
, @FF_STATUS VARCHAR(20) = NULL
, @CODE_WAREHOUSE_SOURCE VARCHAR(50)
, @SOURCE_DOC_TYPE VARCHAR(15) = NULL
, @SOURCE_DOC INT = NULL
, @TARGET_DOC INT = NULL
, @CODE_SELLER VARCHAR(50) = NULL
, @CODE_ROUTE VARCHAR(50) = NULL
AS
BEGIN TRY
  DECLARE @ID INT
  --
  INSERT INTO [DIPROCOM].[SWIFT_PICKING_HEADER] (CLASSIFICATION_PICKING
  , CODE_CLIENT
  , CODE_USER
  , REFERENCE
  , DOC_SAP_RECEPTION
  , [STATUS]
  , LAST_UPDATE
  , LAST_UPDATE_BY
  , COMMENTS
  , SCHEDULE_FOR
  , SEQ
  , FF
  , FF_STATUS
  , IS_POSTED_ERP
  , CODE_WAREHOUSE_SOURCE
  , SOURCE_DOC_TYPE
  , SOURCE_DOC
  , CODE_SELLER
  , CODE_ROUTE)
    VALUES (@CLASSIFICATION_PICKING, @CODE_CLIENT, @CODE_USER, @REFERENCE, @DOC_SAP_RECEPTION, @STATUS, GETDATE(), @LAST_UPDATE_BY, @COMMENTS, @SCHEDULE_FOR, @SEQ, @FF, @FF_STATUS, 0, @CODE_WAREHOUSE_SOURCE, @SOURCE_DOC_TYPE, @SOURCE_DOC, @CODE_SELLER, @CODE_ROUTE)
  --	   
  SELECT
    @ID = SCOPE_IDENTITY()

  IF @@error = 0
  BEGIN
    SELECT
      1 AS Resultado
     ,'Proceso Exitoso' Mensaje
     ,0 Codigo
     ,CONVERT(VARCHAR(16), @ID) DbData
  END
  ELSE
  BEGIN
    SELECT
      -1 AS Resultado
     ,ERROR_MESSAGE() Mensaje
     ,@@ERROR Codigo
     ,CONVERT(VARCHAR(16), '0') DbData
  END
END TRY
BEGIN CATCH
  SELECT
    -1 AS Resultado
   ,ERROR_MESSAGE() Mensaje
   ,@@ERROR Codigo
   ,CONVERT(VARCHAR(16), '0') DbData
END CATCH