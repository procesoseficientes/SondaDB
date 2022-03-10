-- =============================================
-- Autor:				rudi.garcia
-- Fecha de Creacion: 18-08-2016
-- Description:			SP que importa los descuentos

/*
-- Ejemplo de Ejecucion:
				-- 
				EXEC SWIFT_INTERFACES.[DIPROCOM].[BULK_DATA_SP_IMPORT_DISCOUNT]

*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[BULK_DATA_SP_IMPORT_DISCOUNT]
AS
BEGIN
  SET NOCOUNT ON;

   -- ------------------------------------------------------------------------------------
   -- Limpia las Tablas de acuerdos comerciales para realizar la nueva inserción.
   -- ------------------------------------------------------------------------------------  
  TRUNCATE TABLE SWIFT_EXPRESS.[DIPROCOM].SWIFT_TRADE_AGREEMENT_DISCOUNT
  TRUNCATE TABLE SWIFT_EXPRESS.[DIPROCOM].SWIFT_TRADE_AGREEMENT_BY_CUSTOMER  
  DELETE SWIFT_EXPRESS.[DIPROCOM].SWIFT_TRADE_AGREEMENT
  
  -- ------------------------------------------------------------------------------------
  -- Obtiene las listas descuento 
  -- ------------------------------------------------------------------------------------
  INSERT INTO SWIFT_EXPRESS.[DIPROCOM].SWIFT_TRADE_AGREEMENT(
    CODE_TRADE_AGREEMENT
	,NAME_TRADE_AGREEMENT
	,DESCRIPTION_TRADE_AGREEMENT
	,VALID_START_DATETIME
	,VALID_END_DATETIME
	,[STATUS]
	,LAST_UPDATE
	,LAST_UPDATE_BY
	,LINKED_TO
  )
  SELECT
	R.CODE_ROUTE + '|' + C.CODE_CUSTOMER AS CODE_TRADE_AGREEMENT
	,R.CODE_ROUTE + '|' + C.CODE_CUSTOMER AS NAME_TRADE_AGREEMENT
	,R.CODE_ROUTE + '|' + C.CODE_CUSTOMER AS DESCRIPTION_TRADE_AGREEMENT
	,DATEADD(DAY,-1,CONVERT(DATE,GETDATE())) AS VALID_START_DATETIME
	,DATEADD(YEAR,1,CONVERT(DATE,GETDATE())) AS VALID_END_DATETIME
	,1 [STATUS]
	,GETDATE() LAST_UPDATE
	,'BULK_DATA' LAST_UPDATE_BY
	,'CUSTOMER' LINKED_TO
  FROM SWIFT_INTERFACES_ONLINE.[DIPROCOM].ERP_VIEW_ROUTE R
  INNER JOIN SWIFT_INTERFACES_ONLINE.[DIPROCOM].ERP_VIEW_COSTUMER C ON (
	R.CODE_ROUTE = C.CODE_ROUTE
  )
   
   
  -- ------------------------------------------------------------------------------------
  -- Obtiene los clientes para la lista descuento
  -- ------------------------------------------------------------------------------------
  INSERT INTO SWIFT_EXPRESS.[DIPROCOM].SWIFT_TRADE_AGREEMENT_BY_CUSTOMER(
    TRADE_AGREEMENT_ID
	,CODE_CUSTOMER
  )
  SELECT
    TA.TRADE_AGREEMENT_ID
    ,C.CODE_CUSTOMER
  FROM SWIFT_INTERFACES_ONLINE.[DIPROCOM].ERP_VIEW_ROUTE R
  INNER JOIN SWIFT_INTERFACES_ONLINE.[DIPROCOM].ERP_VIEW_COSTUMER C ON (
	R.CODE_ROUTE = C.CODE_ROUTE
	)
  INNER JOIN SWIFT_EXPRESS.[DIPROCOM].SWIFT_TRADE_AGREEMENT TA ON (
    TA.CODE_TRADE_AGREEMENT = (R.CODE_ROUTE + '|' + C.CODE_CUSTOMER)
  )

  -- ------------------------------------------------------------------------------------
  -- Obtiene los sku para la lista descuento
  -- ------------------------------------------------------------------------------------
  
  --
  INSERT INTO SWIFT_EXPRESS.[DIPROCOM].SWIFT_TRADE_AGREEMENT_DISCOUNT(
    TRADE_AGREEMENT_ID
	,CODE_SKU
	,DISCOUNT
  )
  SELECT     
    TA.TRADE_AGREEMENT_ID
    ,DLS.SKU
    ,DLS.DISCOUNT
  FROM SWIFT_INTERFACES_ONLINE.[DIPROCOM].ERP_VIEW_DISCOUNT DLS  
  INNER JOIN SWIFT_EXPRESS.[DIPROCOM].SWIFT_TRADE_AGREEMENT TA ON (
    TA.CODE_TRADE_AGREEMENT = (DLS.CODE_ROUTE + '|' + DLS.CODE_CUSTOMER)
  )

END