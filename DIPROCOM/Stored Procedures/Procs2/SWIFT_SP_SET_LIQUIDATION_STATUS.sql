﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	18-Nov-16 @ A-TEAM Sprint 5 
-- Description:			SP que actualiza el estado de la liquidacion

/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [DIPROCOM].[SONDA_LIQUIDATION] WHERE [LIQUIDATION_ID] = 6
				--
				EXEC [DIPROCOM].[SWIFT_SP_SET_LIQUIDATION_STATUS]
					@LIQUIDATION_ID = 6
					,@LIQUIDATIONS_STATUS = 'CLOSED'
					,@LIQUIDATION_COMMENT = 'comentario'
					,@LOGIN = 'gerente@DIPROCOM'
				--
				SELECT * FROM [DIPROCOM].[SONDA_LIQUIDATION] WHERE [LIQUIDATION_ID] = 6
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_SET_LIQUIDATION_STATUS](
	@LIQUIDATION_ID INT
	,@LIQUIDATIONS_STATUS VARCHAR(10)
	,@LIQUIDATION_COMMENT VARCHAR(250)
	,@LOGIN VARCHAR(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	BEGIN TRY
		UPDATE [DIPROCOM].[SONDA_LIQUIDATION]
		SET
			[LIQUIDATION_STATUS] = @LIQUIDATIONS_STATUS
			,[LIQUIDATION_COMMENT] = @LIQUIDATION_COMMENT
			,[STATUS] = 'COMPLETED'
			,[LAST_UPDATE_BY] = @LOGIN
			,[LAST_UPDATE] = GETDATE()
		WHERE [LIQUIDATION_ID] = @LIQUIDATION_ID 
		--
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo, '' DbData
	END TRY
	BEGIN CATCH
		SELECT  -1 as Resultado
		,ERROR_MESSAGE() Mensaje 
		,@@ERROR Codigo 
	END CATCH
END



