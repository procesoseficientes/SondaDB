﻿-- =============================================
-- Autor:				diego.as
-- Fecha de Creacion: 	2/23/2017 @ A-TEAM Sprint  
-- Description:			SP que asocia un vendedor a una oficina de ventas

/*
-- Ejemplo de Ejecucion:
		EXEC [PACASA].[SWIFT_SP_ASSOCIATE_SELLER_TO_SALES_OFFICE]
			@SALES_OFFICE_ID = 2
			,@SELLER_CODE = 'V001'
		-- 
		SELECT * FROM [PACASA].[SWIFT_SELLER] WHERE SELLER_CODE = 'V001'
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_ASSOCIATE_SELLER_TO_SALES_OFFICE](
	@SALES_OFFICE_ID INT
	,@SELLER_CODE VARCHAR(50)
)
AS
BEGIN
	BEGIN TRY
		UPDATE [PACASA].[SWIFT_SELLER]
		SET	[SALES_OFFICE_ID] = @SALES_OFFICE_ID
		WHERE [SELLER_CODE] = @SELLER_CODE
		--
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo, '' DbData
	END TRY
	BEGIN CATCH
		SELECT  -1 as Resultado
		,ERROR_MESSAGE() Mensaje 
		,@@ERROR Codigo 
	END CATCH
END



