﻿-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	21-11-2016 @ TEAM-A SPRINT 5
-- Description:			Funcion que genera una tabla de un split del caracter indicado para mas de 400 splits
/*
-- Ejemplo de Ejecucion:
        SELECT * FROM [PACASA].[SWIFT_FN_SPLIT_2]('A|B|C|D','|')
*/
-- =============================================
CREATE FUNCTION [PACASA].[SWIFT_FN_SPLIT_2]
(
    @STRING VARCHAR(MAX)
    ,@DELIMITER NCHAR(1)
)
RETURNS @SPLIT TABLE (
	VALUE VARCHAR(250) NOT NULL
) 
AS
BEGIN
	   
	DECLARE @xml xml, @str varchar(max)
	--
	SET @xml = cast(('<X>'+replace(@STRING, @DELIMITER, '</X><X>')+'</X>') as xml)
	--
	INSERT INTO @SPLIT
	SELECT C.value('.', 'varchar(10)') as value FROM @xml.nodes('X') as X(C) 

	RETURN;
END



