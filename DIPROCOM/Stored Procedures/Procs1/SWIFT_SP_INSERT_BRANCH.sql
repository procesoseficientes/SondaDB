﻿CREATE PROC [DIPROCOM].[SWIFT_SP_INSERT_BRANCH]
@BRANCH_CODE VARCHAR(50),
@CUSTOMER_CODE VARCHAR(50),
@BRANCH_PDE VARCHAR(50),
@BRANCH_NAME VARCHAR(150),
@BRANCH_ADDRESS VARCHAR(350),
@GEO_ROUTE VARCHAR(50),
@GPS_LAT_LON VARCHAR(150),
@PHONE VARCHAR(25),
@DELIVERY_EMAIL VARCHAR(200),
@RECOLLECT_EMAIL VARCHAR(200),
@STATUS VARCHAR(20),
@CONTACT_NAME VARCHAR(150),
@IS_DEFAULT INT,
@LAST_UPDATED_BY VARCHAR(25)
AS
INSERT INTO DIPROCOM.SWIFT_BRANCHES (
	BRANCH_CODE,
	CUSTOMER_CODE,
	BRANCH_PDE,
	BRANCH_NAME,
	BRANCH_ADDRESS,
	GEO_ROUTE,
	GPS_LAT_LON,
	PHONE,
	DELIVERY_EMAIL,
	RECOLLECT_EMAIL,
	[STATUS],
	CONTACT_NAME,
	IS_DEFAULT,
	LAST_UPDATED,
	LAST_UPDATED_BY)
VALUES (
	@BRANCH_CODE,
	@CUSTOMER_CODE,
	@BRANCH_PDE,
	@BRANCH_NAME,
	@BRANCH_ADDRESS,
	@GEO_ROUTE,
	@GPS_LAT_LON,
	@PHONE,
	@DELIVERY_EMAIL,
	@RECOLLECT_EMAIL,
	@STATUS,
	@CONTACT_NAME,
	@IS_DEFAULT,
	GETDATE(),
	@LAST_UPDATED_BY)



