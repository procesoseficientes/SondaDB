CREATE PROCEDURE [acsa].[SWIFT_SP_GET_ORDEN_COMPRA]
AS  
  Select *
  FROM [SWIFT_EXPRESS].[acsa].[SWIFT_ORDERS] as Ordenes
  order by (Ordenes.ORDER_ID)


