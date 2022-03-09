
go
/****** Object:  LinkedServer [DIPROCOM_SERVER]    Script Date: 2/17/2022 5:45:38 PM ******/
EXEC sp_addlinkedserver @server = N'DIPROCOM_SERVER', @srvproduct=N'SQLSERVER', @provider=N'SQLNCLI', @datasrc=N'200.107.233.44'
GO
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC sp_addlinkedsrvlogin @rmtsrvname=N'DIPROCOM_SERVER',@useself=N'False',@locallogin=NULL,@rmtuser=N'sonda',@rmtpassword='d1pr0c0m@'
GO

EXEC sp_serveroption @server=N'DIPROCOM_SERVER', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC sp_serveroption @server=N'DIPROCOM_SERVER', @optname=N'data access', @optvalue=N'true'
GO

EXEC sp_serveroption @server=N'DIPROCOM_SERVER', @optname=N'dist', @optvalue=N'false'
GO

EXEC sp_serveroption @server=N'DIPROCOM_SERVER', @optname=N'pub', @optvalue=N'false'
GO

EXEC sp_serveroption @server=N'DIPROCOM_SERVER', @optname=N'rpc', @optvalue=N'true'
GO

EXEC sp_serveroption @server=N'DIPROCOM_SERVER', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC sp_serveroption @server=N'DIPROCOM_SERVER', @optname=N'sub', @optvalue=N'false'
GO

EXEC sp_serveroption @server=N'DIPROCOM_SERVER', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC sp_serveroption @server=N'DIPROCOM_SERVER', @optname=N'collation name', @optvalue=null
GO

EXEC sp_serveroption @server=N'DIPROCOM_SERVER', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC sp_serveroption @server=N'DIPROCOM_SERVER', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC sp_serveroption @server=N'DIPROCOM_SERVER', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC sp_serveroption @server=N'DIPROCOM_SERVER', @optname=N'remote proc transaction promotion', @optvalue=N'false'
GO


