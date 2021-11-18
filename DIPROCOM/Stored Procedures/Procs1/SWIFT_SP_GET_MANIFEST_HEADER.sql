﻿-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		11-07-2016 @ Sprint  ζ
-- Description:			    SP que obtiene el reporte consolidado de carga por operador

/*
-- Ejemplo de Ejecucion:
		--
		EXEC [acsa].[SWIFT_SP_GET_MANIFEST_HEADER]
			@MANIFEST_HEADER = 3071
*/
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_GET_MANIFEST_HEADER] (
	@MANIFEST_HEADER INT
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT
		[U].[LOGIN]
		,[C].[CODE_CUSTOMER]
		,MAX([C].[NAME_CUSTOMER]) [NAME_CUSTOMER]
		,MAX([C].[ADRESS_CUSTOMER]) [ADDRESS_CUSTOMER]
		,SUM([PD].[SCANNED]) QTY
		,MAX([EDP].[TOTAL_AMOUNT]) [TOTAL_AMOUNT]
	FROM [acsa].[SWIFT_MANIFEST_HEADER] [MH]
	INNER JOIN [acsa].[SWIFT_MANIFEST_DETAIL] [MD] ON (
		[MH].[MANIFEST_HEADER] = [MD].[CODE_MANIFEST_HEADER]
	)
	INNER JOIN [acsa].[SWIFT_VIEW_ALL_COSTUMER] [C] ON (
		[C].[CODE_CUSTOMER] = [MD].[CODE_CUSTOMER]
	)
	INNER JOIN [acsa].[SWIFT_PICKING_HEADER] [PH] ON (
		[MD].[CODE_PICKING] = [PH].[PICKING_HEADER]
	)
	INNER JOIN [acsa].[SWIFT_PICKING_DETAIL] [PD] ON (
		[PH].[PICKING_HEADER] = [PD].[PICKING_HEADER]
	)
	INNER JOIN [acsa].[USERS] [U] ON (
		[U].[RELATED_SELLER] = [PH].[CODE_SELLER]
	)
	INNER JOIN [SWIFT_INTERFACES].[acsa].[ERP_VIEW_DOC_FOR_PICKING] [EDP] ON (
		[MD].[DOC_SAP_PICKING] = [EDP].[SAP_REFERENCE]
	)
	WHERE [MH].[MANIFEST_HEADER] = @MANIFEST_HEADER
	GROUP BY [U].[LOGIN]
		,[C].[CODE_CUSTOMER]
	ORDER BY [U].[LOGIN]
END



