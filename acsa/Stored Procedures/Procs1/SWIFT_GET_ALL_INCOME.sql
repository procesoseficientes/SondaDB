﻿CREATE PROCEDURE [acsa].[SWIFT_GET_ALL_INCOME]
@DTBEGIN DATE,
@DTEND DATE
AS
SELECT DISTINCT 
	A.RECEPTION_HEADER AS '#Recepcion',
	A.LAST_UPDATE AS 'FECHA',
	coalesce(C.NAME_PROVIDER,e.NAME_CUSTOMER) AS 'PROVEEDOR',
	D.NAME_USER AS 'OPERADOR_RESPOSABLE',
	A.[STATUS] AS 'ESTATUS'
FROM [acsa].SWIFT_RECEPTION_HEADER A
INNER JOIN [acsa].SWIFT_RECEPTION_DETAIL B on(A.RECEPTION_HEADER = B.RECEPTION_HEADER)
INNER JOIN [acsa].USERS D on(A.CODE_USER = D.[LOGIN])
left JOIN [acsa].SWIFT_VIEW_ALL_PROVIDERS C on(A.CODE_PROVIDER = C.CODE_PROVIDER)
left JOIN [acsa].SWIFT_VIEW_ALL_COSTUMER E on(A.CODE_PROVIDER = E.CODE_CUSTOMER)
WHERE CONVERT(DATE,@DTBEGIN) >= CONVERT(DATE,A.LAST_UPDATE) AND CONVERT(DATE,@DTEND) <= CONVERT(DATE,A.LAST_UPDATE)



