﻿CREATE PROC [SONDA].[SWIFT_SP_GET_CUSTOMER_BY_DATE]
@DATE VARCHAR(150) 
AS
--DECLARE @DATE VARCHAR(150) 
--SET @DATE = '2015-05-05'

DECLARE @columName varchar(10)
DECLARE @CODE_CUSTOMER VARCHAR(50)

SELECT @columName = CASE DATEPART(WEEKDAY,@DATE)  
    WHEN 7 THEN 'SUNDAY' 
    WHEN 1 THEN 'MONDAY' 
    WHEN 2 THEN 'TUESDAY' 
    WHEN 3 THEN 'WEDNESDAY' 
    WHEN 4 THEN 'THURSDAY' 
    WHEN 5 THEN 'FRIDAY' 
    WHEN 6 THEN 'SATURDAY' 
END

PRINT @columName
IF (@columName = 'MONDAY')
BEGIN
	SELECT 
		B.CUSTOMER,
		A.CODE_CUSTOMER,
		B.NAME_CUSTOMER,
		B.PHONE_CUSTOMER 
	FROM 
		[SONDA].SWIFT_CUSTOMER_FREQUENCY A, 
		[SONDA].SWIFT_VIEW_CUSTOMERS B 
	WHERE 
		A.MONDAY = '1' 
		AND A.CODE_CUSTOMER = B.CODE_CUSTOMER
END
IF (@columName = 'TUESDAY')
BEGIN
	SELECT 
		B.CUSTOMER,
		A.CODE_CUSTOMER,
		B.NAME_CUSTOMER,
		B.PHONE_CUSTOMER 
	FROM 
		[SONDA].SWIFT_CUSTOMER_FREQUENCY A, 
		[SONDA].SWIFT_VIEW_CUSTOMERS B 
	WHERE 
		A.TUESDAY = '1' 
		AND A.CODE_CUSTOMER = B.CODE_CUSTOMER 
END
IF (@columName = 'WEDNESDAY')
BEGIN
	SELECT 
		B.CUSTOMER,
		A.CODE_CUSTOMER,
		B.NAME_CUSTOMER,
		B.PHONE_CUSTOMER 
	FROM 
		[SONDA].SWIFT_CUSTOMER_FREQUENCY A, 
		[SONDA].SWIFT_VIEW_CUSTOMERS B 
	WHERE 
		A.WEDNESDAY = '1' 
		AND A.CODE_CUSTOMER = B.CODE_CUSTOMER
END
IF (@columName = 'THURSDAY')
BEGIN
	SELECT 
		B.CUSTOMER,
		A.CODE_CUSTOMER,
		B.NAME_CUSTOMER,
		B.PHONE_CUSTOMER 
	FROM 
		[SONDA].SWIFT_CUSTOMER_FREQUENCY A, 
		[SONDA].SWIFT_VIEW_CUSTOMERS B 
	WHERE 
		A.THURSDAY = '1' 
		AND A.CODE_CUSTOMER = B.CODE_CUSTOMER 
END
IF (@columName = 'FRIDAY')
BEGIN
	SELECT 
		B.CUSTOMER,
		A.CODE_CUSTOMER,
		B.NAME_CUSTOMER,
		B.PHONE_CUSTOMER 
	FROM 
		[SONDA].SWIFT_CUSTOMER_FREQUENCY A, 
		[SONDA].SWIFT_VIEW_CUSTOMERS B 
	WHERE 
		A.FRIDAY = '1' 
		AND A.CODE_CUSTOMER = B.CODE_CUSTOMER 
END
IF (@columName = 'SATURDAY')
BEGIN
	SELECT 
		B.CUSTOMER,
		A.CODE_CUSTOMER,
		B.NAME_CUSTOMER,
		B.PHONE_CUSTOMER 
	FROM 
		[SONDA].SWIFT_CUSTOMER_FREQUENCY A, 
		[SONDA].SWIFT_VIEW_CUSTOMERS B 
	WHERE 
		A.SATURDAY = '1' 
		AND A.CODE_CUSTOMER = B.CODE_CUSTOMER 
END
IF (@columName = 'SUNDAY')
BEGIN
	SELECT 
		B.CUSTOMER,
		A.CODE_CUSTOMER,
		B.NAME_CUSTOMER,
		B.PHONE_CUSTOMER 
	FROM 
		[SONDA].SWIFT_CUSTOMER_FREQUENCY A, 
		[SONDA].SWIFT_VIEW_CUSTOMERS B 
	WHERE 
		A.SUNDAY = '1' 
		AND A.CODE_CUSTOMER = B.CODE_CUSTOMER 
END









