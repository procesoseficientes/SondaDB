﻿CREATE PROCEDURE [SONDA].[SWIFT_GET_ALL_TASKS_TODAY]
AS
SELECT A.TASK_ID AS TASK_ID,
A.CREATED_STAMP AS FECHA, 
CASE 
            WHEN A.TASK_TYPE = 'RECEPTION' 
               THEN A.RECEPTION_NUMBER
            WHEN A.TASK_TYPE = 'PICKING' 
               THEN A.PICKING_NUMBER
			WHEN A.TASK_TYPE = 'COUNT' 
               THEN A.COUNT_ID
END AS 'Numero',
CASE 
            WHEN A.TASK_TYPE = 'RECEPTION' 
               THEN 'Recepción'
            WHEN A.TASK_TYPE = 'PICKING' 
               THEN 'Picking'
			WHEN A.TASK_TYPE = 'COUNT' 
               THEN 'Conteo'
END AS DESCRIPCION
,CASE 
           WHEN A.TASK_TYPE = 'RECEPTION' 
               THEN (SELECT B.REFERENCE WHERE A.RECEPTION_NUMBER = B.RECEPTION_HEADER) 
            WHEN A.TASK_TYPE = 'PICKING' 
               THEN (SELECT C.DOC_SAP_RECEPTION WHERE A.PICKING_NUMBER = C.PICKING_HEADER) 
			WHEN A.TASK_TYPE = 'COUNT' 
               THEN 'N/A' 
	END AS REFERENCIA,
CASE 
            WHEN A.TASK_TYPE = 'RECEPTION' 
               THEN A.RELATED_PROVIDER_NAME
            WHEN A.TASK_TYPE = 'PICKING' 
               THEN A.COSTUMER_NAME
			WHEN A.TASK_TYPE = 'COUNT' 
               THEN 'Nombre Conteo: ' + (SELECT F.COUNT_NAME WHERE F.COUNT_ID = A.COUNT_ID)
END AS CLPR,
CASE 
            WHEN A.TASK_TYPE = 'RECEPTION' 
               THEN (SELECT D.CODE_SKU WHERE A.RECEPTION_NUMBER = D.RECEPTION_HEADER) 
            WHEN A.TASK_TYPE = 'PICKING' 
               THEN (SELECT E.CODE_SKU WHERE  A.PICKING_NUMBER = E.PICKING_HEADER) 
			WHEN A.TASK_TYPE = 'COUNT'
				THEN (SELECT G.COUNT_SKU WHERE G.COUNT_ID = A.COUNT_ID)
				--THEN(CASE
				--	WHEN (SELECT F.COUNT_TYPE WHERE  A.COUNT_ID = F.COUNT_ID) = 'SKU' 
				--		THEN (SELECT G.COUNT_SKU WHERE  A.COUNT_ID = G.COUNT_ID) 
				--	WHEN (SELECT F.COUNT_TYPE WHERE  A.COUNT_ID = F.COUNT_ID) = 'LOCATION' 
				--		THEN 'Ubicación: ' + (SELECT G.LOCATION WHERE  A.COUNT_ID = G.COUNT_ID) 
				--END)
END AS CODIGO_SKU,
CASE 
            WHEN A.TASK_TYPE = 'RECEPTION' 
               THEN (SELECT D.DESCRIPTION_SKU WHERE A.RECEPTION_NUMBER = D.RECEPTION_HEADER) 
            WHEN A.TASK_TYPE = 'PICKING' 
               THEN (SELECT E.DESCRIPTION_SKU WHERE  A.PICKING_NUMBER = E.PICKING_HEADER) 
			WHEN A.TASK_TYPE = 'COUNT'
				THEN (SELECT G.COUNT_SKU_DESCRIPTION WHERE G.COUNT_ID = A.COUNT_ID)
END AS DESCRIPCION_SKU,
CASE 
            WHEN A.TASK_TYPE = 'RECEPTION' 
               THEN (SELECT D.EXPECTED WHERE A.RECEPTION_NUMBER = D.RECEPTION_HEADER) 
            WHEN A.TASK_TYPE = 'PICKING' 
               THEN (SELECT E.DISPATCH WHERE  A.PICKING_NUMBER = E.PICKING_HEADER) 
			WHEN A.TASK_TYPE = 'COUNT'
				THEN (SELECT G.COUNT_SKU_ONHAND WHERE G.COUNT_ID = A.COUNT_ID)
END AS CANTIDAD,
CASE 
            WHEN A.TASK_TYPE = 'RECEPTION' 
               THEN (SELECT D.SCANNED WHERE A.RECEPTION_NUMBER = D.RECEPTION_HEADER) 
            WHEN A.TASK_TYPE = 'PICKING' 
               THEN (SELECT E.SCANNED WHERE  A.PICKING_NUMBER = E.PICKING_HEADER) 
			WHEN A.TASK_TYPE = 'COUNT'
				THEN (SELECT G.COUNT_SKU_COUNTED WHERE G.COUNT_ID = A.COUNT_ID)
END AS ESCANEADO,
CASE 
            WHEN A.TASK_TYPE = 'RECEPTION' 
               THEN (SELECT B.STATUS WHERE A.RECEPTION_NUMBER = B.RECEPTION_HEADER) 
            WHEN A.TASK_TYPE = 'PICKING' 
               THEN (SELECT C.STATUS WHERE  A.PICKING_NUMBER = C.PICKING_HEADER) 
			WHEN A.TASK_TYPE = 'COUNT'
				THEN (SELECT F.COUNT_STATUS WHERE F.COUNT_ID = A.COUNT_ID)
END AS ESTATUS,
A.ACTION,
A.ASSIGEND_TO AS OPERADOR
,A.[COMPLETED_STAMP]
FROM [SONDA].SWIFT_TASKS AS A

--,[SONDA].SWIFT_RECEPTION_HEADER AS B,[SONDA].SWIFT_PICKING_HEADER AS C,[SONDA].SWIFT_RECEPTION_DETAIL AS D,[SONDA].SWIFT_PICKING_DETAIL AS E

LEFT OUTER JOIN
[SONDA].SWIFT_RECEPTION_HEADER AS B ON A.RECEPTION_NUMBER = B.RECEPTION_HEADER 
LEFT OUTER JOIN
[SONDA].SWIFT_PICKING_HEADER AS C ON A.PICKING_NUMBER = C.PICKING_HEADER
LEFT OUTER JOIN
[SONDA].SWIFT_RECEPTION_DETAIL AS D ON A.RECEPTION_NUMBER = D.RECEPTION_HEADER
LEFT OUTER JOIN
[SONDA].SWIFT_PICKING_DETAIL AS E ON A.PICKING_NUMBER = E.PICKING_HEADER
LEFT OUTER JOIN
[SONDA].[SWIFT_CYCLE_COUNT_HEADER] AS F ON A.COUNT_ID = F.COUNT_ID
LEFT OUTER JOIN
[SONDA].[SWIFT_CYCLE_COUNT_DETAIL] AS G ON A.COUNT_ID = G.COUNT_ID
WHERE A.TASK_TYPE != 'SALE'
AND A.TASK_TYPE != 'PRESALE'
AND A.TASK_TYPE != 'DELIVERY'