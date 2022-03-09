


-- =============================================
-- Autor:				joel.delcompare
-- Fecha de Creacion: 	11-09-2015
-- Description:			Vista que obtiene los clientes de sap

-- Modificacion 11-09-2015
-- joel.delcompare
-- se cambio el SELLER_DEFAULT_CODE por el codigo del vendedor  dado que estaba usando el nombre 
-- Modificacion 23-01-2016
-- alberto.ruiz
-- Se agregaron los campos de latitud, longitud, frecuancia y dias de visita
--,/*c.CreditLine*/99999 AS CREDIT_LIMIT     sustituir para regresar la vista a su estado normal
-- Modificacion 06-04-2016
-- hector.gonzalez
-- Se agrego el campo "Discount" de la tabla "OCRD" con el alias de "DISCOUNT".
-- Modificado 2016-05-02
-- joel.delcompare
-- Se agregaron los campos U_RTOfiVentas                                U_RTRutaVentas                               U_RTRutaEntrega                               U_RTSecuencia 
-- Modificacion 01-08-2016  
-- alberto.ruiz
-- Se agrego isnull al nombre del cliente

-- Modificacion 27-11-2016  
-- hector.gonzalez
-- Se agrego la columna itemCode

-- Modificacion 28-Feb-17 @ A-Team Sprint Donkor
-- alberto.ruiz
-- Se agregaron los campos de organizacion de ventas y payment_conditions

-- Modificacion 3/13/2017 @ A-Team Sprint Ebonne
-- diego.as
-- Se modifica para que apunte a la BD SAP_INTERCOMPANY

-- Modificacion 4/20/2017 @ A-Team Sprint Hondo
-- rodrigo.gomez
-- Se agregaron las nuevas validaciones con MasterID y Owner
/*
-- Ejemplo de Ejecucion:
		--
        SELECT * FROM [DIPROCOM].[ERP_VIEW_COSTUMER] WHERE CODE_CUSTOMER = '2324'
*/
--================U_RTRutaVentas ===============
CREATE VIEW [DIPROCOM].[ERP_VIEW_COSTUMER]
AS
	SELECT
	   [CUSTOMER] ,
       [CODE_CUSTOMER] ,
       [SWIFT_INTERFACES].[dbo].[FUNC_REMOVE_SPECIAL_CHARS]( [NAME_CUSTOMER]) [NAME_CUSTOMER],
       [PHONE_CUSTOMER] ,
       [ADRESS_CUSTOMER] ,
      [SWIFT_INTERFACES].[dbo].[FUNC_REMOVE_SPECIAL_CHARS]( [CLASSIFICATION_CUSTOMER]) [CLASSIFICATION_CUSTOMER] ,
       [SWIFT_INTERFACES].[dbo].[FUNC_REMOVE_SPECIAL_CHARS]([CONTACT_CUSTOMER] )[CONTACT_CUSTOMER] ,
       [CODE_ROUTE] ,
       [LAST_UPDATE] ,
       [LAST_UPDATE_BY] ,
       [SELLER_DEFAULT_CODE] ,
       [CREDIT_LIMIT] ,
       [FROM_ERP] ,
       [NAME_ROUTE] ,
       [NAME_CLASSIFICATION] ,
       [LATITUDE] ,
       [LONGITUDE] ,
       [FREQUENCY] ,
       [SUNDAY] ,
       [MONDAY] ,
       [TUESDAY] ,
       [WEDNESDAY] ,
       [THURSDAY] ,
       [FRIDAY] ,
       [SATURDAY] ,
       [SCOUTING_ROUTE] ,
       [GROUP_NUM] ,
       [EXTRA_DAYS] ,
       [EXTRA_MONT] ,
       [DISCOUNT] ,
       [OFICINA_VENTAS] ,
       [RUTA_VENTAS] ,
       [RUTA_ENTREGA] ,
       [SECUENCIA] ,
       [RGA_CODE] ,
       [PAYMENT_CONDITIONS] ,
       [ORGANIZACION_VENTAS] ,
       [OWNER] ,
       [OWNER_ID] ,
       [BALANCE] ,
       [TAX_ID] ,
       [SWIFT_INTERFACES].[dbo].[FUNC_REMOVE_SPECIAL_CHARS]([INVOICE_NAME])[INVOICE_NAME]  ,
       [CODE_CUSTOMER_ALTERNATE],
	   SPECIAL_MARKER
	FROM OPENQUERY(DIPROCOM_SERVER, '
		SELECT
			''-1'' COLLATE SQL_Latin1_General_CP1_CI_AS AS CUSTOMER 
			,cast(c.Codigo as varchar) COLLATE SQL_Latin1_General_CP1_CI_AS AS CODE_CUSTOMER
			,RTRIM(c.Nombre_Comercial) COLLATE SQL_Latin1_General_CP1_CI_AS AS NAME_CUSTOMER
			,RTRIM(c.Telefono) COLLATE SQL_Latin1_General_CP1_CI_AS AS PHONE_CUSTOMER
			,RTRIM(c.Direccion) COLLATE SQL_Latin1_General_CP1_CI_AS AS ADRESS_CUSTOMER
			, ''7'' AS CLASSIFICATION_CUSTOMER
			,RTRIM(c.Contacto) COLLATE SQL_Latin1_General_CP1_CI_AS AS CONTACT_CUSTOMER
			,cast(NULL as varchar) AS CODE_ROUTE
			,GETDATE() AS LAST_UPDATE
			,''BULKDATA'' AS LAST_UPDATE_BY
			,cast(c.Codigo_Vendedor as varchar) COLLATE SQL_Latin1_General_CP1_CI_AS AS SELLER_DEFAULT_CODE
			,c.Limite_Credito AS CREDIT_LIMIT
			, 1 AS FROM_ERP 
			,CAST(null as varchar) NAME_ROUTE
			,CAST(null as varchar) NAME_CLASSIFICATION
			,RTRIM(c.Latitud) LATITUDE
			,RTRIM(c.Longitud) LONGITUDE
			,0 FREQUENCY
			,0 SUNDAY
			,0 MONDAY
			,0 TUESDAY
			,0 WEDNESDAY
			,0 THURSDAY
			,0 FRIDAY
			,0 SATURDAY
			,cast(c.Codigo_Vendedor as varchar) SCOUTING_ROUTE
			,RTRIM(c.Condicion_Pago) AS GROUP_NUM
			,c.Dias_Credito AS EXTRA_DAYS
			,0 AS EXTRA_MONT
			,0 AS DISCOUNT
			,NULL AS OFICINA_VENTAS
			,NULL AS RUTA_VENTAS
			,NULL AS RUTA_ENTREGA
			,NULL AS SECUENCIA
			,CAST(c.Codigo as varchar) AS RGA_CODE 
			,CAST(NULL AS VARCHAR(250)) AS [PAYMENT_CONDITIONS]
			,CAST(NULL AS VARCHAR(250)) AS [ORGANIZACION_VENTAS]
			,''Diprocom'' AS OWNER
			,CAST(c.Codigo as varchar) COLLATE SQL_Latin1_General_CP1_CI_AS AS OWNER_ID
			,0 BALANCE
			,RTRIM(RTN) COLLATE SQL_Latin1_General_CP1_CI_AS AS TAX_ID
			,RTRIM(c.Nombre) COLLATE SQL_Latin1_General_CP1_CI_AS AS INVOICE_NAME
			,NULL as CODE_CUSTOMER_ALTERNATE
			,SPECIAL_MARKER
		FROM [SONDA].[dbo].[vsCLIENTES] c 

		UNION

		SELECT
			''-2'' COLLATE SQL_Latin1_General_CP1_CI_AS AS CUSTOMER 
			,cast(c.Codigo as varchar) COLLATE SQL_Latin1_General_CP1_CI_AS AS CODE_CUSTOMER
			,RTRIM(c.Nombre_Comercial) COLLATE SQL_Latin1_General_CP1_CI_AS AS NAME_CUSTOMER
			,RTRIM(c.Telefono) COLLATE SQL_Latin1_General_CP1_CI_AS AS PHONE_CUSTOMER
			,RTRIM(c.Direccion) COLLATE SQL_Latin1_General_CP1_CI_AS AS ADRESS_CUSTOMER
			, ''7'' AS CLASSIFICATION_CUSTOMER
			,RTRIM(c.Contacto) COLLATE SQL_Latin1_General_CP1_CI_AS AS CONTACT_CUSTOMER
			,cast(NULL as varchar) AS CODE_ROUTE
			,GETDATE() AS LAST_UPDATE
			,''BULKDATA'' AS LAST_UPDATE_BY
			,cast(c.Codigo_Vendedor as varchar) COLLATE SQL_Latin1_General_CP1_CI_AS AS SELLER_DEFAULT_CODE
			,c.Limite_Credito AS CREDIT_LIMIT
			, 1 AS FROM_ERP 
			,CAST(null as varchar) NAME_ROUTE
			,CAST(null as varchar) NAME_CLASSIFICATION
			,RTRIM(c.Latitud) LATITUDE
			,RTRIM(c.Longitud) LONGITUDE
			,0 FREQUENCY
			,0 SUNDAY
			,0 MONDAY
			,0 TUESDAY
			,0 WEDNESDAY
			,0 THURSDAY
			,0 FRIDAY
			,0 SATURDAY
			,cast(c.Codigo_Vendedor as varchar) SCOUTING_ROUTE
			,RTRIM(c.Condicion_Pago) AS GROUP_NUM
			,c.Dias_Credito AS EXTRA_DAYS
			,0 AS EXTRA_MONT
			,0 AS DISCOUNT
			,NULL AS OFICINA_VENTAS
			,NULL AS RUTA_VENTAS
			,NULL AS RUTA_ENTREGA
			,NULL AS SECUENCIA
			,CAST(c.Codigo as varchar) AS RGA_CODE 
			,CAST(NULL AS VARCHAR(250)) AS [PAYMENT_CONDITIONS]
			,CAST(NULL AS VARCHAR(250)) AS [ORGANIZACION_VENTAS]
			,''Diprocom'' AS OWNER
			,CAST(c.Codigo as varchar) COLLATE SQL_Latin1_General_CP1_CI_AS AS OWNER_ID
			,0 BALANCE
			,RTRIM(RTN) COLLATE SQL_Latin1_General_CP1_CI_AS AS TAX_ID
			,RTRIM(c.Nombre) COLLATE SQL_Latin1_General_CP1_CI_AS AS INVOICE_NAME
			,NULL as CODE_CUSTOMER_ALTERNATE
			,''0'' SPECIAL_MARKER
		FROM [SONDA].[dbo].[vsCLIENTES_PREVENTA] c 
		
	')