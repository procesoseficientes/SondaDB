
go
/****** Object:  LinkedServer [ERPSERVER]    Script Date: 11/2/2017 9:40:05 AM ******/
EXEC sp_addlinkedserver @server = N'ERPSERVER', @srvproduct=N'SQL', @provider=N'SQLNCLI11', @datasrc=N'192.168.1.4'
GO
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC sp_addlinkedsrvlogin @rmtsrvname=N'ERPSERVER',@useself=N'False',@locallogin=NULL,@rmtuser=N'sa',@rmtpassword='Server1237710'

GO

EXEC sp_serveroption @server=N'ERPSERVER', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC sp_serveroption @server=N'ERPSERVER', @optname=N'data access', @optvalue=N'true'
GO

EXEC sp_serveroption @server=N'ERPSERVER', @optname=N'dist', @optvalue=N'false'
GO

EXEC sp_serveroption @server=N'ERPSERVER', @optname=N'pub', @optvalue=N'false'
GO

EXEC sp_serveroption @server=N'ERPSERVER', @optname=N'rpc', @optvalue=N'true'
GO

EXEC sp_serveroption @server=N'ERPSERVER', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC sp_serveroption @server=N'ERPSERVER', @optname=N'sub', @optvalue=N'false'
GO

EXEC sp_serveroption @server=N'ERPSERVER', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC sp_serveroption @server=N'ERPSERVER', @optname=N'collation name', @optvalue=NULL
GO

EXEC sp_serveroption @server=N'ERPSERVER', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC sp_serveroption @server=N'ERPSERVER', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC sp_serveroption @server=N'ERPSERVER', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC sp_serveroption @server=N'ERPSERVER', @optname=N'remote proc transaction promotion', @optvalue=N'false'
GO