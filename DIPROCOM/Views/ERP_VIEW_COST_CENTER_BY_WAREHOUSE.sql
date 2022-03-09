




-- =============================================
-- Autor:				jose.garcia
-- Fecha de Creacion: 	11-05-2016
-- Description:			Obtiene los centros de costo por bodega

/*
-- Ejemplo de Ejecucion:
				SELECT * FROM [DIPROCOM].[ERP_VIEW_COST_CENTER_BY_WAREHOUSE]
*/
-- =============================================
create VIEW [DIPROCOM].[ERP_VIEW_COST_CENTER_BY_WAREHOUSE]
AS
--select * from openquery (ARIUMSERVER,'SELECT  T1.Descr, T0.WhsCode
--										  FROM [prueba].[dbo].OWHS T0
--										  INNER JOIN [prueba].[dbo].UFD1 T1 ON (T0.U_CBAlmacen = T1.IndexID)
--										  WHERE  T1.TableID = ''OWHS'' ')

--select * from openquery (ARIUMSERVER,'SELECT  T0.WhsCode Descr,T0.U_CBAlmacen WhsCode
--										  FROM [PRUEBA].[dbo].OWHS T0')

SELECT ''Descr
	   ,''WhsCode