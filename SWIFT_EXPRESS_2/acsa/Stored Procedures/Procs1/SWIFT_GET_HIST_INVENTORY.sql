﻿CREATE PROCEDURE [SONDA].[SWIFT_GET_HIST_INVENTORY]
@DTBEGIN DATE,
@DTEND DATE
AS

SELECT     A.INVENTORY, ISNULL(A.SERIAL_NUMBER,'N/A') AS SERIAL_NUMBER,A.WAREHOUSE, A.LOCATION, 
D.CODE_SKU AS SKU,A.SKU_DESCRIPTION AS DESCRIPTION_SKU, D.BARCODE_SKU AS BARCODE, A.ON_HAND,E.BATCH_ID AS BATCH,
A.PROC_DATE, A.INV_DATE, A.COST, CONVERT(DATE,E.BATCH_SUPPLIER_EXPIRATION_DATE) AS EXP_DATE,
CASE 
            WHEN CONVERT(DATE,E.BATCH_SUPPLIER_EXPIRATION_DATE) <= CONVERT(DATE,GETDATE())
               THEN 'LOTE EXPIRADO'
            WHEN CONVERT(DATE,E.BATCH_SUPPLIER_EXPIRATION_DATE) >= CONVERT(DATE,GETDATE()) AND CONVERT(DATE,E.BATCH_SUPPLIER_EXPIRATION_DATE) <= CONVERT(DATE,GETDATE()+5)
               THEN 'LOTE PROXIMO A EXPIRAR'
            WHEN CONVERT(DATE,E.BATCH_SUPPLIER_EXPIRATION_DATE) >= CONVERT(DATE,GETDATE())
               THEN 'LOTE VIGENTE'
END AS EXPIRACION,
A.TOTAL AS TOTAL
FROM         [SONDA].SWIFT_HIST_INVENTORY AS A 
LEFT OUTER JOIN [SONDA].SWIFT_VIEW_ALL_SKU AS D ON A.SKU = D.CODE_SKU
LEFT OUTER JOIN [SONDA].SWIFT_BATCH AS E ON A.BATCH_ID = E.BATCH_ID		
WHERE CONVERT(DATE,@DTBEGIN) >= CONVERT(DATE,DATEADD(DAY,1,INV_DATE)) AND CONVERT(DATE,@DTEND) <= CONVERT(DATE,DATEADD(DAY,1,INV_DATE))
AND A.ON_HAND > 0 AND A.COST > 0