﻿-- =============================================
-- Autor:				pedro.loukota
-- Fecha de Creacion: 	06-11-2015
-- Description:			inserta datos en la tabla de DIPROCOM clientes

--Modificado 05-05-2016
-- alberto.ruiz
-- Se agrego el parametro @USE_PACK_UNIT

  --Modificado 15-DEC-2016
-- alberto.ruiz
-- Se agrego el parametro @ZONE_ID

/*
-- Ejemplo de Ejecucion:
			EXEC [acsa].[INSERT_SP_USER]
				@LOGIN = 'PRUEBA@DIPROCOM'
				,@NAME_USER = 'prueba'
				,@TYPE_USER = 'prueba'
				,@PASSWORD = '123'
				,@CODE_ENTERPRISE = ''
				,@IMAGE = ''
				,@RELATED_SELLER = ''
				,@SELLER_ROUTE = ''
				,@USER_TYPE = ''
				,@DEFAULT_WAREHOUSE = ''
				,@PRESALE_WAREHOUSE = ''
				,@USER_ROLE = 1
				,@USE_PACK_UNIT = 1
			--
			SELECT * FROM [acsa].USERS WHERE [LOGIN] = 'PRUEBA@DIPROCOM'
			--
			DELETE [acsa].USERS WHERE [LOGIN] = 'PRUEBA@DIPROCOM'
*/
-- =============================================
CREATE PROCEDURE [acsa].INSERT_SP_USER @LOGIN VARCHAR(50)
, @NAME_USER VARCHAR(50)
, @TYPE_USER VARCHAR(50)
, @PASSWORD VARCHAR(50)
, @CODE_ENTERPRISE VARCHAR(50)
, @IMAGE VARCHAR(MAX)
, @RELATED_SELLER VARCHAR(50)
, @SELLER_ROUTE VARCHAR(50)
, @USER_TYPE VARCHAR(50)
, @DEFAULT_WAREHOUSE VARCHAR(50)
, @PRESALE_WAREHOUSE VARCHAR(50)
, @USER_ROLE NUMERIC(18, 0)
, @USE_PACK_UNIT INT = 0
  , @ZONE_ID INT = null
AS
BEGIN
  SET NOCOUNT ON;
  --

  IF @ZONE_ID < 1 BEGIN  
  	 SELECT @ZONE_ID = NULL
  END

  INSERT INTO [acsa].[USERS] ([LOGIN]
  , NAME_USER
  , TYPE_USER
  , [PASSWORD]
  , ENTERPRISE
  , [IMAGE]
  , RELATED_SELLER
  , SELLER_ROUTE
  , USER_TYPE
  , DEFAULT_WAREHOUSE
  , USER_ROLE
  , PRESALE_WAREHOUSE
  , USE_PACK_UNIT
  , [ZONE_ID])
    VALUES (@LOGIN, @NAME_USER, @TYPE_USER, @PASSWORD, @CODE_ENTERPRISE, @IMAGE, @RELATED_SELLER, @SELLER_ROUTE, @USER_TYPE, @DEFAULT_WAREHOUSE, @USER_ROLE, @PRESALE_WAREHOUSE, @USE_PACK_UNIT,@ZONE_ID)
END
