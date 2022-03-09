
CREATE VIEW [DIPROCOM].[ERP_ORDER_DETAIL]
as 
select *from openquery (MDASERVER,'SELECT
  "so"."DocEntry" as "DOC_ENTRY",
  "so"."ItemCode" as "ITEM_CODE",
  "so"."ObjType" AS "OBJ_TYPE",
  "so"."LineNum" AS "LINE_NUM"
FROM  "SBO_MDA_PRUEBAS"."RDR1" AS "so" ')