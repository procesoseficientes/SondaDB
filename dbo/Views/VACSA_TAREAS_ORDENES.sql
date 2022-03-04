﻿
CREATE VIEW [dbo].[VACSA_TAREAS_ORDENES] as
select T.TASK_ID,TASK_STATUS,TASK_DATE,COSTUMER_CODE,COSTUMER_NAME,
case WHEN REASON is null then 'Cliente no visitado'
WHEN T.REASON = 'Genero Gestion' THEN 'VENTA REALIZADA'
ELSE REASON
END REASON,TOTAL_AMOUNT,COMPLETED_STAMP,
COMPLETED_SUCCESSFULLY,U.NAME_USER,ERP_REFERENCE,POSTED_GPS,
CASE WHEN T.ASSIGNED_BY='Proceso diario' THEN 'AGENDA'
ELSE 'FUERA DE AGENDA'
END ORIGEN,
CASE WHEN SUBSTRING(POSTED_GPS,9,1) = ',' THEN SUBSTRING(POSTED_GPS,1,8)
WHEN SUBSTRING(POSTED_GPS,10,1) = ',' THEN SUBSTRING(POSTED_GPS,1,9)
WHEN SUBSTRING(POSTED_GPS,11,1) = ',' THEN SUBSTRING(POSTED_GPS,1,10)
END LATITUD,
CASE WHEN SUBSTRING(POSTED_GPS,9,1) = ',' THEN SUBSTRING(POSTED_GPS,10,11)
WHEN SUBSTRING(POSTED_GPS,10,1) = ',' THEN SUBSTRING(POSTED_GPS,11,11)
WHEN SUBSTRING(POSTED_GPS,11,1) = ',' THEN SUBSTRING(POSTED_GPS,12,11)
END LONGITUD
from acsa.SWIFT_TASKS T
INNER JOIN acsa.USERS U ON
U.LOGIN = T.ASSIGEND_TO
LEFT OUTER JOIN acsa.SONDA_SALES_ORDER_HEADER SH
ON SH.TASK_ID = T.TASK_ID
where year(TASK_DATE) > 2020