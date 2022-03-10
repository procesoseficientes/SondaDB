
-- =============================================
-- Autor:	pablo.aguilar
-- Fecha de Creacion: 	2017-01-13 Team ERGON - Sprint ERGON 1
-- Description:	 Consultar documentos de recepción de ERP 

-- Autor:	              hector.gonzalez
-- Fecha de Creacion: 	2017-01-13 Team ERGON - Sprint ERGON 1
-- Description:	        Se agrego DocCur y DocRate


-- Modificación: pablo.aguilar
-- Fecha de Creacion: 	2017-03-01 Team ERGON - Sprint ERGON IV
-- Description:	 Se agrega para que retorne a su vez DocNum de SAP

-- Modificacion 09-Aug-17 @ Nexus Team Sprint Banjo-Kazooie
-- alberto.ruiz
-- Ajuste por intercompany


/*
-- Ejemplo de Ejecucion:
			select * from [DIPROCOM].ERP_VIEW_RECEPTION_DOCUMENT 
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_VIEW_RECEPTION_DOCUMENT]
AS

SELECT
  *
FROM OPENQUERY(ERPSERVER, '
		SELECT
			P.DocEntry SAP_REFERENCE
			,''PO'' DOC_TYPE
			,''Pusher Order'' DESCRIPTION_TYPE
			,P.CardCode CUSTOMER_ID
			--,NULL COD_WAREHOUSE
			,P.CardName CUSTOMER_NAME
		  --,NULL WAREHOUSE_NAME
        ,P.DocDate DOC_DATE
      ,P.DocCur DOC_CUR
      ,P.DocRate DOC_RATE
      ,P.Comments COMMENTS
      ,P.DocNum 
		,P.[U_MasterIDProvider] [MASTER_ID_PROVIDER]
		,P.[U_OwnerProvider] [OWNER_PROVIDER]
		,P.[U_Owner] [OWNER]
		FROM SAP_INTERCOMPANY.dbo.OPOR P
		WHERE P.DocStatus = ''O''
	')