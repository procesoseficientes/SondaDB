

-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	23-01-2016
-- Description:			Obtiene todos los clientes del ERP

--Modificaion 26-02-2016
--Se agrego campos de meses de credito y  dias de credito

--Modificaion   hector.gonzalez
--Fecha:        27-11-2016
--Descripcion:  Se agrego columna RGA_CODE

-- Modificacion 28-Feb-17 @ A-Team Sprint Donkor
					-- alberto.ruiz
					-- Se agregaron columas de organizacion de ventas y payment_conditos

-- Modificacion 3/14/2017 @ A-Team Sprint Ebonne
					-- rodrigo.gomez
					-- Se agregaron las columnas OWNER y [OWNER_ID]

-- Modificacion 04-May-17 @ A-Team Sprint Hondo
					-- alberto.ruiz
					-- Se agrego columna de balance

	-- Modificacion 8/31/2017 @ A-Team Sprint 
					-- diego.as
					-- Se agrega columna CODE_CUSTOMER_ALTERNATE

/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [SONDA].[ERP_VIEW_COSTUMER]
*/
-- =============================================
CREATE VIEW [SONDA].[ERP_VIEW_COSTUMER]
AS
SELECT
  [C].[CUSTOMER]
 ,[C].[CODE_CUSTOMER]
 ,[C].[NAME_CUSTOMER]
 ,[C].[PHONE_CUSTOMER]
 ,[C].[ADRESS_CUSTOMER]
 ,[C].[CLASSIFICATION_CUSTOMER]
 ,[C].[CONTACT_CUSTOMER]
 ,[C].[CODE_ROUTE]
 ,[C].[LAST_UPDATE_BY]
 ,[C].[LAST_UPDATE]
 ,[C].[SELLER_DEFAULT_CODE]
 ,999999 [CREDIT_LIMIT]
 ,[C].[FROM_ERP]
 ,[C].[NAME_ROUTE]
 ,[C].[NAME_CLASSIFICATION]
 ,[C].[GPS]
 ,[C].[LATITUDE]
 ,[C].[LONGITUDE]
 ,[C].[FREQUENCY]
 ,[C].[SUNDAY]
 ,[C].[MONDAY]
 ,[C].[TUESDAY]
 ,[C].[WEDNESDAY]
 ,[C].[THURSDAY]
 ,[C].[FRIDAY]
 ,[C].[SATURDAY]
 ,[C].[SCOUTING_ROUTE]
 ,[C].[EXTRA_DAYS]
 ,[C].[EXTRA_MONT]
 ,[C].[DISCOUNT]
 ,[C].[OFIVENTAS]
 ,[C].[RUTAVENTAS]
 ,[C].[RUTAENTREGA]
 ,[C].[SECUENCIA]
 ,[C].[RGA_CODE]
 ,[C].[ORGANIZACION_VENTAS]
 ,[C].[PAYMENT_CONDITIONS]
 ,[C].[OWNER]
 ,[C].[OWNER_ID]
 ,[C].[BALANCE]
 ,[C].[TAX_ID] [TAX_ID_NUMBER]
 ,[C].[INVOICE_NAME]
 ,[C].[DEPARTAMENT]
 ,[c].[MUNICIPALITY]
 ,[C].[COLONY]
 ,[C].[CODE_CUSTOMER_ALTERNATE]
 ,'' AS [GROUP_NUM]
 ,[C].[SPECIAL_MARKER] AS [SPECIAL_MARKER]
FROM [SONDA].[SWIFT_ERP_CUSTOMERS] [C]