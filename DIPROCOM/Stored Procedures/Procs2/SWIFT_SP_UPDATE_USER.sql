﻿-- =============================================
-- Autor:				rodrigo.gomez
-- Fecha de Creacion: 	12/29/2016 @ A-TEAM Sprint Balder
-- Description:			actualiza en ambas tablas de usuario

-- Modificacion 3/7/2017 @ A-Team Sprint Ebonne
					-- diego.as
					-- Se agrega propiedad CODE_PRICE_LIST

/*
-- Ejemplo de Ejecucion:
				EXEC [acsa].[SWIFT_SP_UPDATE_USER]
*/
-- =============================================
CREATE PROCEDURE [acsa].[SWIFT_SP_UPDATE_USER](
	@LOGIN varchar(50)
	,@NAME_USER varchar(50)
	,@TYPE_USER varchar(50)
	,@PASSWORD varchar(50)
	,@IMAGE varchar(max)
	,@RELATED_SELLER varchar(50) = NULL	
	,@SELLER_ROUTE varchar(50) = NULL	
	,@USER_TYPE varchar(50)
	,@DEFAULT_WAREHOUSE varchar(50) = NULL	
	,@USER_ROLE numeric
	,@PRESALE_WAREHOUSE nvarchar(50) = NULL	
	,@ROUTE_RETURN_WAREHOUSE varchar(50) = NULL	
	,@USE_PACK_UNIT INT	= NULL	
	,@ZONE_ID INT = NULL	
	,@DISTRIBUTION_CENTER_ID INT = NULL
	,@CODE_PRICE_LIST VARCHAR(25) = NULL
)
AS
BEGIN
	SET NOCOUNT ON;
	--
  DECLARE @CORRELATIVE INT
	--
	SELECT @CORRELATIVE = CORRELATIVE FROM [acsa].[USERS] WHERE [LOGIN] = @LOGIN
  --
	BEGIN TRY
		UPDATE [acsa].[USERS]
		SET		
			[LOGIN] = @LOGIN
			,[NAME_USER] = @NAME_USER
			,[TYPE_USER] = @TYPE_USER
			,[PASSWORD] = @PASSWORD
			,[IMAGE] = @IMAGE
			,[RELATED_SELLER] = @RELATED_SELLER
			,[SELLER_ROUTE] = @SELLER_ROUTE
			,[USER_TYPE] = @USER_TYPE
			,[DEFAULT_WAREHOUSE] = @DEFAULT_WAREHOUSE
			,[USER_ROLE] = @USER_ROLE
			,[PRESALE_WAREHOUSE] = @PRESALE_WAREHOUSE
			,[ROUTE_RETURN_WAREHOUSE] = @ROUTE_RETURN_WAREHOUSE
			,[USE_PACK_UNIT] = @USE_PACK_UNIT
			,[ZONE_ID] = @ZONE_ID
			,[DISTRIBUTION_CENTER_ID] = @DISTRIBUTION_CENTER_ID
			,[CODE_PRICE_LIST] = @CODE_PRICE_LIST
		WHERE @LOGIN = [LOGIN]

		UPDATE [dbo].[SWIFT_USER]
		SET
			[LOGIN]  = @LOGIN
			,[NAME_USER] = @NAME_USER
			,[TYPE_USER] = @TYPE_USER
			,[PASSWORD] = @PASSWORD
			,[IMAGE] = @IMAGE
			,[SELLER_ROUTE] = @SELLER_ROUTE
			,[RELATED_SELLER] = @RELATED_SELLER
			,[USER_TYPE] = @USER_TYPE
			,[DEFAULT_WAREHOUSE] = @DEFAULT_WAREHOUSE
			,[USER_ROLE] = @USER_ROLE
			,[PRESALE_WAREHOUSE] = @PRESALE_WAREHOUSE
			,[ROUTE_RETURN_WAREHOUSE] = @ROUTE_RETURN_WAREHOUSE
			,[USE_PACK_UNIT] = @USE_PACK_UNIT
			,[DISTRIBUTION_CENTER_ID] = @DISTRIBUTION_CENTER_ID
			,[CODE_PRICE_LIST] = @CODE_PRICE_LIST
		WHERE @LOGIN = [LOGIN]
		

		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo, '' DbData
	END TRY
	BEGIN CATCH
		SELECT  -1 as Resultado
		,CASE CAST(@@ERROR AS VARCHAR)
			WHEN '2627' THEN 'No se puede actualizar la tabla de Usuarios'
			ELSE ERROR_MESSAGE() 
		END Mensaje 
		,@@ERROR Codigo 
	END CATCH
END





