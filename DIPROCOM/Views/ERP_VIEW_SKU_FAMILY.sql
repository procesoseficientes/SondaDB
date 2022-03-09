



-- =============================================
--  Autor:		joel.delcompare
-- Fecha de Creacion: 	2016-02-26 16:08:17
-- Description:		Obitene los grupos de los productos

-- Modificacion 3/13/2017 @ A-Team Sprint Ebonne
-- rodrigo.gomez
-- Se pusieron como referencias las vistas en la base de datos SAP_INTERCOMPANY

-- Modificacion 4/20/2017 @ A-Team Sprint Hondo
-- rodrigo.gomez
-- Se agregaron las columnas MasterID, Owner y OwnerID

-- Modificacion 6/01/2017 @Logistica3W
-- alejandro.ochoa
-- Se obtienen los datos de familias de SAP
/*
-- Ejemplo de Ejecucion:
    USE SWIFT_INTERFACES_ONLINE
    GO
    
     SELECT  * FROM  DIPROCOM.ERP_VIEW_SKU_FAMILY
GO
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_VIEW_SKU_FAMILY]
AS

SELECT
  *
FROM OPENQUERY(DIPROCOM_SERVER, '
		SELECT DISTINCT
			RTRIM(Codigo_Familia) [CODE_FAMILY_SKU]
			,RTRIM(Nombre_Familia) [DESCRIPTION_FAMILY_SKU]
			,''Diprocom'' [Owner]
			,1 [ORDER]
			,GETDATE() [LAST_UPDATE]
			,''BULK_DATA'' [LAST_UPDATE_BY]
		FROM [SONDA].[dbo].[vsMAESTRO_PRODUCTOS]
		UNION
		SELECT DISTINCT
			RTRIM(Codigo_Familia) [CODE_FAMILY_SKU]
			,RTRIM(Nombre_Familia) [DESCRIPTION_FAMILY_SKU]
			,''Diprocom'' [Owner]
			,1 [ORDER]
			,GETDATE() [LAST_UPDATE]
			,''BULK_DATA'' [LAST_UPDATE_BY]
		FROM [SONDA].[dbo].[vsMAESTRO_PRODUCTOS_PREVENTA]
	')