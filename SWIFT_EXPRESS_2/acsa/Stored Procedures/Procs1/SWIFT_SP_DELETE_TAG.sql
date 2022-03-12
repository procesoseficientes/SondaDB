﻿CREATE PROCEDURE [SONDA].[SWIFT_SP_DELETE_TAG]
@TAG_COLOR VARCHAR(8),
@pResult varchar(250) OUTPUT
AS
IF 
(
--(SELECT COUNT(A.CODE_ROUTE) FROM [SONDA].SWIFT_MANIFEST_HEADER AS A WHERE A.CODE_ROUTE =  @ROUTE )
0
) = 0
BEGIN 
	DELETE FROM SWIFT_TAGS WHERE TAG_COLOR = @TAG_COLOR
	SELECT @pResult = ''
END
ELSE
	BEGIN
		SELECT @pResult = 'El dato no se puede eliminar debido a que está siendo utilizado'
	END