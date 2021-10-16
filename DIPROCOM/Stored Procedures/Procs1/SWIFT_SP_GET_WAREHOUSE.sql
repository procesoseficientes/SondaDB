﻿/****** Object:  StoredProcedure [DIPROCOM].[SWIFT_SP_GET_WAREHOUSE]    Script Date: 20/12/2015 9:09:38 AM ******/
-- =============================================
-- Autor:				jose.garcia
-- Fecha de Creacion: 	02-12-2015
-- Description:			Trae todas las bodegas que existen con su codigo, descripción 
--						y muetra si es externa la bodega
--    
 --Modificacion 14-01-2016
		-- Autor: ppablo.loukota
		-- Descripción: Se agregan los campos nuevos de bodega
		--				                
/*
-- Ejemplo de Ejecucion:				
				--
				exec [DIPROCOM].[SWIFT_SP_GET_WAREHOUSE]				--				

*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_GET_WAREHOUSE]
AS
Select [WAREHOUSE]
	  ,[CODE_WAREHOUSE]
      ,[DESCRIPTION_WAREHOUSE]
	  ,[STATUS_WAREHOUSE]
	  ,[IS_EXTERNAL]
	  ,[TYPE_WAREHOUSE]
      ,[ERP_WAREHOUSE]
      ,[ADDRESS_WAREHOUSE]
	  ,[BARCODE_WAREHOUSE] 
      ,[SHORT_DESCRIPTION_WAREHOUSE] 
      ,[GPS_WAREHOUSE]
	  
from [DIPROCOM].[SWIFT_WAREHOUSES] order by (CODE_WAREHOUSE)



