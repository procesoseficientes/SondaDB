



-- =============================================
-- Autor:				        hector.gonzalez
-- Fecha de Creacion: 	2016-08-16
-- Description:			    Vista que obtiene los vendedores 

-- MODIFICADO 18-08-2016
--		diego.as
--		Se agregaron los campos SELLER_TYPE, SELLER_TYPE_DESCRIPTION, CODE_ROUTE, NAME_ROUTE, CODE_WAREHOUSE, NAME_WAREHOUSE a la vista

-- Modificacion 3/13/2017 @ A-Team Sprint Ebonne
-- diego.as
-- Se modifica para que apunte a la BD SAP_INTERCOMPANY

-- Modificacion 4/21/2017 @ A-Team Sprint Hondo
-- rodrigo.gomez
-- Se agregaron las referencias de MasterId, Owner y Owner_Id

-- Modificacion 08-Jun-17 @ A-Team Sprint Jibade
-- alberto.ruiz
-- Se agrega campo de source
/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [DIPROCOM].[ERP_VIEW_SELLER]
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_VIEW_SELLER]
AS
	SELECT 
		SELLER_CODE,
		SELLER_NAME,
		SELLER_TYPE_DESCRIPTION,
		CODE_ROUTE,
		NAME_ROUTE,
		CODE_WAREHOUSE,
		NAME_WAREHOUSE,
		OWNER,
		OWNER_ID,
		GPS,
		SOURCE
	FROM OPENQUERY(DIPROCOM_SERVER,'
		SELECT 
			RTRIM(CODIGO_VENDEDOR) AS SELLER_CODE
			,RTRIM(NOMBRE_VENDEDOR) AS SELLER_NAME
			,NULL AS SELLER_TYPE_DESCRIPTION
			,NULL AS CODE_ROUTE
			,NULL AS NAME_ROUTE
			,NULL AS CODE_WAREHOUSE
			,NULL AS NAME_WAREHOUSE
			,''Diprocom'' AS OWNER
			,RTRIM(CODIGO_VENDEDOR) AS OWNER_ID
			,''0,0'' AS GPS
			,''Diprocom'' AS SOURCE
		FROM [SONDA].[dbo].[vsVENDEDORES]
		UNION
		SELECT 
			RTRIM(CODIGO_VENDEDOR) AS SELLER_CODE
			,RTRIM(NOMBRE_VENDEDOR) AS SELLER_NAME
			,NULL AS SELLER_TYPE_DESCRIPTION
			,NULL AS CODE_ROUTE
			,NULL AS NAME_ROUTE
			,NULL AS CODE_WAREHOUSE
			,NULL AS NAME_WAREHOUSE
			,''Diprocom'' AS OWNER
			,RTRIM(CODIGO_VENDEDOR) AS OWNER_ID
			,''0,0'' AS GPS
			,''Diprocom'' AS SOURCE
		FROM [SONDA].[dbo].[vsVENDEDORES_PREVENTA]
	')