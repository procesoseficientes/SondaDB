﻿-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		24-06-2016
-- Description:			    SP que optiene los pickings dentro de un rango de fechas

-- Modificacion 1/4/2017 @ A-Team Sprint 
					-- rodrigo.gomez
					-- Se agrego el campo de IS_POSTED_ERP
/*
-- Ejemplo de Ejecucion:
        --
		EXEC [PACASA].[SWIFT_GET_ALL_PICKING]
			@DTBEGIN = '2016-01-24 10:25:00.863'
			,@DTEND = '20160331'
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_GET_ALL_PICKING] (
	@DTBEGIN DATE
	,@DTEND DATE
)
AS
BEGIN
	SELECT DISTINCT 
		PH.[PICKING_HEADER] [#Picking]
		,[PH].[CLASSIFICATION_PICKING]
		,PH.[LAST_UPDATE] [FECHA]
		,C.[NAME_CUSTOMER] [CLIENTE]
		,ISNULL(U.[NAME_USER], '') [OPERADOR_RESPOSABLE]
		,PH.[STATUS] [ESTATUS]
		,CASE CAST(PH.[IS_POSTED_ERP] AS VARCHAR)
			WHEN '1' THEN 'Si'
			ELSE 'No'
		  END AS IS_POSTED_ERP	
		  ,ISNULL([ST].[TASK_ID], 0) TASK_ID
	FROM [PACASA].[SWIFT_PICKING_HEADER] PH
	INNER JOIN [PACASA].[SWIFT_VIEW_ALL_COSTUMER] C ON (
		PH.[CODE_CLIENT] = C.[CODE_CUSTOMER]
	)
	LEFT JOIN [PACASA].USERS U ON (
		PH.[CODE_USER] = U.[LOGIN]
	)
	LEFT JOIN [PACASA].[SWIFT_TASKS] [ST] ON (
		[PH].[PICKING_HEADER] = [ST].[PICKING_NUMBER]
	)
	WHERE CONVERT(DATE,PH.LAST_UPDATE) BETWEEN @DTBEGIN AND @DTEND
END
