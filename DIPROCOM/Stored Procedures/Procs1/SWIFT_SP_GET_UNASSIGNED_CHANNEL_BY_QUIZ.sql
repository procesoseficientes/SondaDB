-- =============================================
-- Autor:                christian.hernandez
-- Fecha de Creacion:    31-Oct-2018 @ A-TEAM Sprint G-Force@Lion
-- Description:          SP que obtiene las rutas sin microencuesta asignada

/*
-- Ejemplo de Ejecucion:
                EXEC [PACASA].SWIFT_SP_GET_UNASSIGNED_CHANNEL_BY_QUIZ @QUIZ_ID = 16
*/
-- =============================================


CREATE PROCEDURE [PACASA].[SWIFT_SP_GET_UNASSIGNED_CHANNEL_BY_QUIZ] (@QUIZ_ID INT)
AS 
BEGIN 


SELECT 
	SC.CODE_CHANNEL, 
	SC.NAME_CHANNEL, 
	SC.DESCRIPTION_CHANNEL 
FROM [PACASA].SWIFT_CHANNEL SC 
	WHERE CODE_CHANNEL NOT IN (SELECT CODE_CHANNEL FROM [PACASA].SWIFT_ASIGNED_QUIZ WHERE QUIZ_ID = @QUIZ_ID AND CODE_CHANNEL IS NOT NULL)

END