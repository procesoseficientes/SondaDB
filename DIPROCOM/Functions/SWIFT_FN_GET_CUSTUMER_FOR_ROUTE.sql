﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	09-12-2015
-- Description:			Obtiene los clientes del día de una ruta

-- Modificacion 6/22/2017 @ A-Team Sprint Khalid
					-- rodrigo.gomez
					-- Se modifico el tamaño del campo TAX_ID_NUMBER

/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [PACASA].[SWIFT_FN_GET_CUSTUMER_FOR_ROUTE]('001')
*/
-- =============================================
CREATE FUNCTION [PACASA].[SWIFT_FN_GET_CUSTUMER_FOR_ROUTE]
(	
	@CODE_ROUTE varchar(50)
)
RETURNS @TbCustomer table
(
	CODE_CUSTOMER VARCHAR(100)
	,NAME_CUSTOMER VARCHAR(200)
	,TAX_ID_NUMBER VARCHAR(25)
	,ADRESS_CUSTOMER VARCHAR(MAX)
	,PHONE_CUSTOMER VARCHAR(100)
	,CONTACT_CUSTOMER VARCHAR(180)

)
AS
BEGIN
	--Obtiene Clientes asociados
	INSERT INTO @TbCustomer
	SELECT 
		CODE_CUSTOMER
		,dbo.FUNC_REMOVE_SPECIAL_CHARS(NAME_CUSTOMER) AS NAME_CUSTOMER
		,TAX_ID_NUMBER
		,dbo.FUNC_REMOVE_SPECIAL_CHARS(COALESCE(ADRESS_CUSTOMER,'')) AS ADRESS_CUSTOMER
		,COALESCE(PHONE_CUSTOMER,'') AS PHONE_CUSTOMER
		,dbo.FUNC_REMOVE_SPECIAL_CHARS(COALESCE(CONTACT_CUSTOMER,'')) AS CONTACT_CUSTOMER
	FROM [PACASA].SWIFT_VIEW_ALL_COSTUMER  inner join [PACASA].USERS ON 
	SELLER_DEFAULT_CODE = RELATED_SELLER 
	WHERE SELLER_ROUTE= @CODE_ROUTE

	--Obtiene Clientes de Tareas
	INSERT INTO @TbCustomer
	SELECT 
		CODE_CUSTOMER
		,dbo.FUNC_REMOVE_SPECIAL_CHARS(NAME_CUSTOMER) AS NAME_CUSTOMER
		,TAX_ID_NUMBER
		,dbo.FUNC_REMOVE_SPECIAL_CHARS(COALESCE(ADRESS_CUSTOMER,'')) AS ADRESS_CUSTOMER
		,COALESCE(PHONE_CUSTOMER,'') AS PHONE_CUSTOMER
		,dbo.FUNC_REMOVE_SPECIAL_CHARS(COALESCE(CONTACT_CUSTOMER,'')) AS CONTACT_CUSTOMER	
	FROM [PACASA].SWIFT_VIEW_ALL_COSTUMER VAC
		INNER JOIN [PACASA].[SONDA_ROUTE_PLAN] RP ON (VAC.CODE_CUSTOMER = RP.RELATED_CLIENT_CODE)
	WHERE RP.CODE_ROUTE= @CODE_ROUTE

	RETURN
END
