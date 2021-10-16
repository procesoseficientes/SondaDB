﻿-- =============================================
-- Autor:				404
-- Fecha de Creacion: 	18-11-2019
-- Description:			Copiar reporte de tareas a las intermedias del cliente

/*
-- Ejemplo de Ejecucion:
				-- 
				EXEC [DIPROCOM].[SWIFT_SYNCRO_VENDEDORES_RUTA]
				--
			
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SYNCRO_VENDEDORES_RUTA_COPIA]
AS
BEGIN
	SET NOCOUNT ON;

------------------------------------------------------------------------------------------
--Declaramos la variable @Ruta
------------------------------------------------------------------------------------------
DECLARE @RUTA AS VARCHAR(100)
      , @FECHA  AS DATETIME;
--------------------------------------------------------------------------------------------
--Insertamos todas las rutas activas en el sistema
--------------------------------------------------------------------------------------------
PRINT 'Identificando Rutas'
SELECT CODE_ROUTE
INTO #Rutas
FROM DIPROCOM.SWIFT_ROUTES
ORDER BY CODE_ROUTE

Select @FECHA = '2021-02-10 11:01:13.880'
--------------------------------------------------------------------------------------------
--Insertamos todas las ventas y preventas por tarea con su respectivo total
--------------------------------------------------------------------------------------------
PRINT 'Cargando Transacciones'
SELECT TASK_ID,
       TOTAL_AMOUNT,
       'PRESALE' [TYPE]
INTO #TOTAL_AMOUNT
FROM DIPROCOM.SONDA_SALES_ORDER_HEADER
WHERE POSTED_DATETIME >= FORMAT(@FECHA, 'yyyMMdd')
      AND IS_READY_TO_SEND = 1
      AND IS_VOID = 0
	  

UNION
SELECT TASK_ID,
       TOTAL_AMOUNT,
       'SALE' [TYPE]
FROM DIPROCOM.SONDA_POS_INVOICE_HEADER
WHERE POSTED_DATETIME >= FORMAT(@FECHA, 'yyyMMdd')
      AND IS_READY_TO_SEND = 1
      AND VOIDED_INVOICE IS NULL
UNION ALL
SELECT TASK_ID,
	   '0' [TOTAL_AMOUNT],
		 TASK_TYPE [TYPE]
 FROM DIPROCOM.SWIFT_TASKS
 WHERE SCHEDULE_FOR >= FORMAT(@FECHA, 'yyyMMdd')
 AND COMPLETED_SUCCESSFULLY=0


--------------------------------------------------------------------------------------------
--Insertamos todas las ventas y preventas por tarea con su respectivo total
--------------------------------------------------------------------------------------------

	WHILE EXISTS (SELECT TOP 1 1 CODE_ROUTE FROM #Rutas)
		BEGIN

			SELECT TOP 1
				   @RUTA = CODE_ROUTE
			FROM #Rutas;

			PRINT 'Syncronizando Ruta ' + @RUTA

			INSERT INTO DIPROCOM_SERVER.SONDA.dbo.VENDEDOR_RUTA
			(
				CODIGO_DE_RUTA,
				ORDEN,
				FECHA_FINALIZADA,
				CODIGO_DE_CLIENTE,
				GPS_GESTION,
				GPS_ESPERADO,
				TOTAL_VENTA
			)
			SELECT T.CODE_ROUTE,
				   ROW_NUMBER() OVER (ORDER BY T.TASK_ID ASC) AS [ORDEN],
				   T.COMPLETED_STAMP,
				   T.COSTUMER_CODE,
				   T.EXPECTED_GPS,
				   T.POSTED_GPS,
				   I.TOTAL_AMOUNT
			FROM DIPROCOM.SWIFT_TASKS T
				INNER JOIN #TOTAL_AMOUNT I
					ON T.TASK_ID = I.TASK_ID
			WHERE T.SCHEDULE_FOR >= FORMAT(@FECHA, 'yyyyMMdd')
				  AND T.CODE_ROUTE = @RUTA
			ORDER BY T.COMPLETED_STAMP;


			DELETE FROM #Rutas
			WHERE CODE_ROUTE = @RUTA
		END
END 









