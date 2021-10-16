﻿/*=======================================================
-- Author:         alejandro.ochoa
-- Create date:    24-10-2018
-- Description:    Inserta los Registros de Modificaciones de Clientes en la Base Intermedia de Diprocom
			
-- EJEMPLO DE EJECUCION: 
		EXEC [SONDA].[SWIFT_SP_POST_CUSTOMER_CHANGE_TO_ERP]

=========================================================*/
CREATE PROCEDURE [SONDA].[SWIFT_SP_POST_CUSTOMER_CHANGE_TO_ERP]
AS
BEGIN
	SET NOCOUNT OFF;

	DECLARE 
		@CUSTOMER BIGINT
		,@CODE_CUSTOMER VARCHAR(50)
		,@LATITUDE VARCHAR(25)
		,@LONGITUDE VARCHAR(25)
		,@ERROR_MSG VARCHAR(MAX)

	SELECT
		[CUSTOMER]
		,[CODE_CUSTOMER]
		,[GPS]
		INTO #CHANGES
	FROM [SONDA].[SWIFT_CUSTOMER_CHANGE]
	WHERE ISNULL(IS_POSTED_ERP, 0) <> 1
		AND ISNULL([GPS],'0,0') <> '0,0'
		AND CAST([POSTED_DATETIME] AS DATE) >= CAST(GETDATE() AS DATE)

	WHILE EXISTS (SELECT TOP 1 1 FROM #CHANGES)
	BEGIN

		SELECT TOP 1 
			@CUSTOMER = [CUSTOMER]
			,@CODE_CUSTOMER = [CODE_CUSTOMER]
			,@LATITUDE = SUBSTRING([GPS],1,CHARINDEX(',',[GPS])-1)
			,@LONGITUDE = SUBSTRING([GPS],CHARINDEX(',',[GPS])+1,LEN([GPS]))
		FROM #CHANGES
		ORDER BY [CUSTOMER] ASC

		BEGIN TRY
			
			IF (SELECT COUNT(*) FROM [DIPROCOM_SERVER].[SONDA].[dbo].[REPLICA_CLIENTE] WHERE [CODIGO_SONDA]=@CODE_CUSTOMER)>0
			BEGIN
				UPDATE [DIPROCOM_SERVER].[SONDA].[dbo].[REPLICA_CLIENTE]
				SET [LATITUD]=@LATITUDE,[LONGITUD]=@LONGITUDE,[FECHA_INSERSION]=GETDATE()
				WHERE [CODIGO_SONDA] = @CODE_CUSTOMER
			END
			ELSE 
			BEGIN 
				INSERT INTO [DIPROCOM_SERVER].[SONDA].[dbo].[REPLICA_CLIENTE]
				        ( [CODIGO_SONDA] ,
				          [LATITUD] ,
				          [LONGITUD] ,
				          [FECHA_INSERSION]
				        )
				VALUES  ( @CODE_CUSTOMER , -- CODIGO_SONDA - int
				          @LATITUDE , -- LATITUD - varchar(50)
				          @LONGITUDE , -- LONGITUD - varchar(50)
				          GETDATE()  -- FECHA_INSERSION - datetime
				        )
			END

			EXEC [SONDA].[SWIFT_SP_SET_STATUS_SEND_CUSTOMER_CHANGE_TO_ERP] @CUSTOMER = @CUSTOMER, -- int
			    @POSTED_RESPONSE = 'Proceso Exitoso' -- varchar(150)

		END TRY
		BEGIN CATCH

			SELECT @ERROR_MSG = CONCAT(@@ERROR,'_',ERROR_MESSAGE())
						
			EXEC [SONDA].[SWIFT_SP_SET_STATUS_SEND_CUSTOMER_CHANGE_TO_ERP] @CUSTOMER = @CUSTOMER, -- int
			    @POSTED_RESPONSE = @ERROR_MSG -- varchar(150)

		END CATCH

		DELETE FROM #CHANGES WHERE [CUSTOMER] = @CUSTOMER

	END;

END



