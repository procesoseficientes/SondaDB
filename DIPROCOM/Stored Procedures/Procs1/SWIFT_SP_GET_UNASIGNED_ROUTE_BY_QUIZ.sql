-- =============================================
-- Autor:                christian.hernandez
-- Fecha de Creacion:    31-Oct-2018 @ A-TEAM Sprint G-Force@Lion
-- Description:          SP que obtiene las rutas sin microencuesta asignada

/*
-- Ejemplo de Ejecucion:
                EXEC [PACASA].SWIFT_SP_GET_UNASIGNED_ROUTE_BY_QUIZ
*/
-- ============================================= 

-- ============================================= 
CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_UNASIGNED_ROUTE_BY_QUIZ] (@QUIZ_ID INT)
AS
BEGIN
SELECT 
	RO.CODE_ROUTE, 
	RO.NAME_ROUTE,
	US.CORRELATIVE,
	US.NAME_USER, 
	CASE WHEN US.[LOGIN] IS NULL THEN 'Sin Asignar' ELSE US.[LOGIN] END AS [LOGIN],	
	CASE WHEN ST.NAME_TEAM IS NULL THEN 'Sin Equipo' ELSE ST.NAME_TEAM END AS TEAM_NAME 
FROM 
	[PACASA].SWIFT_ROUTES RO LEFT JOIN [PACASA].USERS US ON US.SELLER_ROUTE = RO.SELLER_CODE 
	LEFT JOIN (SELECT SUT.[USER_ID], ST.NAME_TEAM FROM 
				[PACASA].[SWIFT_USER_BY_TEAM] SUT 
				INNER JOIN [PACASA].[SWIFT_TEAM] ST ON ST.TEAM_ID = SUT.TEAM_ID ) ST ON ST.[USER_ID] = US.CORRELATIVE
WHERE RO.CODE_ROUTE NOT IN (SELECT ROUTE_CODE FROM [PACASA].SWIFT_ASIGNED_QUIZ WHERE QUIZ_ID = @QUIZ_ID) 
	ORDER BY RO.CODE_ROUTE 
END