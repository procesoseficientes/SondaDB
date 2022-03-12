﻿CREATE PROCEDURE [SONDA].[SWIFT_SP_INSERT_INVOICE]
@PICKING_DETAIL VARCHAR(50)
AS
DECLARE 
	@PICKING_HEADER INT
	,@ID			NUMERIC(18,0)
	,@CODE_CLIENT	varchar(50)
	,@TOTAL_AMOUNT	money

	
	BEGIN TRY
		SELECT @PICKING_HEADER = D.PICKING_HEADER FROM [SONDA].[SWIFT_PICKING_DETAIL] D WHERE D.PICKING_DETAIL = @PICKING_DETAIL
		--
		SELECT @CODE_CLIENT = H.CODE_CLIENT FROM [SONDA].[SWIFT_PICKING_HEADER] H WHERE H.PICKING_HEADER = @PICKING_HEADER
		--
		EXEC [SONDA].[SWIFT_SP_GET_NEXT_SEQUENCE] 'INVOICE_DRAFT',@ID OUTPUT
		--
		SET @ID = (@ID*-1)

		INSERT INTO [SONDA].[SONDA_POS_INVOICE_HEADER]
		(
			INVOICE_ID
			,TERMS
			,POSTED_DATETIME
			,CLIENT_ID
			,POS_TERMINAL
			,STATUS
			,POSTED_BY
			,IS_POSTED_OFFLINE
			,CDF_SERIE
			,CDF_RESOLUCION
			,IS_CREDIT_NOTE
			,CDF_DOCENTRY
			,SOURCE_CODE
		)
		SELECT 
			@ID
			,'CASH'
			,GETDATE()
			,H.CODE_CLIENT
			,'BACKOFFICE'
			,1
			,H.CODE_USER
			,0
			,'DRAFT'
			,'DRAFT'
			,0
			,COALESCE(H.REFERENCE,h.DOC_SAP_RECEPTION)
			,@PICKING_HEADER
		FROM [SONDA].[SWIFT_PICKING_HEADER] H
		WHERE PICKING_HEADER = @PICKING_HEADER
		--
		INSERT INTO [SONDA].[SONDA_POS_INVOICE_DETAIL]
		(
			INVOICE_ID
			,INVOICE_SERIAL
			,SKU
			,LINE_SEQ
			,QTY
			,PRICE
			,DISCOUNT
			,TOTAL_LINE
			,POSTED_DATETIME
			,REQUERIES_SERIE
			,INVOICE_RESOLUTION
		)
		SELECT 
			@ID
			,'DRAFT'
			,D.CODE_SKU
			,ROW_NUMBER() OVER(PARTITION BY D.PICKING_HEADER ORDER BY D.CODE_SKU DESC)
			,D.SCANNED
			,S.COST
			,0
			,(S.COST*D.SCANNED)
			,GETDATE()
			,0
			,'DRAFT'
		FROM [SONDA].[SWIFT_PICKING_DETAIL] D
		INNER JOIN [SONDA].[SWIFT_PRICE_LIST_BY_CUSTOMER] C ON (C.CODE_CUSTOMER = @CODE_CLIENT)
		INNER JOIN [SONDA].[SWIFT_PRICE_LIST_BY_SKU] S ON (C.CODE_PRICE_LIST = S.CODE_PRICE_LIST AND S.CODE_SKU = D.CODE_SKU)
		WHERE PICKING_HEADER = @PICKING_HEADER
		AND D.SCANNED > 0
		
		SELECT @TOTAL_AMOUNT = SUM(TOTAL_LINE) FROM [SONDA].[SONDA_POS_INVOICE_DETAIL] WHERE INVOICE_ID = @ID
		--
		UPDATE [SONDA].[SONDA_POS_INVOICE_HEADER]
		SET TOTAL_AMOUNT = @TOTAL_AMOUNT
		WHERE INVOICE_ID = @ID

		SELECT  1 as Resultado , 'Proceso Exitoso' Mensaje ,  @ID Codigo
		RETURN 0
	END TRY
	BEGIN CATCH
		SELECT  -1 as Resultado , 'No se puede generar la factura' as  Mensaje ,  -1  as Codigo
		RETURN -1
	END CATCH