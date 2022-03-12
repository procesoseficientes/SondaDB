﻿-- =============================================
-- Autor:				rudi.garcia
-- Fecha de Creacion: 	1-21-2016
-- Description:			obtiene la informacion del picking por la tarea


-- Modificado 04-03-2016
	--diego.as
	--Se agrego la columna PICKING_HEADER

/*
-- Ejemplo de Ejecucion:				
				--select * from [SONDA].[OP_WMS_FUNC_GET_PICKING_TASK] (16507)
*/
-- =============================================
CREATE FUNCTION [SONDA].[OP_WMS_FUNC_GET_PICKING_TASK]
(              
                @pTASK_ID INT                
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT 
		T.CREATED_STAMP
		,T.ASSIGNED_BY
		,T.ASSIGNED_STAMP AS ASSIGNED_DATE
		,T.COSTUMER_CODE  AS CUSTOMER_CODE
		,T.COSTUMER_NAME  AS CUSTOMER_NAME
		,T.TASK_STATUS
		,(SELECT VALUE_TEXT_CLASSIFICATION FROM [SONDA].SWIFT_CLASSIFICATION WHERE GROUP_CLASSIFICATION = 'PICKING' AND CLASSIFICATION =  PH.CLASSIFICATION_PICKING) AS PICKING_TYPE		
		,PH.DOC_SAP_RECEPTION AS DOC_SAP
		,ISNULL(PH.COMMENTS, T.COSTUMER_NAME) AS COMMENTS
		,PH.SEQ
		,PD.CODE_SKU
		,PD.DESCRIPTION_SKU
		,ISNULL((SELECT HANDLE_SERIAL_NUMBER FROM SWIFT_VIEW_SKU WHERE CODE_SKU = PD.CODE_SKU),0) AS HANDLE_SERIAL_NUMBER
		,ISNULL((SELECT COUNT(1) FROM SWIFT_TXNS_SERIES WHERE TXN_ID = @pTASK_ID AND TXN_CODE_SKU = PD.CODE_SKU),0) AS SERIALIZED
		,PD.DISPATCH AS EXPECTED
		,ISNULL(PD.SCANNED,0) AS SCANNED
		,PD.RESULT
		,CASE S.HANDLE_BATCH WHEN '' THEN '0' ELSE S.HANDLE_BATCH END AS HANDLE_BATCH
		,PH.PICKING_HEADER AS PICKING_HEADER
	FROM SWIFT_TASKS T
	INNER JOIN SWIFT_PICKING_HEADER PH ON (PH.PICKING_HEADER = T.PICKING_NUMBER)
	INNER JOIN SWIFT_PICKING_DETAIL PD ON (PD.PICKING_HEADER = PH.PICKING_HEADER)
	INNER JOIN SWIFT_VIEW_SKU S ON (PD.CODE_SKU = S.CODE_SKU)
	WHERE
		T.TASK_ID = @pTASK_ID 
		
		
)