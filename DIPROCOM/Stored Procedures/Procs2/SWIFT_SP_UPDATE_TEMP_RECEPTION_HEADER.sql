﻿CREATE PROC [SONDA].[SWIFT_SP_UPDATE_TEMP_RECEPTION_HEADER]
@RECEPTION_HEADER INT,
@CLASSIFICATIONINCOME VARCHAR(50),
@CODEPROVIDER VARCHAR(50),
@CODEOPERATOR VARCHAR(50),
@REFERENCE VARCHAR(50),
@DOC_SAP_RECEPTION VARCHAR(150),
@LASTUPDATEBY VARCHAR(50),
@SCHEDULE_FOR DATE,
@SEQ INT
AS
UPDATE [SONDA].SWIFT_TEMP_RECEPTION_HEADER SET 
TYPE_RECEPTION = @CLASSIFICATIONINCOME, 
CODE_PROVIDER = @CODEPROVIDER,
REFERENCE = @REFERENCE,
CODE_USER = @CODEOPERATOR,
DOC_SAP_RECEPTION = @DOC_SAP_RECEPTION,
LAST_UPDATE_BY = @LASTUPDATEBY,
STATUS = 'ASSIGNED',
LAST_UPDATE = GETDATE(),
SCHEDULE_FOR = @SCHEDULE_FOR,
SEQ = @SEQ WHERE RECEPTION_HEADER = @RECEPTION_HEADER



