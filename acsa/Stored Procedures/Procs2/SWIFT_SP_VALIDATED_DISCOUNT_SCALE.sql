﻿-- =============================================
-- Autor:				rodrigo.gomez
-- Fecha de Creacion: 	2/9/2017 @ A-TEAM Sprint Chatuluka 
-- Description:			Valida si los rangos de la bonificacion no colisionan con los ya existentes

/*
-- Ejemplo de Ejecucion:
				EXEC [acsa].[SWIFT_SP_VALIDATED_DISCOUNT_SCALE]
*/
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_VALIDATED_DISCOUNT_SCALE](
	@TRADE_AGREEMENT_DISCUOUNT_ID INT = NULL	
	,@TRADE_AGREEMENT_ID INT
	,@CODE_SKU VARCHAR(50)
	,@PACK_UNIT INT
	,@LOW_LIMIT INT
	,@HIGH_LIMIT INT
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	DECLARE 
		@MESSAGE VARCHAR(250) = NULL

	--
	SELECT TOP 1 
		@MESSAGE = CASE
			WHEN @LOW_LIMIT BETWEEN S.LOW_LIMIT AND S.HIGH_LIMIT THEN 'Limite inferior del SKU: '+CAST(@CODE_SKU AS VARCHAR) +' entre rango existente'
			WHEN @HIGH_LIMIT BETWEEN S.LOW_LIMIT AND S.HIGH_LIMIT THEN 'Limite superior del SKU: '+CAST(@CODE_SKU AS VARCHAR) +' entre rango existente'
			WHEN S.LOW_LIMIT BETWEEN @LOW_LIMIT AND @HIGH_LIMIT THEN 'Rango del SKU: '+CAST(@CODE_SKU AS VARCHAR) +' absorve un rango ya existente'
			WHEN S.HIGH_LIMIT BETWEEN @LOW_LIMIT AND @HIGH_LIMIT THEN 'Rango del SKU: '+CAST(@CODE_SKU AS VARCHAR) +' absorve un rango ya existente'
			ELSE 'Rangos mal definidos'
		END
	FROM [acsa].[SWIFT_TRADE_AGREEMENT_DISCOUNT] AS S
	WHERE S.TRADE_AGREEMENT_ID = @TRADE_AGREEMENT_ID
		AND S.CODE_SKU = @CODE_SKU
		AND S.PACK_UNIT = @PACK_UNIT
		AND (
			(
				@LOW_LIMIT BETWEEN S.LOW_LIMIT AND S.HIGH_LIMIT
				OR @HIGH_LIMIT BETWEEN S.LOW_LIMIT AND S.HIGH_LIMIT
			)
			OR
			(
				S.LOW_LIMIT BETWEEN @LOW_LIMIT AND @HIGH_LIMIT
				OR S.HIGH_LIMIT BETWEEN @LOW_LIMIT AND @HIGH_LIMIT
			)
		)
		AND (
			@TRADE_AGREEMENT_DISCUOUNT_ID IS NULL 
			OR S.[TRADE_AGREEMENT_DISCUOUNT_ID] != @TRADE_AGREEMENT_DISCUOUNT_ID
		)
	
	--
	IF @MESSAGE IS NOT NULL
	BEGIN
		RAISERROR(@MESSAGE,16,1)
	END
END


