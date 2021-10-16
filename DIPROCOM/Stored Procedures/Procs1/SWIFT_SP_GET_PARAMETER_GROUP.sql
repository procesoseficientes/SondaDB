﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	04-05-2016
-- Description:			Obtiene la parametrizacion 

/*
Ejemplo de Ejecucion:
          EXEC [DIPROCOM].[SWIFT_SP_GET_PARAMETER_GROUP]
			@GROUP_ID = 'CALCULATION_RULES'
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_PARAMETER_GROUP]
	@GROUP_ID VARCHAR(250)
AS
BEGIN
  SET NOCOUNT ON;
  --
  SELECT
	P.[IDENTITY]
	,P.GROUP_ID
	,P.PARAMETER_ID
	,P.VALUE
  FROM DIPROCOM.SWIFT_PARAMETER P
  WHERE P.GROUP_ID = @GROUP_ID
END


