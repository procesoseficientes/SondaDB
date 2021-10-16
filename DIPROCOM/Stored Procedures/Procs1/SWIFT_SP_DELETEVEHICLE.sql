﻿CREATE PROCEDURE [SONDA].[SWIFT_SP_DELETEVEHICLE]
@VEHICLE INT,
@pResult varchar(250) OUTPUT
AS
IF ((SELECT COUNT(A.CODE_VEHICLE) FROM [SONDA].SWIFT_MANIFEST_HEADER AS A WHERE A.CODE_VEHICLE =  @VEHICLE )
) = 0
BEGIN 
	DELETE FROM SWIFT_VEHICLES WHERE VEHICLE=@VEHICLE
	SELECT @pResult = ''
END
ELSE
	BEGIN
		SELECT @pResult = 'El dato no se puede eliminar debido a que está siendo utilizado'
	END





