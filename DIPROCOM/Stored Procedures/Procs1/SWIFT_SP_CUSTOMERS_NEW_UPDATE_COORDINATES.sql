﻿-- =============================================
-- Autor:				PEDRO LOUKOTA
-- Fecha de Creacion: 	25-11-2015
-- Description:			ACTUALIZA COORDENADAS DEL SCOUTING

-- Modificacion:	25-06-2016
--			Autor: 	diego.as
--			Description: Se agregaron las columnas [DEPARTAMENT], [MUNICIPALITY], [COLONY] para las inserte como 'NO ESPECIFICADO'

/*
-- Ejemplo de Ejecucion:				
				--
				exec [acsa].[SWIFT_SP_CUSTOMERS_NEW_UPDATE_COORDINATES]
										@GPS = ''
										,@USER VARCHAR(50)
										,@CUSTOMER = ''
				--				
*/
-- =============================================

CREATE PROCEDURE [acsa].[SWIFT_SP_CUSTOMERS_NEW_UPDATE_COORDINATES]
	@GPS VARCHAR(max)
	,@USER VARCHAR(50)
	,@CUSTOMER INT
	,@IS_FROM VARCHAR(50)
AS
BEGIN
TRY
	SET NOCOUNT ON;
	--

	IF(@IS_FROM = 'SONDA_CORE') BEGIN

	UPDATE [acsa].[SWIFT_CUSTOMERS_NEW]
	SET [GPS] =  REPLACE(@GPS,' ','')
		,[LAST_UPDATE] = GETDATE()
		,[LAST_UPDATE_BY] = @USER
		,[LATITUDE] = RTRIM(LTRIM(SUBSTRING(@GPS,1,CHARINDEX(',',@GPS) - 1)))
		,[LONGITUDE] = RTRIM(LTRIM(SUBSTRING(@GPS,CHARINDEX(',',@GPS) + 1,LEN(@GPS))))
		,[DEPARTAMENT] = 'NO ESPECIFICADO'
		,[MUNICIPALITY] = 'NO ESPECIFICADO'
		,[COLONY]='NO ESPECIFICADO'
	WHERE [CUSTOMER] = @CUSTOMER
	END 
	ELSE BEGIN
	UPDATE [acsa].[SONDA_CUSTOMER_NEW]
	SET [GPS] = @GPS
	,[LAST_UPDATE] = GETDATE()
		,[LAST_UPDATE_BY] = @USER
		,[LATITUDE] = RTRIM(LTRIM(SUBSTRING(@GPS,1,CHARINDEX(',',@GPS) - 1)))
		,[LONGITUDE] = RTRIM(LTRIM(SUBSTRING(@GPS,CHARINDEX(',',@GPS) + 1,LEN(@GPS))))
		,[DEPARTAMENT] = 'NO ESPECIFICADO'
		,[MUNICIPALITY] = 'NO ESPECIFICADO'
		,[COLONY]='NO ESPECIFICADO'
	WHERE [CUSTOMER_ID] = @CUSTOMER
	END
	--
	IF @@error = 0 BEGIN
		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  0 Codigo, '0' DbData
	END		
	ELSE BEGIN		
		SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo
	END
END TRY
BEGIN CATCH     
	 SELECT  -1 as Resultado , ERROR_MESSAGE() Mensaje ,  @@ERROR Codigo 
END CATCH

