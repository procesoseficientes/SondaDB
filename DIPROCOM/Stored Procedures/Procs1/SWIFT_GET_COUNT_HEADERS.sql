﻿CREATE PROCEDURE [acsa].[SWIFT_GET_COUNT_HEADERS]
@DTBEGIN DATE,
@DTEND DATE
AS
SELECT		A.COUNT_ID,
			CASE
				WHEN A.COUNT_TYPE = 'SKU' THEN 'SKU'
				WHEN A.COUNT_TYPE = 'LOCATION' THEN 'Ubicacion'
				WHEN A.COUNT_TYPE = 'BATCH' THEN 'Lote'
			END as COUNT_TYPE,
			A.COUNT_ASSIGNED_DATE, 
			A.COUNT_STARTED_DATE, 
			A.COUNT_COMPLETED_DATE, 
			A.COUNT_CANCELED_DATETIME, 
			A.COUNT_HITS, 
			A.COUNT_MISS, 
            A.COUNT_RESULT * 100 AS COUNT_RESULT, 
            A.COUNT_ASSIGNED_TO, 
            A.COUNT_NAME,
            CASE
				WHEN A.COUNT_STATUS = 'ASSIGNED' THEN 'Asignado'
				WHEN A.COUNT_STATUS = 'CANCELLED' THEN 'Cancelado'
			END as COUNT_STATUS

FROM         [acsa].SWIFT_CYCLE_COUNT_HEADER AS A

WHERE CONVERT(DATE,@DTBEGIN) >= CONVERT(DATE,A.COUNT_ASSIGNED_DATE) AND CONVERT(DATE,@DTEND) <= CONVERT(DATE,A.COUNT_ASSIGNED_DATE)





