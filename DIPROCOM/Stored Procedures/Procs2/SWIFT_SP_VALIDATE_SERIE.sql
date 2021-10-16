﻿CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_VALIDATE_SERIE]
(              
	@pSERIE			VARCHAR(50),
	@pLOCATION		VARCHAR(50),
	@pSKU			VARCHAR(50),
	@pSERVICE_ID	VARCHAR(50),
	@pQTY			INT = NULL
)

AS
	DECLARE @lBARCODE VARCHAR(75);
	
	SELECT @lBARCODE = UPPER(@pSKU);

	IF @pSERVICE_ID = 'VALIDATE_SERIE_LOCATION_SKU' BEGIN
	        SELECT * FROM [SWIFT_INVENTORY] WHERE
			[SKU] = (SELECT TOP 1 CODE_SKU FROM SWIFT_VIEW_SKU  WHERE CODE_SKU = @lBARCODE OR BARCODE_SKU = @lBARCODE) AND
			[SERIAL_NUMBER] = @pSERIE AND 
			[LOCATION] = @pLOCATION

			IF(@@ROWCOUNT >= 1) BEGIN
				RETURN 0;
			END 
			ELSE RETURN -1;
	END
       
	IF @pSERVICE_ID = 'VALIDATE_SERIE' BEGIN
	        SELECT * FROM [SWIFT_INVENTORY] WHERE
			[SERIAL_NUMBER] = @pSERIE

			IF(@@ROWCOUNT >= 1) BEGIN
				RETURN 0;
			END 
			ELSE RETURN -1;
	END

	IF @pSERVICE_ID = 'VALIDATE_SERIE_SKU' BEGIN
	        SELECT * FROM [SWIFT_INVENTORY] WHERE
			[SKU] = (SELECT TOP 1 CODE_SKU FROM SWIFT_VIEW_SKU  WHERE CODE_SKU = @lBARCODE OR BARCODE_SKU = @lBARCODE) AND
			[SERIAL_NUMBER] = @pSERIE 

			IF(@@ROWCOUNT >= 1) BEGIN
				RETURN 0;
			END 
			ELSE RETURN -1;
	END

	IF @pSERVICE_ID = 'VALIDATE_SERIE_LOCATION' BEGIN
	        SELECT * FROM [SWIFT_INVENTORY] WHERE
			[SERIAL_NUMBER] = @pSERIE AND 
			[LOCATION] = @pLOCATION

			IF(@@ROWCOUNT >= 1) BEGIN
				RETURN 0;
			END 
			ELSE RETURN -1;
	END
	IF @pSERVICE_ID = 'VALIDATE_QTY' BEGIN
			DECLARE @RESULT INT 
			SELECT @RESULT = SUM(ON_HAND) FROM DIPROCOM.SWIFT_INVENTORY  WHERE SKU = UPPER(@pSKU) AND [LOCATION] = @pLOCATION
			IF(@RESULT >= @pQTY) BEGIN
				RETURN 0;
			END 
			ELSE RETURN -1;
	END

	IF @pSERVICE_ID = 'VALIDATE_SERIE_DEVOLUTION' BEGIN
	        SELECT * FROM [DIPROCOM].[SWIFT_TXNS] WHERE
			[TXN_CODE_SKU] = (SELECT TOP 1 CODE_SKU FROM SWIFT_VIEW_SKU  WHERE CODE_SKU = @lBARCODE OR BARCODE_SKU = @lBARCODE) AND
			[TXN_SERIE] = @pSERIE AND TXN_TYPE = 'PICKING'

			IF(@@ROWCOUNT >= 1) BEGIN
				RETURN 0;
			END 
			ELSE RETURN -1;
	END



