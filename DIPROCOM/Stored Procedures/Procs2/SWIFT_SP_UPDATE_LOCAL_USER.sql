﻿CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_UPDATE_LOCAL_USER]
@NAME VARCHAR(50),
@LOGIN VARCHAR(50),
@PASSWORD VARCHAR(50),
@CORRELATIVE INT,
@IMAGE VARCHAR(MAX),
@USER_TYPE VARCHAR(50),
@RELATED_SELLER VARCHAR(50),
@DEFAULT_WAREHOUSE VARCHAR(50),
@PRESALE_WAREHOUSE VARCHAR(50),
@USER_ROLE NUMERIC(18,0),
@SellerRoute varchar(50)
AS
UPDATE DIPROCOM.USERS SET 
	NAME_USER=@NAME, 
	[LOGIN]=@LOGIN, 
	[PASSWORD]=@PASSWORD, 
	[IMAGE] = @IMAGE,
	[USER_TYPE] = @USER_TYPE,
	[RELATED_SELLER] = @RELATED_SELLER,
	[DEFAULT_WAREHOUSE] = @DEFAULT_WAREHOUSE,
	[PRESALE_WAREHOUSE] = @PRESALE_WAREHOUSE,
	[USER_ROLE] = @USER_ROLE,
	SELLER_ROUTE = @SellerRoute
WHERE 
	CORRELATIVE=@CORRELATIVE

DECLARE @ENTERPRISE VARCHAR(50)

SELECT @ENTERPRISE = ENTERPRISE 
FROM DIPROCOM.USERS 
WHERE 
	CORRELATIVE= @CORRELATIVE
PRINT @ENTERPRISE


UPDATE dbo.SWIFT_USER SET 
	NAME_USER = @NAME, 
	[LOGIN]=@LOGIN, 
	[PASSWORD]=@PASSWORD ,
	[IMAGE] = @IMAGE,
	[USER_TYPE] = @USER_TYPE,
	[RELATED_SELLER] = @RELATED_SELLER,
	[DEFAULT_WAREHOUSE] = @DEFAULT_WAREHOUSE,
	[PRESALE_WAREHOUSE] = @PRESALE_WAREHOUSE,
	[USER_ROLE] = @USER_ROLE,
	SELLER_ROUTE = @SellerRoute
WHERE 
	USER_CORRELATIVE=@CORRELATIVE 
	AND CODE_ENTERPRISE = @ENTERPRISE 
--AND LOGIN=@LOGIN AND NAME_USER=@NAME
--AND PASSWORD=@PASSWORD

