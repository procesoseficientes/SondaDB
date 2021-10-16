/****** Object:  StoredProcedure [DIPROCOM].[SWIFT_SP_GET_USER_ALL_USER]    Script Date: 15/12/2015 9:09:38 AM ******/
-- =============================================
-- Autor:				JOSE ROBERTO
-- Fecha de Creacion: 	17-12-2015
-- Description:			Muestra	los usuarios con codigo y nombre

/*
-- Ejemplo de Ejecucion:				
				--
				 [DIPROCOM].[SWIFT_SP_GET_USER_ALL_USER]
				--				
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_USER_ALL_USER]	
AS
SELECT
	 [LOGIN]
	,[NAME_USER]
FROM [DIPROCOM].[USERS]


