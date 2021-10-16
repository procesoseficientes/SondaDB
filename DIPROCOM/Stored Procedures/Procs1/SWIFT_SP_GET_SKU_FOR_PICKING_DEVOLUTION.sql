﻿
-- =============================================
-- Author:         diego.as
-- Create date:    010-02-2016
-- Description:    Obtiene los DETAILS de la Tabla 
--				   [DIPROCOM].SONDA_DOC_ROUTE_RETURN_DETAIL 
--				   con transacción y control de errores.
/*
Ejemplo de Ejecucion:
	--- EJEMPLO CON DATOS EXISTENTES---------------------------

	DECLARE @P_H AS INT
		,@TASK_NUMBER INT
		,@COD_SKU AS VARCHAR(50)
		
		SET @TASK_NUMBER = 14169
		SET @P_H = 1008
		SET	@COD_SKU ='100018'

	EXEC [DIPROCOM].[SWIFT_SP_GET_SKU_FOR_PICKING_DEVOLUTION] 
	@TASK_ID = @TASK_NUMBER
	,@PICKING_NUMBER = @P_H
	,@CODE_SKU = @COD_SKU 
	
	----- EJEMPLO CON DATOS INEXISTENTES-------------------------
	DECLARE @P_H AS INT
		,@TASK_NUMBER INT
		,@COD_SKU AS VARCHAR(50)
		
		SET @TASK_NUMBER = 14169
		SET @P_H = 1
		SET	@COD_SKU ='100018'

	EXEC [DIPROCOM].[SWIFT_SP_GET_SKU_FOR_PICKING_DEVOLUTION] 
	@TASK_ID = @TASK_NUMBER
	,@PICKING_NUMBER = @P_H
	,@CODE_SKU = @COD_SKU 
	 				
*/
-- =============================================

CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_SKU_FOR_PICKING_DEVOLUTION]
(
	@TASK_ID INT
	,@PICKING_NUMBER INT
	,@CODE_SKU AS VARCHAR(50)
)
AS
BEGIN
	SET NOCOUNT ON;
		DECLARE @PICKING_HEADER INT
				
		SELECT @PICKING_HEADER = PICKING_NUMBER FROM [DIPROCOM].[SWIFT_TASKS] 
		WHERE  TASK_ID = @TASK_ID AND PICKING_NUMBER = @PICKING_NUMBER 
		
		IF @PICKING_HEADER IS NOT NULL BEGIN

			SELECT 
			PD.[PICKING_HEADER]
			,PD.[PICKING_DETAIL]
			,PD.[CODE_SKU]
			,PD.[DESCRIPTION_SKU]
			,PD.[DISPATCH]
			,PD.[SCANNED]
			,PD.[DIFFERENCE]
		FROM [DIPROCOM].[SWIFT_PICKING_DETAIL] AS PD
		WHERE PD.PICKING_HEADER = @PICKING_HEADER 
				AND PD.CODE_SKU=@CODE_SKU

		END
		ELSE BEGIN
			SET @PICKING_HEADER = NULL
			SET	@CODE_SKU = NULL
			SELECT @PICKING_HEADER AS PICKING_HEADER
					,@CODE_SKU AS CODE_SKU
		END
		

END
