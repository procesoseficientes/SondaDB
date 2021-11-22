-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	18-Apr-17 @ A-TEAM Sprint Garai 
-- Description:			SP que elimina las facturas 

/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].[SWIFT_SP_CLEAN_INVOICE]
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_CLEAN_INVOICE]
AS
BEGIN
	SET NOCOUNT ON;
	--
	DELETE [D]
	FROM [PACASA].[SONDA_POS_INVOICE_DETAIL] [D]
	INNER JOIN [PACASA].[SONDA_POS_INVOICE_HEADER] [H] ON (
		[H].[ID] = [D].[ID]
	)
	WHERE [IS_READY_TO_SEND] = 0
	--
	DELETE FROM [PACASA].[SONDA_POS_INVOICE_HEADER]
	WHERE [IS_READY_TO_SEND] = 0
END



