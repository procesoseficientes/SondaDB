CREATE FUNCTION [dbo].[FUNC_REMOVE_SPECIAL_CHARS]
(
@Cadena as varchar(255)
)
RETURNS varchar(255)
AS
BEGIN
DECLARE @Caracteres varchar(255)
--Se quito el Guion (-) : SET @Caracteres = '-;/''´()&\Ñ¡!?#:$%[_*@{}ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜàáâãäåæçèéêëìíîïðñòóôõö÷øùúûü'
SET @Caracteres = ';/''´()&\Ñ¡!?#:$%[_*@{}ÀÂÃÄÅÆÇÈÊËÌÎÏÐÑÒÔÕÖ×ØÙÛÜàâãäåæçèêëìîïðñòôõö÷øùûü'
--Quitar Caracteres
WHILE @Cadena LIKE '%[' + @Caracteres + ']%'
BEGIN
SELECT @Cadena = REPLACE(@Cadena
, SUBSTRING(@Cadena
, PATINDEX('%[' + @Caracteres + ']%'
, @Cadena)
, 1)
,'')
END

return @Cadena
END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FUNC_REMOVE_SPECIAL_CHARS] TO [SONDA]
    AS [dbo];

