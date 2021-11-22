﻿-- =============================================
-- Autor:				diego.as
-- Fecha de Creacion: 	8/2/2018 @ G-FORCE-TEAM Sprint G-FORCE@GATO
-- Description:			SP que actualiza la imagen del operador

/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].[SONDA_SP_UPDATE_USER_IMAGE]
					@CODE_ROUTE = '46'
					,@IMAGE = 'data:image/png;base64,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'
				-- 
				SELECT * FROM [PACASA].[USERS] WHERE [SELLER_ROUTE] = '46'
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SONDA_SP_UPDATE_USER_IMAGE](
	@CODE_ROUTE VARCHAR(50)
	,@IMAGE VARCHAR(MAX)
)
AS
BEGIN
	BEGIN TRY
		UPDATE [PACASA].[USERS]
		SET	
			[IMAGE] = @IMAGE
		WHERE [SELLER_ROUTE] = @CODE_ROUTE
		--
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo, '' DbData
	END TRY
	BEGIN CATCH
		SELECT  -1 as Resultado
		,ERROR_MESSAGE() Mensaje 
		,@@ERROR Codigo 
	END CATCH
END