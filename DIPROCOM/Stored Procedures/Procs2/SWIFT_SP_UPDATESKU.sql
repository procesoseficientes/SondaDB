﻿-- =============================================
-- Autor:					diego.as
-- Fecha de Creacion: 		16-02-2016 
-- Description:			    Se agregó la columna CODE_FAMILY_SKU

-- Modificacion 04-Nov-16 @ A-Team Sprint 4
					-- alberto.ruiz
					-- Se agrego el parametro HANDLE_DIMENSION

/*
-- Ejemplo de Ejecucion:
         
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_UPDATESKU] (
	@SKU VARCHAR(50)
	,@DESCRIPTION_SKU VARCHAR(MAX)
	,@CLASSIFICATION_SKU VARCHAR(50)
	,@BARCODE_SKU VARCHAR(50)
	,@CODE_PROVIDER VARCHAR(50)
	,@COST FLOAT
	,@MEASURE VARCHAR(50)
	,@LAST_UPDATE VARCHAR(50)
	,@LAST_UPDATE_BY VARCHAR(50)
	,@HANDLE_SERIAL_NUMBER VARCHAR(2)
	,@HANDLE_BATCH VARCHAR(2)
	,@UNIT_MEASURE_SKU INT
	,@WEIGHT_SKU NUMERIC(18 ,2)
	,@VOLUME_SKU NUMERIC(18 ,2)
	,@LONG_SKU NUMERIC(18 ,2)
	,@WIDTH_SKU NUMERIC(18 ,2)
	,@HIGH_SKU NUMERIC(18 ,2)
	,@CODE_FAMILY_SKU VARCHAR(50)
	,@HANDLE_DIMENSION INT = 0
)AS
BEGIN 
	BEGIN TRY
		SET NOCOUNT ON;

		DECLARE	
			@FACTOR [NUMERIC](18 ,2)= 0.0
			,@KILOGRAM [NUMERIC](18 ,2)= 0.0
			,@UNIT INT = 35

		IF ( (@UNIT_MEASURE_SKU >= 32) AND (@UNIT_MEASURE_SKU != 34) AND (@UNIT_MEASURE_SKU != 35) )
		BEGIN
			SELECT @FACTOR = [CONVERTION_FACTOR]
			FROM [PACASA].[SWIFT_UNIT_CONVERTION]
			WHERE [MEASURE_UNIT_FROM] = @UNIT_MEASURE_SKU
				AND [MEASURE_UNIT_TO] = 34;
			--
			SET @KILOGRAM = (@WEIGHT_SKU * @FACTOR) * 0.001;
		END;
		--
		IF (@UNIT_MEASURE_SKU = 34)
		BEGIN
			SET @KILOGRAM = @WEIGHT_SKU * 0.001;
		END;
		--
		IF (@UNIT_MEASURE_SKU = 35)
		BEGIN
			SET @KILOGRAM = @WEIGHT_SKU;
		END;

		UPDATE [SWIFT_SKU]
		SET	
			[DESCRIPTION_SKU] = @DESCRIPTION_SKU
			,[CLASSIFICATION_SKU] = @CLASSIFICATION_SKU
			,[BARCODE_SKU] = @BARCODE_SKU
			,[CODE_PROVIDER] = @CODE_PROVIDER
			,[COST] = @COST
			,[MEASURE] = @MEASURE
			,[LAST_UPDATE] = GETDATE()
			,[LAST_UPDATE_BY] = @LAST_UPDATE_BY
			,[HANDLE_SERIAL_NUMBER] = @HANDLE_SERIAL_NUMBER
			,[HANDLE_BATCH] = @HANDLE_BATCH
			,[UNIT_MEASURE_SKU] = @UNIT
			,[WEIGHT_SKU] = @KILOGRAM
			,[VOLUME_SKU] = @VOLUME_SKU
			,[LONG_SKU] = @LONG_SKU
			,[WIDTH_SKU] = @WIDTH_SKU
			,[HIGH_SKU] = @HIGH_SKU
			,[CODE_FAMILY_SKU] = @CODE_FAMILY_SKU
			,[HANDLE_DIMENSION] = @HANDLE_DIMENSION
		WHERE [CODE_SKU] = @SKU;
	END TRY
	BEGIN CATCH
		ROLLBACK;
		DECLARE	@ERROR VARCHAR(1000)= ERROR_MESSAGE();
		RAISERROR (@ERROR,16,1);
	END CATCH;

END; 



