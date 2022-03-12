﻿-- =============================================
-- Autor:				rodrigo.gomez
-- Fecha de Creacion: 	7/27/2017 @ Sprint Bearbeitung
-- Description:			Obtiene los registros de la tabla [SWIFT_HISTORY_BY_PROMO]

/*
-- Ejemplo de Ejecucion:
				EXEC [SONDA].[SONDA_SP_GET_HISTORY_BY_PROMO_FOR_ROUTE]
					@CODE_ROUTE = '136'
*/
-- =============================================
CREATE PROCEDURE [SONDA].[SONDA_SP_GET_HISTORY_BY_PROMO_FOR_ROUTE] (@CODE_ROUTE VARCHAR(50)) WITH RECOMPILE
AS
BEGIN
  SET NOCOUNT ON;
  --

 DECLARE @CUSTOMER TABLE (
  [CODE_CUSTOMER] VARCHAR(50)
  UNIQUE ([CODE_CUSTOMER])
);

  INSERT INTO @CUSTOMER
  SELECT DISTINCT
    [RELATED_CLIENT_CODE]
  FROM [SONDA].[SONDA_ROUTE_PLAN]
  WHERE [CODE_ROUTE] = @CODE_ROUTE
  UNION
  SELECT DISTINCT
    [svac].[CODE_CUSTOMER]
  FROM [SONDA].[SWIFT_VIEW_ALL_COSTUMER] svac
  INNER JOIN [SONDA].[USERS] us
    ON svac.[SELLER_DEFAULT_CODE] = us.[RELATED_SELLER]
  WHERE us.[SELLER_ROUTE] = @CODE_ROUTE

  SELECT
    [HP].[DOC_SERIE]
   ,[HP].[DOC_NUM]
   ,[HP].[CODE_ROUTE]
   ,[HP].[CODE_CUSTOMER]
   ,[HP].[HISTORY_DATETIME]
   ,[HP].[PROMO_ID]
   ,[HP].[PROMO_NAME]
   ,[HP].[FREQUENCY]
   ,[HP].[IS_POSTED]
  FROM [SONDA].[SWIFT_HISTORY_BY_PROMO] [HP]
  INNER JOIN @CUSTOMER [C]
    ON ([C].[CODE_CUSTOMER] = [HP].[CODE_CUSTOMER])
  WHERE [HP].[LAST_APPLIED] = 1


END