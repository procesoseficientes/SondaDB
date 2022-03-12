﻿/*=======================================================
-- Author:         alejandro.ochoa
-- Create date:    27-04-2018
-- Description:    Inserta las Facturas en DB de Interfaz para SPC
			
-- EJEMPLO DE EJECUCION: 
		EXEC [SONDA].[SWIFT_SP_POST_SALES_INVOICE_TO_ERP]

=========================================================*/
CREATE PROCEDURE [SONDA].[SWIFT_SP_POST_SALES_INVOICE_TO_ERP]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE 
		@SALES_INVOICE_ID BIGINT
		,@SERIE VARCHAR(50)
		,@RESOLUCION VARCHAR(50)
		,@FACTURA INT
		,@ERROR_MSG VARCHAR(MAX)

	SELECT 
		spih.ID
		,spih.CDF_SERIE
		,spih.INVOICE_ID
		,spih.CDF_RESOLUCION
		INTO #SALES_INVOICE
	FROM [SONDA].SONDA_POS_INVOICE_HEADER spih
	WHERE ISNULL(IS_POSTED_ERP, 0) = 0
		AND ISNULL(spih.IS_SENDING, 0) = 0
		AND ISNULL(spih.IS_DRAFT, 0) = 0
		AND spih.[IS_READY_TO_SEND] = 1
		AND spih.[POSTED_DATETIME] >= FORMAT(GETDATE(),'yyyyMMdd')
	ORDER BY spih.ID ASC

	WHILE EXISTS (SELECT TOP 1 1 FROM #SALES_INVOICE)
	BEGIN

		SELECT TOP 1 
			@SALES_INVOICE_ID = ID
			,@SERIE = CDF_SERIE
			,@RESOLUCION = CDF_RESOLUCION
			,@FACTURA = INVOICE_ID
		FROM #SALES_INVOICE
		ORDER BY ID ASC

		BEGIN TRY
					
			INSERT INTO [[SONDA]_SERVER].[SONDA].[dbo].[REPLICA_FACTURA_ENC]
			(	
				[SERIE] ,
				[NUMERO_FACTURA] ,
				[FECHA_DE_FACTURA] ,
				[CODIGO_DE_CLIENTE] ,
				[CODIGO_VENDEDOR] ,
				[CODIGO_DE_BODEGA] ,
				[ESTADO_REPLICA] ,
				[FECHA_REPLICA]
			)
			SELECT 
				SPIH.CDF_SERIE,
				SPIH.INVOICE_ID,
				SPIH.[INVOICED_DATETIME],
				SPIH.CLIENT_ID,
				US.RELATED_SELLER,
				US.DEFAULT_WAREHOUSE,
				'P',
				NULL
			FROM [SONDA].SONDA_POS_INVOICE_HEADER SPIH
			INNER JOIN [SONDA].USERS US ON SPIH.POSTED_BY = US.LOGIN
			WHERE SPIH.ID = @SALES_INVOICE_ID

			INSERT INTO [[SONDA]_SERVER].SONDA.dbo.REPLICA_FACTURA_DET
			( 
				SERIE ,
				NUMERO_FACTURA ,
				PRODUCT0 ,
				CODIGO_UNIDAD_VTA ,
				CANTIDAD_VENTA_UM ,
				PRECIO_UNIDAD_UM
			)
			SELECT
                [spid].INVOICE_SERIAL,
				[spid].INVOICE_ID ,
                [spid].SKU ,
                [spid].[SALES_PACK_UNIT] ,
                [spid].QTY ,
                [plbs].[BASE_PRICE]
			FROM [SONDA].SONDA_POS_INVOICE_DETAIL spid
			INNER JOIN [SONDA].[SONDA_POS_INVOICE_HEADER] spih ON [spih].[ID] = [spid].[ID]
			LEFT JOIN [SONDA].[SWIFT_PRICE_LIST_BY_SKU] plbs 
				ON [plbs].[CODE_SKU] = [spid].[SKU] AND [plbs].[CODE_PRICE_LIST] = [spih].[CLIENT_ID]
			WHERE [spid].[ID]=@SALES_INVOICE_ID
				
			EXEC [SONDA].SWIFT_SP_MARK_INVOICE_AS_SEND_TO_ERP @INVOICE_ID = @FACTURA, -- int
			    @CDF_SERIE = @SERIE, -- varchar(50)
			    @CDF_RESOLUCION = @RESOLUCION, -- nvarchar(50)
			    @IS_CREDIT_NOTE = 0, -- int
			    @POSTED_RESPONSE = 'Proceso Exitoso', -- varchar(150)
			    @ERP_REFERENCE = '1' -- varchar(256)
				
		END TRY
		BEGIN CATCH

			SELECT @ERROR_MSG = CONCAT(@@ERROR,'_',ERROR_MESSAGE())
			
			DELETE FROM [[SONDA]_SERVER].[SONDA].[dbo].[REPLICA_FACTURA_DET]
			WHERE SERIE = @SERIE AND NUMERO_FACTURA = @FACTURA

			DELETE FROM [[SONDA]_SERVER].[SONDA].[dbo].[REPLICA_FACTURA_ENC]
			WHERE SERIE = @SERIE AND NUMERO_FACTURA = @FACTURA

			EXEC [SONDA].SWIFT_SP_MARK_INVOICE_AS_FAILED_TO_ERP @INVOICE_ID = @FACTURA, -- int
			    @CDF_SERIE = @SERIE, -- varchar(50)
			    @CDF_RESOLUCION = @RESOLUCION, -- nvarchar(50)
			    @IS_CREDIT_NOTE = 0, -- int
			    @POSTED_RESPONSE = @ERROR_MSG -- varchar(150)
		END CATCH

		DELETE FROM #SALES_INVOICE WHERE ID = @SALES_INVOICE_ID

	END;  

END