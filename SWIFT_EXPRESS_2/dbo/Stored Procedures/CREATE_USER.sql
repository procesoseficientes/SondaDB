﻿CREATE PROC [dbo].[CREATE_USER]
@USER VARCHAR(150),
@PASSWORD VARCHAR(150)
AS
DECLARE @SQL NVARCHAR(MAX)
DECLARE @SCHEMA NVARCHAR(MAX)
DECLARE @PERMISSIONS NVARCHAR(MAX)

SET @SCHEMA = 'CREATE SCHEMA ['+@USER+']'
EXEC (@SCHEMA)
SET @SQL = 
	'CREATE LOGIN ['+@USER+']'+
	' WITH PASSWORD=N'''+@PASSWORD+''', 
	DEFAULT_DATABASE=[SWIFT_EXPRESS], 
	DEFAULT_LANGUAGE=[Español], 
	CHECK_EXPIRATION=OFF, 
	CHECK_POLICY=OFF
	CREATE USER '+@USER+' FOR LOGIN '+@USER+' WITH DEFAULT_SCHEMA='+@USER+';' 
	
EXEC(@SQL)

SET @PERMISSIONS = 
'
USE [SWIFT_EXPRESS]'+
'ALTER AUTHORIZATION ON SCHEMA::['+@USER+'] TO ['+@USER+']'+
'GRANT INSERT ON [dbo].[SWIFT_USER] TO ['+@USER+']'+
'GRANT SELECT ON [dbo].[SWIFT_USER] TO ['+@USER+']'+
'GRANT UPDATE ON [dbo].[SWIFT_USER] TO ['+@USER+']'
EXEC (@PERMISSIONS)

--EXEC sp_addrolemember N''db_accessadmin'', N'''+@USER+'''
--EXEC sp_addrolemember N''db_ddladmin'', N'''+@USER+'''
--EXEC sp_addrolemember N''db_datawriter'', N'''+@USER+''''+