﻿CREATE PROCEDURE [PACASA].[SWIFT_SP_DELETEDRIVER]
@DRIVER INT,
@pResult varchar(250) OUTPUT
AS
IF ((SELECT COUNT(A.CODE_DRIVER) FROM [PACASA].SWIFT_MANIFEST_HEADER AS A WHERE A.CODE_DRIVER = @DRIVER )
) = 0
BEGIN 
	DELETE FROM SWIFT_DRIVERS WHERE DRIVER=@DRIVER
	SELECT @pResult = ''
END
ELSE
	BEGIN
		SELECT @pResult = 'El dato no se puede eliminar debido a que está siendo utilizado'
	END





