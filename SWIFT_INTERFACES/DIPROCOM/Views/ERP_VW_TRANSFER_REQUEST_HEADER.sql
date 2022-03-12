
-- =============================================
-- Autor:					alberto.ruiz
-- Fecha de Creacion: 		16-Aug-17 @ A-Team Sprint Banjo-Kazooie
-- Description:			    Vista que obtiene las solicitudes de transferencia

/*
-- Ejemplo de Ejecucion:
        SELECT * FROM [SONDA].[ERP_VW_TRANSFER_REQUEST_HEADER]
*/
-- =============================================
CREATE VIEW [SONDA].[ERP_VW_TRANSFER_REQUEST_HEADER]
AS
(SELECT
    *
  FROM OPENQUERY([ERPSERVER], '
		SELECT
			[WTQ].[DocNum] [DOC_NUM]
			,[WTQ].[DocEntry] [DOC_ENTRY]
			,[WTQ].[FromWhsCode] [FROM_WAREHOUSE_CODE]
			,[WTQ].[ToWhsCode] [TO_WAREHOUSE_CODE]
			,[WTQ].[DocDate] [DOC_DATE]
			,[WTQ].[DocDueDate] [DOC_DUE_DATE]
			,[WTQ].[DocStatus] [DOC_STATUS]
			,[WTQ].[CardCode] [CLIENT_ID]
			,[WTQ].[CardName] [CLIENT_NAME]
			,[WTQ].[SOURCE] [SOURCE]
		FROM [SAP_INTERCOMPANY].[dbo].[OWTQ] [WTQ]
		WHERE [WTQ].[DocStatus] = ''O''
	'))