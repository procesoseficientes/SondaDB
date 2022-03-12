
-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		16-Aug-17 @ A-Team Sprint Banjo-Kazooie
-- Description:			    Vista que obtiene el detalle de las solicitudes de transferencia

/*
-- Ejemplo de Ejecucion:
        SELECT * FROM [SONDA].[ERP_VW_TRANSFER_REQUEST_DETAIL]
*/
-- =============================================
CREATE VIEW [SONDA].[ERP_VW_TRANSFER_REQUEST_DETAIL]
AS
(SELECT
    *
  FROM OPENQUERY([ERPSERVER], '
		SELECT
			[WTQ].[DocEntry] [DOC_ENTRY]
			,([WTQ].[SOURCE] + ''/'' + [WTQ].[ItemCode] COLLATE DATABASE_DEFAULT) [MATERIAL_ID]
			,[WTQ].[U_MasterIdSKU] [MATERIAL_MASTER_ID]
			,[WTQ].[U_OwnerSKU] [MATERIAL_OWNER]
			,[WTQ].[FromWhsCod] [FROM_WAREHOUSE_CODE]
			,[WTQ].[WhsCode] [TO_WAREHOUSE_CODE]
			,[WTQ].[LineNum] [LINE_NUM]
			,[WTQ].[Quantity] [QTY]
			,[WTQ].[ObjType] [ERP_OBJECT_TYPE]
			,[WTQ].[SOURCE] [SOURCE]
		FROM [SAP_INTERCOMPANY].[dbo].[WTQ1] [WTQ]
	'))