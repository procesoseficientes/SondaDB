﻿CREATE PROCEDURE [acsa].[SWIFT_SP_GET_QUERY_LIST] (
		@LOGIN VARCHAR(50) = NULL
	)
AS
BEGIN
	SET NOCOUNT ON;
	--
	IF (@LOGIN IS NOT NULL) OR (@LOGIN != '')
	BEGIN
	SELECT A.ID,A.NAME,A.QUERY 
		FROM [acsa].SWIFT_QUERY_LIST A
		INNER JOIN [acsa].SWIFT_QUERY_LIST_BY_ROLE B ON A.ID = B.QUERY_LIST_ID
		INNER JOIN [acsa].SWIFT_ROLE C ON B.TEAM_ID = C.ROLE_ID
		INNER JOIN [acsa].USERS D ON C.ROLE_ID = D.USER_ROLE
		WHERE ACTIVE=1	
		AND D.LOGIN=@LOGIN 
	END
	ELSE
	  BEGIN
	    SELECT ID,NAME,QUERY 
		FROM [acsa].SWIFT_QUERY_LIST A
		WHERE ACTIVE=1	
	  END
END;