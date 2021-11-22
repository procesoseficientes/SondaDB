﻿CREATE PROCEDURE [PACASA].SWIFT_GET_PICKING

AS

  DECLARE @PICKING_CLOSED_STATUS VARCHAR(50)
  --
  SELECT @PICKING_CLOSED_STATUS = P.VALUE
  FROM [PACASA].SWIFT_PARAMETER P
  WHERE P.GROUP_ID = 'PICKING'
  AND P.PARAMETER_ID = 'CLOSED_STATUS'

  SELECT 
  	P.PICKING_HEADER
  	,P.CODE_CLIENT
  	,B.NAME_CUSTOMER
  	,P.REFERENCE
  	,P.DOC_SAP_RECEPTION
  	,ISNULL(P.FF,0) AS FF
  	,P.FF_STATUS
  	,'Picking' AS [TYPE]
    ,B.ADRESS_CUSTOMER
    ,ISNULL(VR.CODE_ROUTE, 'No tiene una ruta') AS CODE_ROUTE
    ,ISNULL(VR.NAME_ROUTE, 'No tiene una ruta') AS NAME_ROUTE  
  FROM [PACASA].SWIFT_PICKING_HEADER P
  LEFT JOIN [PACASA].SWIFT_VIEW_ALL_COSTUMER B ON (P.CODE_CLIENT = B.CODE_CUSTOMER)
  --LEFT JOIN [PACASA].SWIFT_FREQUENCY_X_CUSTOMER FC ON (P.CODE_CLIENT = FC.CODE_CUSTOMER)
  LEFT JOIN [PACASA].SWIFT_VIEW_ALL_SELLERS VS ON (P.CODE_SELLER = VS.SELLER_CODE)
  LEFT JOIN [PACASA].SWIFT_VIEW_ALL_ROUTE VR ON (VR.CODE_ROUTE = P.CODE_ROUTE)
  LEFT JOIN [PACASA].SWIFT_MANIFEST_DETAIL MD ON (P.PICKING_HEADER = MD.CODE_PICKING)
  WHERE
	MD.CODE_PICKING IS NULL
  	AND P.STATUS = @PICKING_CLOSED_STATUS
  	AND P.FF_STATUS = @PICKING_CLOSED_STATUS


--UNION ALL
----AQUI DEBERIA PONERSE LAS FACTURAS
--SELECT 
--	A.DocNum AS PICKING_HEADER
--	,A.CardCode COLLATE DATABASE_DEFAULT AS CODE_CLIENT
--	,A.CardName COLLATE DATABASE_DEFAULT AS NAME_CUSTOMER
--	,A.DocEntry AS REFERENCE
--	,A.DocEntry AS DOC_SAP_RECEPTION
--	,0 AS FF
--	,NULL AS FF_STATUS
--	,'Factura' AS [TYPE]
--FROM [SWIFT_INTERFACES].[PACASA].ERP_VIEW_INVOICE_HEADER A
--WHERE 
--A.DocStatus = 'O'
--	PICKING_HEADER NOT IN(SELECT CODE_PICKING FROM [PACASA].SWIFT_MANIFEST_DETAIL)
--	AND A.STATUS = 'CLOSED'  
--	AND A.FF_STATUS = 'CLOSED'




	--AND (FF_STATUS IS NULL OR A.FF_STATUS = 'CLOSED')

--AND (A.FF IS NULL OR A.FF = 0)
