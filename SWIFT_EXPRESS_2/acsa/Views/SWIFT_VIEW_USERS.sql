﻿-- =============================================
-- Autor:				pedro.loukota
-- Fecha de Creacion: 	11-11-2015
-- Description:			Obtiene Bodegas de preventa

--Modificado 05-05-2016
-- alberto.ruiz
-- Se agrego el campo USE_PACK_UNIT

  --Modificado 15-DEC-2016
-- pablo.aguilar
-- Se agrego el campo ZONE_ID

/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [SONDA].[SWIFT_VIEW_USERS] 
*/
-- =============================================


CREATE VIEW [SONDA].[SWIFT_VIEW_USERS]
AS
SELECT
  A.[CORRELATIVE]
 ,A.[LOGIN]
 ,A.[NAME_USER]
 ,A.[TYPE_USER]
 ,A.[PASSWORD]
 ,A.[ENTERPRISE]
 ,A.[IMAGE]
 ,C.SELLER_NAME AS RELATED_SELLER
  --,A.[RELATED_SELLER]
 ,A.[SELLER_ROUTE]
  --,A.USER_ROLE
 ,B.[VALUE_TEXT_CLASSIFICATION] AS USER_TYPE
 ,E.NAME AS USER_ROLE
 ,D.DESCRIPTION_WAREHOUSE AS DEFAULT_WAREHOUSE
 ,F.DESCRIPTION_WAREHOUSE AS PRESALE_WAREHOUSE
 ,A.USE_PACK_UNIT
 ,[SZ].[CODE_ZONE] ZONE_ID
 ,CASE CAST(USE_PACK_UNIT AS VARCHAR)
    WHEN '1' THEN 'Si'
    ELSE 'No'
  END AS USE_PACK_UNIT_DESCRIPTION
 ,C.SELLER_CODE
 ,SR.CODE_ROUTE
 ,A.DEFAULT_WAREHOUSE CODE_DEFAULT_WAREHOUSE
FROM [SONDA].[USERS] A
LEFT OUTER JOIN [SONDA].[SWIFT_CLASSIFICATION] AS B
  ON A.[USER_TYPE] = B.NAME_CLASSIFICATION
LEFT OUTER JOIN [SONDA].[SWIFT_VIEW_ALL_SELLERS] AS C
  ON A.RELATED_SELLER = C.SELLER_CODE
LEFT OUTER JOIN [SONDA].[SWIFT_VIEW_WAREHOUSES] AS D
  ON A.DEFAULT_WAREHOUSE = D.CODE_WAREHOUSE
LEFT OUTER JOIN [SONDA].[SWIFT_VIEW_WAREHOUSES] AS F
  ON A.PRESALE_WAREHOUSE = F.CODE_WAREHOUSE
LEFT OUTER JOIN [SONDA].SWIFT_ROLE AS E
  ON A.USER_ROLE = E.ROLE_ID
LEFT JOIN [SONDA].SWIFT_ROUTES SR ON A.SELLER_ROUTE = SR.CODE_ROUTE
LEFT JOIN [SONDA].[SWIFT_ZONE] [SZ] ON [A].[ZONE_ID] = [SZ].[ZONE_ID]