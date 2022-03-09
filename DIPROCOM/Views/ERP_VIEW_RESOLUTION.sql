
-- =============================================
-- Autor:				alejandro.ochoa
-- Fecha de Creacion: 	30-04-2018
-- Description:			Vista de Resoluciones

/*
-- Ejemplo de Ejecucion:
				-- 
				SELECT * FROM [diprocom].[ERP_VIEW_RESOLUTION]
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_VIEW_RESOLUTION]
AS
    SELECT * FROM OPENQUERY(DIPROCOM_SERVER,'
		SELECT 
			 LTRIM(RTRIM([CAI]))			  [CAI]			
            ,LTRIM(RTRIM([Serie]))			  [Serie]
            ,LTRIM(RTRIM([Nombre]))			  [Nombre]
            ,LTRIM(RTRIM([Direccion_1]))	  [Direccion_1]
            ,CASE LTRIM(RTRIM([Direccion_2])) WHEN '''' THEN NULL ELSE LTRIM(RTRIM([Direccion_2])) END [Direccion_2]
            ,CASE LTRIM(RTRIM([Direccion_3])) WHEN '''' THEN NULL ELSE LTRIM(RTRIM([Direccion_3])) END [Direccion_3]
            ,CASE LTRIM(RTRIM([Direccion_4])) WHEN '''' THEN NULL ELSE LTRIM(RTRIM([Direccion_4])) END [Direccion_4]
            ,[Fecha_Autorizacion] [Fecha_Autorizacion]
            ,[Fecha_Vencimiento]	  [Fecha_Vencimiento]
            ,LTRIM(RTRIM([Rango_Inicio]))		  [Rango_Inicio]
            ,LTRIM(RTRIM([Rango_Final]))		  [Rango_Final]
            ,LTRIM(RTRIM([Numero_Actual]))		  [Numero_Actual]
            ,LTRIM(RTRIM([Vendedor_Asignado]))	  [Vendedor_Asignado]
		FROM [SONDA].[dbo].[vsSERIES]
	')