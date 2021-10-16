﻿-- =============================================
-- Autor:				ppablo.loukota
-- Fecha de Creacion: 	09-01-2016
-- Description:			Valida si la tera tiene los batchs y las pallets localizadas

/*
-- Ejemplo de Ejecucion:
				SELECT [DIPROCOM].[SWIFT_FN_VALIDATE_COMPLETE_TASK](5219)
*/
-- =============================================


CREATE FUNCTION [DIPROCOM].[SWIFT_FN_VALIDATE_COMPLETE_TASK]
(
	@TASK_ID INT 
)
RETURNS INT
AS
BEGIN
	DECLARE @RESULT INT = 0;
	
	SELECT @RESULT = COUNT(*) FROM [DIPROCOM].[SWIFT_BATCH] B WHERE B.TASK_ID = @TASK_ID
	--
	IF @RESULT > 0
	BEGIN
		SELECT @RESULT = COUNT(*)
		FROM [DIPROCOM].[SWIFT_PALLET] P
		INNER JOIN [DIPROCOM].[SWIFT_BATCH] B ON (P.[BATCH_ID] = B.[BATCH_ID])
		WHERE P.[TASK_ID] = @TASK_ID 
		AND (P.[STATUS] != 'LOCATED' OR B.[STATUS] != 'CLOSED')
		AND P.QTY > 0
		--	 
		IF (@RESULT = 0)
		BEGIN
			SET @RESULT = 1;
		END
		ELSE
		BEGIN
			SET @RESULT = 0
		END
	END
	
	RETURN  @RESULT
	
END