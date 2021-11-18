﻿-- =============================================
-- Autor:				ppablo.loukota
-- Fecha de Creacion: 	09-01-2016
-- Description:			Valida si el Pallet tiene Batchs todavia para poderse cerrar

/*
-- Ejemplo de Ejecucion:
				SELECT [acsa].[SWIFT_FN_VALIDATE_RESULT_SUM_PRODUCT](6184)
*/
-- =============================================


CREATE FUNCTION [acsa].[SWIFT_FN_VALIDATE_RESULT_SUM_PRODUCT]
(
	@TASK_ID INT 
)
RETURNS INT
AS
BEGIN


	DECLARE @RESULT AS INT  =0;

	DECLARE @QUANT_COU INT = 0;
	DECLARE @QUANT_GEN INT = 0;
	DECLARE @SKU_TEMP [varchar](50);


	SELECT @QUANT_COU = SUM(INV.[ON_HAND]) 
	FROM [acsa].[SWIFT_INVENTORY]  AS INV INNER JOIN [acsa].[SWIFT_PALLET] AS PAL  ON (INV.[PALLET_ID] = PAL.[PALLET_ID]) 
	WHERE PAL.TASK_ID = @TASK_ID
	GROUP BY PAL.TASK_ID


	SELECT @QUANT_GEN = SUM(DA.[SCANNED]) 
	FROM [acsa].[SWIFT_RECEPTION_DETAIL] AS DA INNER JOIN [acsa].[SWIFT_TASKS] AS TA  ON (TA.[RECEPTION_NUMBER] = DA.RECEPTION_HEADER) 
    WHERE TA.TASK_ID = @TASK_ID
    GROUP BY TA.TASK_ID



	IF(@QUANT_GEN = @QUANT_COU)
		BEGIN
			SET @RESULT= 1; 
		END
		ELSE
			BEGIN
				SET @RESULT=0;
			END


   --SELECT @SKU_TEMP AS DESCRIPTION_SKU, @QUANT_COU AS TOTAL_DETALLE_RECEPCION,@QUANT_GEN  AS TOTAL_INVENTARIO  



	RETURN @RESULT



END
