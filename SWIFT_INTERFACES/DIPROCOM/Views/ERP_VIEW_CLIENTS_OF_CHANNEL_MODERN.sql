
-- =============================================
-- Autor:                hector.gonzalez
-- Fecha de Creacion:   2017-04-04 TeamErgon Sprint hyper
-- Description:          Vista que trae el los clientes y vendedores de el canal moderno

-- Modificacion 8/8/2017 @ NEXUS-Team Sprint Banjo-Kazooie
-- rodrigo.gomez
-- Se agregan las columnas INTERCOMPANY

-- Modificacion 9/24/2017 @ NEXUS-Team Sprint Duckhunt
-- rodrigo.gomez
-- Se agrega campo de direccion y departamento
/*
-- Ejemplo de Ejecucion:
        SELECT * FROM [DIPROCOM].ERP_VIEW_CLIENTS_OF_CHANNEL_MODERN
          
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_VIEW_CLIENTS_OF_CHANNEL_MODERN]
AS

SELECT
  *
FROM OPENQUERY([ERPSERVER], '

SELECT DISTINCT
  T0.CardCode AS CLIENT_ID
  ,T0.CardName AS CLIENT_NAME
  ,T0.[U_MasterIDCustomer] AS MASTER_ID
  ,T0.[U_Owner] AS OWNER
  ,T0.[Address2] AS ADDRESS_CUSTOMER
  ,T1.[StateS] AS STATE_CODE
FROM [SAP_INTERCOMPANY].dbo.ORDR T0 
	INNER JOIN [SAP_INTERCOMPANY].dbo.RDR12 T1 ON T0.DocEntry = T1.DocEntry
									AND T1.U_Owner = T0.U_Owner
WHERE T0.[DocStatus] <> ''C''
AND T0.CardCode  NOT LIKE ''SO%''
AND T0.[U_MasterIDCustomer] IS NOT NULL
AND T0.[U_OwnerCustomer] IS NOT NULL

ORDER BY 1 DESC')