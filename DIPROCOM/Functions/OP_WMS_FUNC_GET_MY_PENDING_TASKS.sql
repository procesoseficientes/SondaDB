﻿



CREATE FUNCTION [SONDA].[OP_WMS_FUNC_GET_MY_PENDING_TASKS]
(	
	@pLOGIN_ID varchar(25)
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * 
		FROM SWIFT_VIEW_PENDING_TASKS 
		WHERE UPPER(ASSIGNED_TO) = UPPER(@pLOGIN_ID)
)







