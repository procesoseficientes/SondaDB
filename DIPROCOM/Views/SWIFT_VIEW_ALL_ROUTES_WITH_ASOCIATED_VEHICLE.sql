-- =============================================
-- Autor:	pablo.aguilar
-- Fecha de Creacion: 	2016-06-10
-- Description:	 Vista que obtiene toda la información de rutas de Swift con su vehiculo asociado.




/*
-- Ejemplo de Ejecucion:
			SELECT * FROM [DIPROCOM].[SWIFT_VIEW_ALL_ROUTES_WITH_ASOCIATED_VEHICLE]
*/
-- =============================================
CREATE VIEW [DIPROCOM].[SWIFT_VIEW_ALL_ROUTES_WITH_ASOCIATED_VEHICLE]
AS
  SELECT 
    
    VR.[ROUTE]
   ,VR.[CODE_ROUTE]
   ,VR.[NAME_ROUTE]
   ,VR.[GEOREFERENCE_ROUTE]
   ,VR.[COMMENT_ROUTE]
   ,VR.[LAST_UPDATE]
   ,VR.[LAST_UPDATE_BY]
   ,sv.[CODE_VEHICLE]
   , u.[LOGIN]
   , u.[RELATED_SELLER]
  FROM [DIPROCOM].[SWIFT_ROUTES] VR
    LEFT JOIN [DIPROCOM].[USERS] u      
    ON  (u.SELLER_ROUTE = VR.[CODE_ROUTE])
  LEFT JOIN  DIPROCOM.SWIFT_VEHICLE_X_USER svxu
    ON (svxu.[LOGIN] = u.[LOGIN])
  LEFT JOIN  DIPROCOM.SWIFT_VEHICLES sv
    ON (sv.VEHICLE = svxu.VEHICLE)     



