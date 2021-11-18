﻿CREATE PROCEDURE [acsa].[SWIFT_SP_DELETEPROVIDER]
@PROVIDER INT,
@pResult varchar(250) OUTPUT
AS
IF ((SELECT COUNT(A.CODE_PROVIDER) FROM [acsa].SWIFT_RECEPTION_HEADER AS A WHERE A.CODE_PROVIDER =(SELECT CODE_PROVIDER FROM [acsa].SWIFT_PROVIDERS WHERE PROVIDER =  @PROVIDER ))
+ (SELECT COUNT(B.RELATED_PROVIDER_CODE) FROM [acsa].SWIFT_TASKS AS B WHERE B.RELATED_PROVIDER_CODE = (SELECT CODE_PROVIDER FROM [acsa].SWIFT_PROVIDERS WHERE PROVIDER =  @PROVIDER )  )
--+ (SELECT COUNT(C.PROVIDER_CODE) FROM [acsa].SWIFT_TXNS AS C WHERE C.PROVIDER_CODE = (SELECT CODE_PROVIDER FROM [acsa].SWIFT_PROVIDERS WHERE PROVIDER =  @PROVIDER )  )
) = 0
BEGIN 
	DELETE FROM SWIFT_PROVIDERS WHERE PROVIDER=@PROVIDER
	SELECT @pResult = ''
END
ELSE
	BEGIN
		SELECT @pResult = 'El dato no se puede eliminar debido a que está siendo utilizado'
	END
