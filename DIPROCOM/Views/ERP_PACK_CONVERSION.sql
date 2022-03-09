-- =============================================
--  Autor:		joel.delcompare
-- Fecha de Creacion: 	2016-02-27 13:23:47
-- Description:		OBTIENE LAS UNIDADES DE CONVERSION 

-- Modificacion 4/20/2017 @ A-Team Sprint Hondo
-- rodrigo.gomez
-- Se agregaron las columnas MasterId, Owner y OwnerId

/*
-- Ejemplo de Ejecucion:

USE SWIFT_INTERFACES_ONLINE
GO

SELECT
  CODE_SKU
 ,CODE_PACK_UNIT_FROM
 ,CODE_PACK_UNIT_TO
 ,CONVERSION_FACTOR
 ,LAST_UPDATE
 ,LAST_UPDATE_BY
 ,[ORDER]
select * FROM [DIPROCOM].ERP_PACK_CONVERSION;
GO

*/
-- =============================================

CREATE VIEW [DIPROCOM].[ERP_PACK_CONVERSION]
AS
	SELECT DISTINCT
	  CODE_SKU
	 ,CODE_PACK_UNIT_FROM
	 ,CODE_PACK_UNIT_TO
	 ,CONVERSION_FACTOR
	 ,GETDATE() LAST_UPDATE
	 ,'BULK_DATA' LAST_UPDATE_BY
	 ,[ORDER]
	 ,'Diprocom' [OWNER]
	 ,CODE_SKU [OWNER_ID]
	FROM OPENQUERY(DIPROCOM_SERVER, '
		SELECT 
			RTRIM(UVP.Codigo_Producto) AS [CODE_SKU]
			,RTRIM(UVP.UM_Destino) AS [CODE_PACK_UNIT_FROM]
			,RTRIM(UVP.UM_Origen) AS [CODE_PACK_UNIT_TO]
			,RTRIM(UVP.Factor_Conversion) AS [CONVERSION_FACTOR]
			,ROW_NUMBER() OVER (PARTITION BY RTRIM(Codigo_Producto) ORDER BY RTRIM(Factor_Conversion) ASC) [ORDER]
		FROM [SONDA].[dbo].[vsUNIDADES_DE_VENTA_PREVENTA] UVP
		UNION
		SELECT 
			RTRIM(UVP.Codigo_Producto) AS [CODE_SKU]
			,RTRIM(UVP.UM_Destino) AS [CODE_PACK_UNIT_FROM]
			,RTRIM(UVP.UM_Origen) AS [CODE_PACK_UNIT_TO]
			,RTRIM(UVP.Factor_Conversion) AS [CONVERSION_FACTOR]
			,ROW_NUMBER() OVER (PARTITION BY RTRIM(UVP.Codigo_Producto) ORDER BY RTRIM(UVP.Factor_Conversion) ASC) +
			(CASE 
				WHEN EXISTS (SELECT * FROM [SONDA].[dbo].[vsUNIDADES_DE_VENTA_PREVENTA] WHERE Codigo_Producto=UVP.Codigo_Producto)
				THEN 1
				ELSE 0
			END) [ORDER]
		FROM [SONDA].[dbo].[vsUNIDADES_DE_VENTA] UVP
		LEFT JOIN [SONDA].[dbo].[vsUNIDADES_DE_VENTA_PREVENTA] UV 
			ON ( RTRIM(UV.Codigo_Producto) = RTRIM(UVP.Codigo_Producto)
				AND RTRIM(UV.UM_Destino) = RTRIM(UVP.UM_Destino)
				AND RTRIM(UV.UM_Origen) = RTRIM(UVP.UM_Origen))
		WHERE ISNULL(UVP.UM_Destino,''0'')<>''0'' AND ISNULL(UVP.UM_Origen,''0'')<>''0'' 
			AND UV.Codigo_Producto IS NULL
	')