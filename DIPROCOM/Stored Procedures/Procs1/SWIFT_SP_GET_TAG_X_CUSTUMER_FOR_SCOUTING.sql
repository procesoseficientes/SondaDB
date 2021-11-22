-- =====================================================
-- Author:         diego.as
-- Create date:    06-05-2016
-- Description:    Trae las Etiquetas por Cliente en base a los clientes de la Ruta que recibe como parametro.
--				   

/*
-- EJEMPLO DE EJECUCION: 
		
		EXEC [PACASA].[SWIFT_SP_GET_TAG_X_CUSTUMER_FOR_SCOUTING]
		@CODE_ROUTE = 'RUDI@DIPROCOM'
			

*/
-- =====================================================
CREATE PROC [PACASA].[SWIFT_SP_GET_TAG_X_CUSTUMER_FOR_SCOUTING]
	@CODE_ROUTE varchar(50)	
AS	
	SELECT TC.*
	FROM [PACASA].[SWIFT_TAG_X_CUSTOMER] TC
	INNER JOIN [PACASA].[SWIFT_VIEW_ALL_COSTUMER] VC ON TC.CUSTOMER = VC.CODE_CUSTOMER
	WHERE VC.SCOUTING_ROUTE = @CODE_ROUTE


