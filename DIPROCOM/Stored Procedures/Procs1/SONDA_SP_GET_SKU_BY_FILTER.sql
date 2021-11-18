﻿
-- =============================================
-- Autor:				hector.gonzalez
-- Fecha de Creacion: 	20-05-2016
-- Description:			Obtiene los Sku por parametro de busqueda
/*
-- Ejemplo de Ejecucion:				
				-- EXEC [acsa].SONDA_SP_GET_SKU_BY_FILTER @FILTER=''
				--				
*/
-- =============================================
CREATE PROCEDURE [acsa].[SONDA_SP_GET_SKU_BY_FILTER]

	@FILTER AS VARCHAR (250)
	
AS
	SET NOCOUNT ON;
	BEGIN
		
		SELECT DISTINCT TOP 5 VS.CODE_SKU
			,VS.DESCRIPTION_SKU
			,FS.CODE_FAMILY_SKU
			,FS.DESCRIPTION_FAMILY_SKU
				FROM [acsa].SWIFT_VIEW_PRESALE_SKU PS 
				LEFT JOIN [acsa].SWIFT_VIEW_ALL_SKU VS ON (VS.CODE_SKU = PS.SKU)
				LEFT JOIN [acsa].SWIFT_FAMILY_SKU FS ON VS.CODE_FAMILY_SKU = FS.CODE_FAMILY_SKU
					WHERE PS.SKU LIKE +'%'+ @FILTER +'%'
				
	
	END
