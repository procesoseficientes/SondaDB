﻿/*=======================================================
-- Author:         alejandro.ochoa
-- Create date:    19-09-2018
-- Description:    Inserta los Pedidos en DB de Interfaz para SPC
			
-- EJEMPLO DE EJECUCION: 
		EXEC [diprocom].[SWIFT_SP_POST_SALES_ORDER_TO_ERP]

=========================================================*/
CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_POST_SALES_ORDER_TO_ERP]
AS
BEGIN
	SET NOCOUNT OFF;

	DECLARE 
		@SALES_ORDER_ID BIGINT
		,@ERROR_MSG VARCHAR(MAX)

	SELECT 
		[ssoh].[SALES_ORDER_ID]
	INTO #SALES_ORDER
	FROM [diprocom].[SONDA_SALES_ORDER_HEADER] [ssoh]
	WHERE ISNULL(IS_POSTED_ERP, 0) = 0
		AND ISNULL([ssoh].IS_SENDING, 0) = 0
		AND ISNULL([ssoh].IS_DRAFT, 0) = 0
		AND [ssoh].[IS_READY_TO_SEND] = 1
		AND CAST([ssoh].[POSTED_DATETIME] AS DATE) >= CAST(GETDATE() AS DATE)
	ORDER BY [ssoh].[SALES_ORDER_ID] ASC

	WHILE EXISTS (SELECT TOP 1 1 FROM #SALES_ORDER)
	BEGIN

		SELECT TOP 1 
			@SALES_ORDER_ID = [SALES_ORDER_ID]
		FROM #SALES_ORDER
		ORDER BY [SALES_ORDER_ID] ASC

		BEGIN TRY
					
			INSERT INTO [DIPROCOM_SERVER].[SONDA].[dbo].[REPLICA_PEDIDO_ENC]
			(
				[NUMERO_DE_PEDIDO] ,
				[FECHA_PEDIDO] ,
				[CODIGO_DE_CLIENTE] ,
				[CODIGO_VENDEDOR] ,
				[INFORMACION],
				[ESTADO_REPLICA] ,
				[FECHA_REPLICA],
				[FECHA_SINCRONIZACION],
				codigo_territorio
			)
			SELECT 
				[ssoh].[SALES_ORDER_ID],
				[ssoh].[POSTED_DATETIME],
				[ssoh].[CLIENT_ID],
				US.RELATED_SELLER,
				[ssoh].[COMMENT],
				'P',
				NULL,
				[ssoh].[SERVER_POSTED_DATETIME],
				vendedores.CODIGO_TERRITORIO
			FROM DIPROCOM.[SONDA_SALES_ORDER_HEADER] [ssoh]
			INNER JOIN DIPROCOM.USERS US ON [ssoh].POSTED_BY = US.LOGIN
			left join [DIPROCOM_SERVER].SONDA.dbo.vsVENDEDORES_PREVENTA vendedores on us.RELATED_SELLER=vendedores.codigo_vendedor
			WHERE [ssoh].[SALES_ORDER_ID] = @SALES_ORDER_ID

			INSERT INTO [DIPROCOM_SERVER].SONDA.dbo.REPLICA_PEDIDO_DET
			( 
				[NUMERO_DE_PEDIDO] ,
				PRODUCT0 ,
				CODIGO_UNIDAD_VTA ,
				CANTIDAD_VENTA_UM 
			)
			SELECT
                [ssod].[SALES_ORDER_ID] , 
				[ssod].SKU ,
                [ssod].[CODE_PACK_UNIT] ,
                [ssod].QTY
			FROM DIPROCOM.[SONDA_SALES_ORDER_DETAIL] [ssod]
			WHERE [ssod].[SALES_ORDER_ID]=@SALES_ORDER_ID
				
			EXEC [diprocom].[SWIFT_SP-STATUS-SEND_SO_TO_SAP] @SALES_ORDER_ID = @SALES_ORDER_ID, -- int
			    @POSTED_RESPONSE = 'Proceso Exitoso', -- varchar(4000)
			    @ERP_REFERENCE = @SALES_ORDER_ID, -- varchar(256)
			    @OWNER = 'Diprocom', -- varchar(125)
			    @CUSTOMER_OWNER = 'Diprocom' -- varchar(125)
				
		END TRY
		BEGIN CATCH

			SELECT @ERROR_MSG = CONCAT(@@ERROR,'_',ERROR_MESSAGE())
			
			DELETE FROM [DIPROCOM_SERVER].[SONDA].[dbo].[REPLICA_PEDIDO_DET]
			WHERE [NUMERO_DE_PEDIDO] = @SALES_ORDER_ID

			DELETE FROM [DIPROCOM_SERVER].[SONDA].[dbo].[REPLICA_PEDIDO_ENC]
			WHERE [NUMERO_DE_PEDIDO] = @SALES_ORDER_ID

			EXEC [diprocom].[SWIFT_SP-STATUS-ERROR_SO_TO_SAP] @SALES_ORDER_ID = @SALES_ORDER_ID, -- int
			    @POSTED_RESPONSE = @ERROR_MSG, -- varchar(4000)
			    @OWNER = 'Diprocom', -- varchar(125)
			    @CUSTOMER_OWNER = 'Diprocom' -- varchar(125)

		END CATCH

		DELETE FROM #SALES_ORDER WHERE [SALES_ORDER_ID] = @SALES_ORDER_ID

	END;

END










