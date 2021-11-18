﻿CREATE PROC [acsa].[SWIFT_SP_INSERT_PRICE_LIST_BY_SKU]
	@CODE_PRICE_LIST VARCHAR(25)	
	, @CODE_SKU VARCHAR(50)
	, @COST numeric(18,2)
	, @pResult VARCHAR(250) OUTPUT
AS
BEGIN
	DECLARE @OWNER VARCHAR(25) = (SELECT OWNER FROM [acsa].SWIFT_VIEW_ALL_SKU WHERE CODE_SKU = @CODE_SKU AND OWNER IS NOT NULL)
	BEGIN TRAN t1
		BEGIN			
			DELETE [acsa].SWIFT_PRICE_LIST_BY_SKU 
			WHERE CODE_PRICE_LIST = @CODE_PRICE_LIST
			AND CODE_SKU = @CODE_SKU
		
			INSERT INTO [acsa].SWIFT_PRICE_LIST_BY_SKU(
				CODE_PRICE_LIST
				, CODE_SKU
				, COST
				, OWNER
			)
			VALUES(
				@CODE_PRICE_LIST
				, @CODE_SKU
				, @COST
				, @OWNER
			);
		END
	
	
	IF @@error = 0 BEGIN
		SELECT @pResult = 'OK'
		COMMIT TRAN t1
	END		
	ELSE BEGIN
		ROLLBACK TRAN t1
		SELECT	@pResult	= ERROR_MESSAGE()
	END
END




