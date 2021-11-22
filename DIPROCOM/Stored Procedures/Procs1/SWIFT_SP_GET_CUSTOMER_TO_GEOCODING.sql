-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	10-May-17 @ A-TEAM Sprint Issa 
-- Description:			SP para obtener clientes para el geocoding

-- Modificacion 6/1/2017 @ A-Team Sprint Jibade
					-- rodrigo.gomez
					-- Se actualizo el SP que manda a llamar cuando el valor de IS_FOR_SCOUTING = 1, por uno que trae tanto los scoutings como los cambios de clientes.

/*
-- Ejemplo de Ejecucion:
				EXEC [PACASA].[SWIFT_SP_GET_CUSTOMER_TO_GEOCODING]
					@IS_FOR_SCOUTING = 0
				--
				EXEC [PACASA].[SWIFT_SP_GET_CUSTOMER_TO_GEOCODING]
					@IS_FOR_SCOUTING = 1
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_CUSTOMER_TO_GEOCODING](
	@IS_FOR_SCOUTING INT
)
AS
BEGIN
	SET NOCOUNT ON;
	--
	IF @IS_FOR_SCOUTING = 1
	BEGIN
		EXEC [PACASA].[SWIFT_VALIDATE_CUSTOMER_ACQUISITION_FOR_GEOCODING]
	END
	ELSE
	BEGIN
		EXEC [PACASA].[SWIFT_SP_GET_TOP10_CUSTOMERS_TO_GEOCODING]
	END
END



