﻿-- =============================================
-- Autor:					        hector.gonzalez
-- Fecha de Creacion: 		21-Oct-16 @ A-Team Sprint 3
-- Description:			      Obtiene todos los manifiestos creados desde excel

/*
-- Ejemplo de Ejecucion:
        EXEC [acsa].SWIFT_GET_ALL_MANIFESTS_LOADED_FROM_EXCEL          
*/
-- =============================================

CREATE PROCEDURE [acsa].SWIFT_GET_ALL_MANIFESTS_LOADED_FROM_EXCEL
AS

  SELECT
    A.MANIFEST_HEADER
   ,A.CREATED_DATE
   ,B.NAME_DRIVER
   ,A.LAST_UPDATE_BY
   ,A.STATUS
  FROM [acsa].SWIFT_MANIFEST_HEADER A
  INNER JOIN [acsa].SWIFT_DRIVERS B
    ON A.CODE_DRIVER = B.CODE_DRIVER    
    AND A.MANIFEST_SOURCE = 'LOAD_DATA_EXCEL'
