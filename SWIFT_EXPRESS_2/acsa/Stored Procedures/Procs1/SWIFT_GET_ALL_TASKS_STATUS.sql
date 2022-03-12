﻿CREATE PROCEDURE [SONDA].[SWIFT_GET_ALL_TASKS_STATUS]
@DTBEGIN DATE,
@DTEND DATE
AS
SELECT 
	 A.TASK_ID
	,CASE
			WHEN A.TASK_TYPE = 'RECEPTION' 
               THEN 'Recepción'
            WHEN A.TASK_TYPE = 'PICKING' 
               THEN 'Picking'
		    WHEN A.TASK_TYPE = 'COUNT' 
               THEN 'Conteo'
	END AS TASK_TYPE
	,CASE 
           WHEN A.TASK_TYPE = 'RECEPTION' 
               THEN (SELECT B.REFERENCE WHERE A.RECEPTION_NUMBER = B.RECEPTION_HEADER) 
            WHEN A.TASK_TYPE = 'PICKING' 
               THEN (SELECT C.DOC_SAP_RECEPTION WHERE A.PICKING_NUMBER = C.PICKING_HEADER) 
			WHEN A.TASK_TYPE = 'COUNT' 
               THEN 'N/A' 
	END AS REFERENCE
	,CASE 
            WHEN A.TASK_TYPE = 'RECEPTION' 
               THEN A.RECEPTION_NUMBER
            WHEN A.TASK_TYPE = 'PICKING' 
               THEN A.PICKING_NUMBER
		    WHEN A.TASK_TYPE = 'COUNT' 
               THEN A.COUNT_ID
	END AS 'Numero'
	,CASE 
            WHEN A.TASK_TYPE = 'RECEPTION' 
               THEN A.RELATED_PROVIDER_NAME
            WHEN A.TASK_TYPE = 'PICKING' 
               THEN A.COSTUMER_NAME
			WHEN A.TASK_TYPE = 'COUNT' 
               THEN 'Nombre Conteo: ' + (SELECT D.COUNT_NAME WHERE D.COUNT_ID = A.COUNT_ID)
	END AS CLPR
	,CASE 
            WHEN A.TASK_TYPE = 'RECEPTION' 
               THEN (SELECT B.STATUS WHERE A.RECEPTION_NUMBER = B.RECEPTION_HEADER) 
            WHEN A.TASK_TYPE = 'PICKING' 
               THEN (SELECT C.STATUS WHERE  A.PICKING_NUMBER = C.PICKING_HEADER) 	
			WHEN A.TASK_TYPE = 'COUNT' 
               THEN (SELECT D.COUNT_STATUS WHERE D.COUNT_ID = A.COUNT_ID)		
	END AS ESTATUS,
	A.ACTION,
	A.ASSIGEND_TO AS OPERADOR 
FROM [SONDA].SWIFT_TASKS AS A
LEFT OUTER JOIN
[SONDA].SWIFT_RECEPTION_HEADER AS B ON A.RECEPTION_NUMBER = B.RECEPTION_HEADER 
LEFT OUTER JOIN
[SONDA].SWIFT_PICKING_HEADER AS C ON A.PICKING_NUMBER = C.PICKING_HEADER
LEFT OUTER JOIN
[SONDA].[SWIFT_CYCLE_COUNT_HEADER] AS D ON A.COUNT_ID = D.COUNT_ID

WHERE CONVERT(DATE,@DTBEGIN) >= CONVERT(DATE,A.TASK_DATE) 
AND CONVERT(DATE,@DTEND) <= CONVERT(DATE,A.TASK_DATE) 
--AND TASK_TYPE != 'COUNT'
--AND A.TASK_TYPE != 'PRESALE'
--AND A.TASK_TYPE != 'SALE'
--AND A.TASK_TYPE != 'DELIVERY'
AND A.TASK_TYPE not in ('PRESALE','SALE','DELIVERY')