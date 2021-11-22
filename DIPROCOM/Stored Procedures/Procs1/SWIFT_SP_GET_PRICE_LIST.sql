-- =============================================
-- Autor:				diego.as
-- Fecha de Creacion: 	3/7/2017 @ A-TEAM Sprint   
-- Description:			SP que obtiene los registros de las listas de precios filtrando por CODE_PRICE_LIST

/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].[SWIFT_SP_GET_PRICE_LIST]
				@CODE_PRICE_LIST = 14
				--
				EXEC [PACASA].[SWIFT_SP_GET_PRICE_LIST]
				@CODE_PRICE_LIST = NULL
				--
				SELECT * FROM [PACASA].[SWIFT_PRICE_LIST]
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_PRICE_LIST](
	@CODE_PRICE_LIST VARCHAR(25) = NULL
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	SELECT [PL].[CODE_PRICE_LIST]
			,[PL].[NAME_PRICE_LIST]
			,[PL].[COMMENT]
			,[PL].[LAST_UPDATE]
			,[PL].[LAST_UPDATE_BY] 
	FROM [PACASA].[SWIFT_PRICE_LIST] AS [PL]
	WHERE [PL].[CODE_PRICE_LIST] = @CODE_PRICE_LIST	OR @CODE_PRICE_LIST IS NULL
END



