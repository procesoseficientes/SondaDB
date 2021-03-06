-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	06-Dec-16 @ A-TEAM Sprint 5 
-- Description:			SP para autorizar una orden de venta

/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [PACASA].[SONDA_SALES_ORDER_HEADER] WHERE [SALES_ORDER_ID] = 831
				--
				EXEC [PACASA].[SWIFT_SP_AUTHORIZE_SALES_ORDER]
					@SALES_ORDER_ID = 831
					,@LOGIN = 'gerente@DIPROCOM'
				--
				SELECT * FROM [PACASA].[SONDA_SALES_ORDER_HEADER] WHERE [SALES_ORDER_ID] = 831
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_AUTHORIZE_SALES_ORDER](
	@SALES_ORDER_ID INT
	,@LOGIN VARCHAR(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	BEGIN TRY
		UPDATE [PACASA].[SONDA_SALES_ORDER_HEADER]
		SET
			[AUTHORIZED] = 1
			,[AUTHORIZED_BY] = @LOGIN
			,[AUTHORIZED_DATE] = GETDATE()
		WHERE [SALES_ORDER_ID] = @SALES_ORDER_ID
      AND IS_READY_TO_SEND=1
		--
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo, '' DbData
	END TRY
	BEGIN CATCH
		SELECT  -1 as Resultado
		,ERROR_MESSAGE() Mensaje 
		,@@ERROR Codigo 
	END CATCH
END



