﻿-- =============================================
-- Autor:				rudi.garcia
-- Fecha de Creacion: 	01-09-2016 @ Sprint θ
-- Description:			Elimina las frecuencia y clientes de la ruta


/*
-- Ejemplo de Ejecucion:
          EXEC [DIPROCOM].SWIFT_SP_DELETE_FREQUENCY_BY_ROUTE
            @CODDE_ROUTE = '3102'        	  
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].SWIFT_SP_DELETE_FREQUENCY_BY_ROUTE
	@CODDE_ROUTE INT
AS
	SET NOCOUNT ON;
	--
  -- ------------------------------------------------------------
	-- Eliminamos los clientes asociado
	-- ------------------------------------------------------------	
  DELETE FC
  FROM [DIPROCOM].SWIFT_FREQUENCY_X_CUSTOMER AS FC
  INNER JOIN [DIPROCOM].SWIFT_FREQUENCY AS F ON(
    FC.ID_FREQUENCY = F.ID_FREQUENCY
  )
  WHERE F.CODE_ROUTE = CONVERT(VARCHAR,  @CODDE_ROUTE)
  
  -- ------------------------------------------------------------
	-- Eliminamos las frecuencia
	-- ------------------------------------------------------------	
  DELETE [DIPROCOM].SWIFT_FREQUENCY 
  WHERE CODE_ROUTE = CONVERT(VARCHAR,  @CODDE_ROUTE)
