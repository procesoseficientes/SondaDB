﻿CREATE PROC [SONDA].[SWIFT_VALIDATE_QTY_PICKING]
@CODE_SKU VARCHAR(50),
@TASK_ID INT,
@QTY FLOAT
AS
SELECT * FROM [SONDA].SWIFT_PICKING_DETAIL 
WHERE PICKING_HEADER = (SELECT [PICKING_NUMBER] 
FROM [SONDA].[SWIFT_TASKS] WHERE TASK_ID = @TASK_ID) AND CODE_SKU = @CODE_SKU AND SCANNED >= @QTY
IF(@@ROWCOUNT >= 1) BEGIN
	RETURN 0;
END 
ELSE RETURN -1;



