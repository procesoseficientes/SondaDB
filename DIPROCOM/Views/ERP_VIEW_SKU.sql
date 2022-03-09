﻿
-- =============================================
-- Autor:				ppablo.loukota
-- Fecha de Creacion: 	18-12-2015
-- Description:			Vista que obtiene detalles de SKU 

-- modificacion 26-01-2016
-- alberto.ruiz
-- Se corrigio la columna de CODE_PROVIDER

-- modificacion 23-05-2016
-- alberto.ruiz
-- Se agrego la columna de USE_LINE_PICKING

-- Modificacion 27-05-2016
-- alberto.ruiz
-- Se agrego que tomara los campos de volumen, peso y medidas

-- Modificacion 3/13/2017 @ A-Team Sprint Ebonne
-- rodrigo.gomez
-- Se pusieron como referencias las vistas en la base de datos SAP_INTERCOMPANY
/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [DIPROCOM].[ERP_VIEW_SKU]
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_VIEW_SKU]
AS
SELECT DISTINCT
  SKU,
  CODE_SKU,
  DESCRIPTION_SKU,
  BARCODE_SKU,
  NAME_PROVIDER,
  COST,
  LIST_PRICE,
  MEASURE,
  NAME_CLASIFICATION,
  UNIT_MEASURE_SKU,
  WEIGHT_SKU,
  VOLUME_SKU,
  LONG_SKU,
  WIDTH_SKU,
  HIGH_SKU,
  VALUE_TEXT_CLASSIFICATION,
  HANDLE_SERIAL_NUMBER,
  HANDLE_BATCH,
  FROM_ERP,
  PRICE,
  LIST_NUM,
  CODE_PROVIDER,
  LAST_UPDATE,
  LAST_UPDATE_BY,
  CODE_FAMILY_SKU,
  LINE_PICKING,
  VOLUME_CODE_UNIT,
  VOLUME_NAME_UNIT,
  OWNER,
  OWNER_ID,
  ART_CODE,
  VAT_CODE
FROM OPENQUERY(DIPROCOM_SERVER, '

SELECT 
	''-1'' COLLATE SQL_Latin1_General_CP1_CI_AS AS SKU
	,CONVERT(VARCHAR(50),RTRIM(sku.Codigo_Producto)) COLLATE SQL_Latin1_General_CP1_CI_AS AS CODE_SKU
	,CONVERT(VARCHAR(MAX),RTRIM(sku.Nombre)) COLLATE SQL_Latin1_General_CP1_CI_AS AS DESCRIPTION_SKU
	,RTRIM(sku.Codigo_Producto) COLLATE SQL_Latin1_General_CP1_CI_AS AS BARCODE_SKU
	,CAST(NULL AS VARCHAR) COLLATE SQL_Latin1_General_CP1_CI_AS AS NAME_PROVIDER
	,CONVERT(FLOAT,0) AS ''COST''
	,CONVERT(NUMERIC(18, 2), 0) AS LIST_PRICE
	,CONVERT(VARCHAR(50),'''') COLLATE SQL_Latin1_General_CP1_CI_AS AS MEASURE
	,CONVERT(VARCHAR(150),'''') COLLATE SQL_Latin1_General_CP1_CI_AS AS NAME_CLASSIFICATION
	,CONVERT(INT, ISNULL(0, 0)) AS UNIT_MEASURE_SKU
	,CONVERT([numeric](18, 2), 0) AS WEIGHT_SKU
	,CONVERT([numeric](18, 2), 0) AS VOLUME_SKU
	,CONVERT([numeric](18, 2), 0) AS LONG_SKU
	,CONVERT([numeric](18, 2), 0) AS WIDTH_SKU
	,CONVERT([numeric](18, 2), 0) AS HIGH_SKU
	,RTRIM(sku.Codigo_Familia) COLLATE SQL_Latin1_General_CP1_CI_AS AS VALUE_TEXT_CLASSIFICATION
	,''0'' COLLATE SQL_Latin1_General_CP1_CI_AS AS HANDLE_SERIAL_NUMBER
	,''0'' COLLATE SQL_Latin1_General_CP1_CI_AS AS HANDLE_BATCH
	,CONVERT(VARCHAR(2),1) COLLATE SQL_Latin1_General_CP1_CI_AS AS FROM_ERP
	,1 AS PRICE
	,1 AS LIST_NUM
	,CAST(NULL AS VARCHAR) COLLATE SQL_Latin1_General_CP1_CI_AS AS CODE_PROVIDER
	,CAST(NULL AS DATETIME) LAST_UPDATE
	,CAST(NULL AS VARCHAR) COLLATE SQL_Latin1_General_CP1_CI_AS AS LAST_UPDATE_BY
	,RTRIM(sku.Codigo_Familia) AS CODE_FAMILY_SKU
	,0 AS USE_LINE_PICKING
	,CONVERT(VARCHAR,''Sin Medida'') AS VOLUME_CODE_UNIT
	,CONVERT(VARCHAR,''Sin Medida'') AS VOLUME_NAME_UNIT
	,''Diprocom'' AS OWNER
	,CONVERT(VARCHAR(50),RTRIM(sku.Codigo_Producto)) COLLATE SQL_Latin1_General_CP1_CI_AS AS OWNER_ID
	,NULL AS ART_CODE
	,CASE RTRIM(sku.PAGA_IMPUESTOS) WHEN ''S'' THEN ''I'' ELSE ''E'' END AS VAT_CODE
FROM [SONDA].[dbo].[vsMAESTRO_PRODUCTOS] AS sku

UNION

SELECT 
	''-1'' COLLATE SQL_Latin1_General_CP1_CI_AS AS SKU
	,CONVERT(VARCHAR(50),RTRIM(sku.Codigo_Producto)) COLLATE SQL_Latin1_General_CP1_CI_AS AS CODE_SKU
	,CONVERT(VARCHAR(MAX),RTRIM(sku.Nombre)) COLLATE SQL_Latin1_General_CP1_CI_AS AS DESCRIPTION_SKU
	,RTRIM(sku.Codigo_Producto) COLLATE SQL_Latin1_General_CP1_CI_AS AS BARCODE_SKU
	,CAST(NULL AS VARCHAR) COLLATE SQL_Latin1_General_CP1_CI_AS AS NAME_PROVIDER
	,CONVERT(FLOAT,0) AS ''COST''
	,CONVERT(NUMERIC(18, 2), 0) AS LIST_PRICE
	,CONVERT(VARCHAR(50),'''') COLLATE SQL_Latin1_General_CP1_CI_AS AS MEASURE
	,CONVERT(VARCHAR(150),'''') COLLATE SQL_Latin1_General_CP1_CI_AS AS NAME_CLASSIFICATION
	,CONVERT(INT, ISNULL(0, 0)) AS UNIT_MEASURE_SKU
	,CONVERT([numeric](18, 2), 0) AS WEIGHT_SKU
	,CONVERT([numeric](18, 2), 0) AS VOLUME_SKU
	,CONVERT([numeric](18, 2), 0) AS LONG_SKU
	,CONVERT([numeric](18, 2), 0) AS WIDTH_SKU
	,CONVERT([numeric](18, 2), 0) AS HIGH_SKU
	,RTRIM(sku.Codigo_Familia) COLLATE SQL_Latin1_General_CP1_CI_AS AS VALUE_TEXT_CLASSIFICATION
	,''0'' COLLATE SQL_Latin1_General_CP1_CI_AS AS HANDLE_SERIAL_NUMBER
	,''0'' COLLATE SQL_Latin1_General_CP1_CI_AS AS HANDLE_BATCH
	,CONVERT(VARCHAR(2),1) COLLATE SQL_Latin1_General_CP1_CI_AS AS FROM_ERP
	,1 AS PRICE
	,1 AS LIST_NUM
	,CAST(NULL AS VARCHAR) COLLATE SQL_Latin1_General_CP1_CI_AS AS CODE_PROVIDER
	,CAST(NULL AS DATETIME) LAST_UPDATE
	,CAST(NULL AS VARCHAR) COLLATE SQL_Latin1_General_CP1_CI_AS AS LAST_UPDATE_BY
	,RTRIM(sku.Codigo_Familia) AS CODE_FAMILY_SKU
	,0 AS USE_LINE_PICKING
	,CONVERT(VARCHAR,''Sin Medida'') AS VOLUME_CODE_UNIT
	,CONVERT(VARCHAR,''Sin Medida'') AS VOLUME_NAME_UNIT
	,''Diprocom'' AS OWNER
	,CONVERT(VARCHAR(50),RTRIM(sku.Codigo_Producto)) COLLATE SQL_Latin1_General_CP1_CI_AS AS OWNER_ID
	,NULL AS ART_CODE
	,CASE RTRIM(sku.PAGA_IMPUESTOS) WHEN ''S'' THEN ''I'' ELSE ''E'' END AS VAT_CODE
FROM [SONDA].[dbo].[vsMAESTRO_PRODUCTOS_PREVENTA] AS sku
'
)