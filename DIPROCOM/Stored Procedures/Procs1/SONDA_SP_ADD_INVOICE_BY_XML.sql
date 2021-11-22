-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	03-Apr-17 @ A-TEAM Sprint Garai 
-- Description:			SP que agrega una factura por xml

-- Modificacion 7/29/2017 @ Reborn-Team Sprint Bearbeitung
-- diego.as
-- Se agrega insert a la columna TELEPHONE_NUMBER

-- Modificacion 10/28/2017 @ A-Team Sprint Bearbeitung
-- diego.as
-- Se agrega columna TAX_CODE que almacena el CODIGO del tipo del impuesto al que aplica el producto

-- Modificacion 11/17/2017 @ Reborn-Team Sprint Eberhard
-- diego.as
-- Se agrega columna IS_FROM_DELIVERY_NOTE


-- Modificacion 12/14/2017 @ Reborn-Team Sprint Pannen
-- diego.as
-- Se agrega insercion de columna DISCOUNT

-- Modificacion 12/15/2017 @ Reborn-Team Sprint Pannen
-- diego.as
-- Se agrega insercion de columna COMMENT

-- Modificacion 1/19/2018 @ Reborn-Team Sprint Strom
-- diego.as
-- Se agrega validacion de identificador de dispositivo al postear el documento

-- Modificacion 5/4/2018 @ G-Force - Team Sprint Castor
-- diego.as
-- Se agrega insercion de campos DUE_DATE, CREDIT_AMOUNT, CASH_AMOUNT, PAID_TO_DATE

-- Modificacion 04/12/2019 @ G-Force - Team Sprint Oslo
-- Denis Villagrán
-- Se agrega inserción de campos [ELECTRONIC_SIGNATURE],[DOCUMENT_SERIES],[DOCUMENT_NUMBER],
--                               [DOCUMENT_URL],[SHIPMENT],[VALIDATION_RESULT],[SHIPMENT_DATETIME],
--		                         [SHIPMENT_RESPONSE],[IS_CONTINGENCY_DOCUMENT],[CONTINGENCY_DOC_SERIE],
--		                         [CONTINGENCY_DOC_NUM],[FEL_DOCUMENT_TYPE],[FEL_STABLISHMENT_CODE]
/*															 
-- Ejemplo de Ejecucion:
				EXEC [PACASA].[SONDA_SP_ADD_INVOICE_BY_XML]
					@XML = '<?xml version="1.0"?>
<Data>
    <invoice>
        <InvoiceId>29</InvoiceId>
        <Terms>CASH</Terms>
        <PostedDatetime>2017/03/31 17:15:52</PostedDatetime>
        <ClientId>1020</ClientId>
        <ClientName>TIENDA ESPERANZA</ClientName>
        <PosTerminal>7</PosTerminal>
        <Gps>0,0</Gps>
        <TotalAmount>50</TotalAmount>
        <IsPosted>0</IsPosted>
        <Status>1</Status>
        <VoidReason></VoidReason>
        <VoidNotes></VoidNotes>
        <VoidInvoiceId>null</VoidInvoiceId>
        <PrintRequest>1</PrintRequest>
        <PrintedCount>0</PrintedCount>
        <AuthId>1323123</AuthId>
        <SatSerie>Serie de R</SatSerie>
        <Change>0</Change>
        <ConsignmnetId>null</ConsignmnetId>
        <IsPaidConsignment>0</IsPaidConsignment>
        <InitialTaskImage></InitialTaskImage>
       
        <Image2></Image2>
        <Image3></Image3>
        <ErpInvoiceId>C.F</ErpInvoiceId>
        <IsCreditNote>0</IsCreditNote>
        <InRoutePlan>1</InRoutePlan>
        <IdBo>null</IdBo>
        <IsPostedValidated>null</IsPostedValidated>
        <DetailQty>1</DetailQty>
		<Comment>null</Comment>
        <InvoiceDetail>
            <InvoiceId>29</InvoiceId>
            <Sku>100017</Sku>
            <SkuName>QUANTUM AAA 4BC 54CS</SkuName>
            <Qty>5</Qty>
            <Price>10</Price>
            <Discount>0</Discount>
            <TotalLine>50</TotalLine>
            <Serie>0</Serie>
            <Serie2>0</Serie2>
            <RequeriesSerie>0</RequeriesSerie>
            <LineSeq>2</LineSeq>
            <IsActive>1</IsActive>
            <ComboReference>100017</ComboReference>
            <ParentSeq>1</ParentSeq>
            <Exposure>1</Exposure>
            <Phone></Phone>
        </InvoiceDetail>
    </invoice>
    <dbuser>UDIPROCOM</dbuser>
    <dbuserpass>DIPROCOMServer1237710</dbuserpass>
    <battery>100</battery>
    <routeid>7</routeid>
    <uuid>2b9cd997e9ffcd98</uuid>
    <warehouse>R006</warehouse>
</Data>'
					
				--
				SELECT * FROM [PACASA].[SONDA_POS_INVOICE_HEADER]
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SONDA_SP_ADD_INVOICE_BY_XML]
(
    @XML XML,
    @JSON VARCHAR(MAX)
)
AS
BEGIN
    SET NOCOUNT ON;
    --
    DECLARE @DETAIL TABLE
    (
        [INVOICE_ID] [INT] NOT NULL,
        [INVOICE_SERIAL] [VARCHAR](50) NOT NULL,
        [SKU] [VARCHAR](25) NOT NULL,
        [LINE_SEQ] [INT] NOT NULL,
        [QTY] [NUMERIC](18, 2) NULL,
        [PRICE] NUMERIC(18, 6) NULL,
        [DISCOUNT] NUMERIC(18, 6) NULL,
        [TOTAL_LINE] NUMERIC(18, 6) NULL,
        [POSTED_DATETIME] [DATETIME] NULL,
        [SERIE] [VARCHAR](50) NULL,
        [SERIE_2] [VARCHAR](50) NULL,
        [REQUERIES_SERIE] [INT] NULL,
        [COMBO_REFERENCE] [VARCHAR](50) NULL,
        [INVOICE_RESOLUTION] [VARCHAR](50) NOT NULL,
        [PARENT_SEQ] [INT] NULL,
        [IS_ACTIVE_ROUTE] [INT] NULL,
        [TAX_CODE] VARCHAR(25) NULL,
        [SALES_PACK_UNIT] VARCHAR(50),
        [STOCK_PACK_UNIT] VARCHAR(50),
        [CONVERSION_FACTOR] NUMERIC(18, 6)
    );
    --
    DECLARE @RESUTL_VALIDATION TABLE
    (
        [EXISTS] [INT],
        [ID] [INT],
        [DOC_RESOLUTION] VARCHAR(100),
        [DOC_SERIE] VARCHAR(100),
        [DOC_NUM] INT
    );
    --
    DECLARE @ID INT,
            @HEADER_POSTEDDATIME DATETIME,
            @DETAIL_QTY  [NUMERIC](18, 2),
            @HEADER_DETAIL_QTY  [NUMERIC](18, 2),
            @DOC_RESOLUTION VARCHAR(100),
            @DOC_SERIE VARCHAR(100),
            @DOC_NUM INT,
            @CODE_ROUTE VARCHAR(50),
            @CODE_CUSTOMER VARCHAR(50),
            @EXISTS INT = 0,
            @WAREHOUSE VARCHAR(50),
            @DEVICE_ID VARCHAR(50),
            @LOGIN VARCHAR(50),
            @BATTERY INT,
            @TOTAL_AMOUNT DECIMAL(18, 6),
            @USER_AMOUNT DECIMAL(18, 6),
            @CREDIT_AMOUNT DECIMAL(18, 6),
            @CHANGE DECIMAL(18, 6);
    --
    BEGIN TRY
        -- ------------------------------------------------------------------------------------
        -- Obtiene la fecha del encabezado
        -- ------------------------------------------------------------------------------------
        SELECT @HEADER_POSTEDDATIME = [x].[Rec].[query]('./PostedDatetime').[value]('.', 'datetime'),
               @HEADER_DETAIL_QTY = [x].[Rec].[query]('./DetailQty').[value]('.', 'int'),
               @DOC_RESOLUTION = [x].[Rec].[query]('./AuthId').[value]('.', 'varchar(50)'),
               @DOC_SERIE = [x].[Rec].[query]('./SatSerie').[value]('.', 'varchar(50)'),
               @DOC_NUM = [x].[Rec].[query]('./InvoiceId').[value]('.', 'int'),
               @CODE_ROUTE = [x].[Rec].[query]('./PosTerminal').[value]('.', 'varchar(50)'),
               @CODE_CUSTOMER = [x].[Rec].[query]('./ClientId').[value]('.', 'varchar(50)'),
               @TOTAL_AMOUNT = [x].[Rec].[query]('./TotalAmount').[value]('.', 'NUMERIC(18,6)'),
               @CREDIT_AMOUNT = CASE [x].[Rec].[query]('./CreditAmount').[value]('.', 'varchar(250)')
                                    WHEN 'NULL' THEN
                                        0
                                    WHEN 'UNDEFINED' THEN
                                        0
                                    ELSE
                                        [x].[Rec].[query]('./CreditAmount').[value]('.', 'numeric(18,6)')
                                END,
               @USER_AMOUNT = CASE [x].[Rec].[query]('./CashAmount').[value]('.', 'varchar(250)')
                                  WHEN 'NULL' THEN
                                      0
                                  WHEN 'UNDEFINED' THEN
                                      0
                                  ELSE
                                      [x].[Rec].[query]('./CashAmount').[value]('.', 'numeric(18,6)')
                              END,
               @CHANGE = CASE [x].[Rec].[query]('./Change').[value]('.', 'varchar(250)')
                             WHEN 'NULL' THEN
                                 0
                             WHEN 'UNDEFINED' THEN
                                 0
                             ELSE
                                 [x].[Rec].[query]('./Change').[value]('.', 'numeric(18,6)')
                         END
        FROM @XML.[nodes]('/Data/invoice') AS [x]([Rec]);

        -- ------------------------------------------------------------------------------------
        -- Obtiene los datos generales de la ruta
        -- ------------------------------------------------------------------------------------
        SELECT @WAREHOUSE = [x].[Rec].[query]('./warehouse').[value]('.', 'varchar(50)'),
               @DEVICE_ID = [x].[Rec].[query]('./uuid').[value]('.', 'varchar(50)'),
               @LOGIN
                   = [PACASA].[SWIFT_FN_GET_LOGIN_BY_ROUTE]([x].[Rec].[query]('./routeid').[value]('.', 'varchar(50)')),
               @BATTERY = [x].[Rec].[query]('./battery').[value]('.', 'int')
        FROM @XML.[nodes]('/Data') AS [x]([Rec]);

        -- ------------------------------------------------------------------------------------
        -- Se valida el identificador del dispositivo
        -- ------------------------------------------------------------------------------------
        EXEC [PACASA].[SONDA_SP_VALIDATE_DEVICE_ID_OF_USER_FOR_TRANSACTION] @CODE_ROUTE = @CODE_ROUTE, -- varchar(50)
                                                                           @DEVICE_ID = @DEVICE_ID;   -- varchar(50)

        -- ------------------------------------------------------------------------------------
        -- Obtiene el detalle
        -- ------------------------------------------------------------------------------------
        INSERT INTO @DETAIL
        (
            [INVOICE_ID],
            [INVOICE_SERIAL],
            [SKU],
            [LINE_SEQ],
            [QTY],
            [PRICE],
            [DISCOUNT],
            [TOTAL_LINE],
            [POSTED_DATETIME],
            [SERIE],
            [SERIE_2],
            [REQUERIES_SERIE],
            [COMBO_REFERENCE],
            [INVOICE_RESOLUTION],
            [PARENT_SEQ],
            [IS_ACTIVE_ROUTE],
            [TAX_CODE],
            [SALES_PACK_UNIT],
            [STOCK_PACK_UNIT],
            [CONVERSION_FACTOR]
        )
        SELECT [x].[Rec].[query]('./InvoiceId').[value]('.', 'int'),
               @DOC_SERIE,
               [x].[Rec].[query]('./Sku').[value]('.', 'varchar(50)'),
               [x].[Rec].[query]('./LineSeq').[value]('.', 'int'),
               [x].[Rec].[query]('./Qty').[value]('.', 'NUMERIC(18,6)'),
               [x].[Rec].[query]('./Price').[value]('.', 'NUMERIC(18,6)'),
               [x].[Rec].[query]('./Discount').[value]('.', 'NUMERIC(18,6)'),
               [x].[Rec].[query]('./TotalLine').[value]('.', 'NUMERIC(18,6)'),
               @HEADER_POSTEDDATIME,
               [x].[Rec].[query]('./Serie').[value]('.', 'varchar(50)'),
               [x].[Rec].[query]('./Serie2').[value]('.', 'varchar(50)'),
               [x].[Rec].[query]('./RequeriesSerie').[value]('.', 'int'),
               [x].[Rec].[query]('./ComboReference').[value]('.', 'varchar(50)'),
               @DOC_RESOLUTION,
               CASE [x].[Rec].[query]('./ParentSeq').[value]('.', 'varchar(50)')
                   WHEN 'NULL' THEN
                       NULL
                   ELSE
                       [x].[Rec].[query]('./ParentSeq').[value]('.', 'int')
               END,
               [x].[Rec].[query]('./IsActive').[value]('.', 'int'),
               [x].[Rec].[query]('./TaxCode').[value]('.', 'varchar(25)'),
               CASE [x].[Rec].[query]('./SalesPackUnit').[value]('.', 'varchar(50)')
                   WHEN 'NULL' THEN
                       NULL
                   ELSE
                       [x].[Rec].[query]('./SalesPackUnit').[value]('.', 'varchar(50)')
               END,
               CASE [x].[Rec].[query]('./StockPackUnit').[value]('.', 'varchar(50)')
                   WHEN 'NULL' THEN
                       NULL
                   ELSE
                       [x].[Rec].[query]('./StockPackUnit').[value]('.', 'varchar(50)')
               END,
               CASE [x].[Rec].[query]('./ConversionFactor').[value]('.', 'varchar(50)')
                   WHEN 'NULL' THEN
                       NULL
                   ELSE
                       [x].[Rec].[query]('./ConversionFactor').[value]('.', 'NUMERIC(18,6)')
               END
        FROM @XML.[nodes]('/Data/invoice/InvoiceDetail') AS [x]([Rec]);
        --
        SET @DETAIL_QTY = @@ROWCOUNT;

        -- ------------------------------------------------------------------------------------
        -- Valida cantidad de detalle con la del encabezado
        -- ------------------------------------------------------------------------------------
        IF (@DETAIL_QTY = @HEADER_DETAIL_QTY)
        BEGIN
            -- ------------------------------------------------------------------------------------
            -- Valida si existe la factura
            -- ------------------------------------------------------------------------------------
            INSERT INTO @RESUTL_VALIDATION
            EXEC [PACASA].[SONDA_SP_VALIDATED_IF_EXISTS_INVOICE] @CODE_ROUTE = @CODE_ROUTE,
                                                                @CODE_CUSTOMER = @CODE_CUSTOMER,
                                                                @DOC_RESOLUTION = @DOC_RESOLUTION,
                                                                @DOC_SERIE = @DOC_SERIE,
                                                                @DOC_NUM = @DOC_NUM,
                                                                @POSTED_DATETIME = @HEADER_POSTEDDATIME,
                                                                @DETAIL_QTY = @DETAIL_QTY,
                                                                @DECREASE_INVENTORY = 0,
                                                                @XML = @XML,
                                                                @JSON = @JSON;
            --
            SELECT @EXISTS = [R].[EXISTS],
                   @ID = [R].[ID]
            FROM @RESUTL_VALIDATION [R];
            --
            IF (@EXISTS = 1)
            BEGIN
                PRINT '--> ya existe la factura con el ID :' + CAST(@ID AS VARCHAR);
                --
                SELECT @ID [ID];
            END;
            ELSE
            BEGIN
                BEGIN TRY
                    BEGIN TRAN;

                    -- ------------------------------------------------------------------------------------
                    -- Inserta el encabezado
                    -- ------------------------------------------------------------------------------------
                    INSERT INTO [PACASA].[SONDA_POS_INVOICE_HEADER]
                    (
                        [INVOICE_ID],
                        [TERMS],
                        [POSTED_DATETIME],
                        [CLIENT_ID],
                        [POS_TERMINAL],
                        [GPS_URL],
                        [TOTAL_AMOUNT],
                        [STATUS],
                        [POSTED_BY],
                        [IMAGE_1],
                        [IMAGE_2],
                        [IMAGE_3],
                        [IS_POSTED_OFFLINE],
                        [INVOICED_DATETIME],
                        [DEVICE_BATTERY_FACTOR],
                        [CDF_INVOICENUM],
                        [CDF_DOCENTRY],
                        [CDF_SERIE],
                        [CDF_NIT],
                        [CDF_NOMBRECLIENTE],
                        [CDF_RESOLUCION],
                        [CDF_POSTED_ERP],
                        [IS_CREDIT_NOTE],
                        [VOID_DATETIME],
                        [CDF_PRINTED_COUNT],
                        [VOID_REASON],
                        [VOID_NOTES],
                        [VOIDED_INVOICE],
                        [CLOSED_ROUTE_DATETIME],
                        [CLEARING_DATETIME],
                        [IS_ACTIVE_ROUTE],
                        [SOURCE_CODE],
                        [GPS_EXPECTED],
                        [ATTEMPTED_WITH_ERROR],
                        [IS_POSTED_ERP],
                        [POSTED_ERP],
                        [POSTED_RESPONSE],
                        [IS_DRAFT],
                        [ERP_REFERENCE],
                        [CONSIGNMENT_ID],
                        [LIQUIDATION_ID],
                        [INITIAL_TASK_IMAGE],
                        [IN_ROUTE_PLAN],
                        [IS_READY_TO_SEND],
                        [IS_SENDING],
                        [LAST_UPDATE_IS_SENDING],
                        [TELEPHONE_NUMBER],
                        [IS_FROM_DELIVERY_NOTE],
                        [DISCOUNT],
                        [COMMENT],
                        [DUE_DATE],
                        [CREDIT_AMOUNT],
                        [CASH_AMOUNT],
                        [PAID_TO_DATE],
                        [TASK_ID],
                        [GOAL_HEADER_ID],
                        [USER_AMOUNT],
                        [CHANGE],
                        [INVOICE_XML],
                        [ELECTRONIC_SIGNATURE],
                        [DOCUMENT_SERIES],
                        [DOCUMENT_NUMBER],
                        [DOCUMENT_URL],
                        [SHIPMENT],
                        [VALIDATION_RESULT],
                        [SHIPMENT_DATETIME],
                        [SHIPMENT_RESPONSE],
                        [IS_CONTINGENCY_DOCUMENT],
                        [CONTINGENCY_DOC_SERIE],
                        [CONTINGENCY_DOC_NUM],
                        [FEL_DOCUMENT_TYPE],
                        [FEL_STABLISHMENT_CODE]
                    )
                    SELECT @DOC_NUM,
                           [x].[Rec].[query]('./Terms').[value]('.', 'varchar(50)'),
                           GETDATE(),
                           @CODE_CUSTOMER,
                           @CODE_ROUTE,
                           [x].[Rec].[query]('./Gps').[value]('.', 'varchar(50)'),
                           [x].[Rec].[query]('./TotalAmount').[value]('.', 'NUMERIC(18,6)'),
                           [x].[Rec].[query]('./Status').[value]('.', 'int'),
                           @LOGIN,
                           [x].[Rec].[query]('./Image1').[value]('.', 'varchar(MAX)'),
                           [x].[Rec].[query]('./Image2').[value]('.', 'varchar(MAX)'),
                           [x].[Rec].[query]('./Image3').[value]('.', 'varchar(MAX)'),
                           NULL,
                           @HEADER_POSTEDDATIME,
                           @BATTERY,
                           NULL,
                           NULL,
                           @DOC_SERIE,
                           SUBSTRING([x].[Rec].[query]('./ErpInvoiceId').[value]('.' ,
																'varchar(50)'),0,29),
                           [x].[Rec].[query]('./ClientName').[value]('.', 'varchar(150)'),
                           @DOC_RESOLUTION,
                           NULL,
                           [x].[Rec].[query]('./IsCreditNote').[value]('.', 'int'),
                           NULL,
                           [x].[Rec].[query]('./PrintedCount').[value]('.', 'int'),
                           CASE [x].[Rec].[query]('./VoidReason').[value]('.', 'varchar(50)')
                               WHEN '' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./VoidReason').[value]('.', 'varchar(50)')
                           END,
                           CASE [x].[Rec].[query]('./VoidNotes').[value]('.', 'varchar(MAX)')
                               WHEN '' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./VoidNotes').[value]('.', 'varchar(MAX)')
                           END,
                           NULL,
                           NULL,
                           NULL,
                           1,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           NULL,
                           0,
                           NULL,
                           CASE [x].[Rec].[query]('./ConsignmnetId').[value]('.', 'varchar(50)')
                               WHEN 'null' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./ConsignmnetId').[value]('.', 'int')
                           END,
                           NULL,
                           CASE [x].[Rec].[query]('./InitialTaskImage').[value]('.', 'varchar(MAX)')
                               WHEN '' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./InitialTaskImage').[value]('.', 'varchar(MAX)')
                           END,
                           [x].[Rec].[query]('./InRoutePlan').[value]('.', 'int'),
                           0,
                           0,
                           NULL,
                           CASE [x].[Rec].[query]('./TelephoneNumber').[value]('.', 'varchar(50)')
                               WHEN 'null' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./TelephoneNumber').[value]('.', 'varchar(50)')
                           END,
                           CASE [x].[Rec].[query]('./IsFromDeliveryNote').[value]('.', 'varchar(50)')
                               WHEN 'NULL' THEN
                                   0
                               WHEN 'UNDEFINED' THEN
                                   0
                               ELSE
                                   [x].[Rec].[query]('./IsFromDeliveryNote').[value]('.', 'int')
                           END,
                           CASE [x].[Rec].[query]('./Discount').[value]('.', 'varchar(50)')
                               WHEN 'NULL' THEN
                                   0
                               WHEN 'UNDEFINED' THEN
                                   0
                               ELSE
                                   [x].[Rec].[query]('./Discount').[value]('.', 'numeric(18,6)')
                           END,
                           CASE [x].[Rec].[query]('./Comment').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   'N/A'
                               WHEN 'UNDEFINED' THEN
                                   'N/A'
                               ELSE
                                   [x].[Rec].[query]('./Comment').[value]('.', 'varchar(250)')
                           END,
                           CASE [x].[Rec].[query]('./DueDate').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   GETDATE()
                               WHEN 'UNDEFINED' THEN
                                   GETDATE()
                               ELSE
                                   [x].[Rec].[query]('./DueDate').[value]('.', 'datetime')
                           END,
                           CASE [x].[Rec].[query]('./CreditAmount').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   0
                               WHEN 'UNDEFINED' THEN
                                   0
                               ELSE
                                   [x].[Rec].[query]('./CreditAmount').[value]('.', 'numeric(18,6)')
                           END,
                           (@TOTAL_AMOUNT - @CREDIT_AMOUNT),
                           CASE [x].[Rec].[query]('./PaidToDate').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   0
                               WHEN 'UNDEFINED' THEN
                                   0
                               ELSE
                                   [x].[Rec].[query]('./PaidToDate').[value]('.', 'numeric(18,6)')
                           END,
                           CASE [x].[Rec].[query]('./TaskId').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   NULL
                               WHEN 'UNDEFINED' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./TaskId').[value]('.', 'INT')
                           END,
                           CASE [x].[Rec].[query]('./GoalHeaderId').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   NULL
                               WHEN 'UNDEFINED' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./GoalHeaderId').[value]('.', 'INT')
                           END,
                           @USER_AMOUNT,
                           @CHANGE,
                           @XML,
                           CASE [x].[Rec].[query]('./ElectronicSignature').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   NULL
                               WHEN 'UNDEFINED' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./ElectronicSignature').[value]('.', 'varchar(250)')
                           END,
                           CASE [x].[Rec].[query]('./DocumentSeries').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   NULL
                               WHEN 'UNDEFINED' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./DocumentSeries').[value]('.', 'varchar(100)')
                           END,
                           CASE [x].[Rec].[query]('./DocumentNumber').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   NULL
                               WHEN 'UNDEFINED' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./DocumentNumber').[value]('.', 'bigint')
                           END,
                           CASE [x].[Rec].[query]('./DocumentUrl').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   NULL
                               WHEN 'UNDEFINED' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./DocumentUrl').[value]('.', 'varchar(250)')
                           END,
                           CASE [x].[Rec].[query]('./Shipment').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   NULL
                               WHEN 'UNDEFINED' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./Shipment').[value]('.', 'int')
                           END,
                           CASE [x].[Rec].[query]('./ValidationResult').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   NULL
                               WHEN 'UNDEFINED' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./ValidationResult').[value]('.', 'bit')
                           END,
                           CASE [x].[Rec].[query]('./ShipmentDatetime').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   NULL
                               WHEN 'UNDEFINED' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./ShipmentDatetime').[value]('.', 'datetime')
                           END,
                           CASE [x].[Rec].[query]('./ShipmentResponse').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   NULL
                               WHEN 'UNDEFINED' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./ShipmentResponse').[value]('.', 'varchar(250)')
                           END,
                           CASE [x].[Rec].[query]('./IsContingencyDocument').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   NULL
                               WHEN 'UNDEFINED' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./IsContingencyDocument').[value]('.', 'int')
                           END,
                           CASE [x].[Rec].[query]('./ContingencyDocSerie').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   NULL
                               WHEN 'UNDEFINED' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./ContingencyDocSerie').[value]('.', 'varchar(50)')
                           END,
                           CASE [x].[Rec].[query]('./ContingencyDocNum').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   NULL
                               WHEN 'UNDEFINED' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./ContingencyDocNum').[value]('.', 'int')
                           END,
                           CASE [x].[Rec].[query]('./FelDocumentType').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   NULL
                               WHEN 'UNDEFINED' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./FelDocumentType').[value]('.', 'varchar(50)')
                           END,
                           CASE [x].[Rec].[query]('./FelStablishmentCode').[value]('.', 'varchar(250)')
                               WHEN 'NULL' THEN
                                   NULL
                               WHEN 'UNDEFINED' THEN
                                   NULL
                               ELSE
                                   [x].[Rec].[query]('./FelStablishmentCode').[value]('.', 'int')
                           END
                    FROM @XML.[nodes]('/Data/invoice') AS [x]([Rec]);
                    --
                    SET @ID = SCOPE_IDENTITY();

                    -- ------------------------------------------------------------------------------------
                    -- inserta el detalle
                    -- ------------------------------------------------------------------------------------
                    INSERT INTO [PACASA].[SONDA_POS_INVOICE_DETAIL]
                    (
                        [INVOICE_ID],
                        [INVOICE_SERIAL],
                        [SKU],
                        [LINE_SEQ],
                        [QTY],
                        [PRICE],
                        [DISCOUNT],
                        [TOTAL_LINE],
                        [POSTED_DATETIME],
                        [SERIE],
                        [SERIE_2],
                        [REQUERIES_SERIE],
                        [COMBO_REFERENCE],
                        [INVOICE_RESOLUTION],
                        [PARENT_SEQ],
                        [IS_ACTIVE_ROUTE],
                        [ID],
                        [TAX_CODE],
                        [SALES_PACK_UNIT],
                        [STOCK_PACK_UNIT],
                        [CONVERSION_FACTOR]
                    )
                    SELECT [D].[INVOICE_ID],
                           [D].[INVOICE_SERIAL],
                           [D].[SKU],
                           [D].[LINE_SEQ],
                           [D].[QTY],
                           [D].[PRICE],
                           [D].[DISCOUNT],
                           [D].[TOTAL_LINE],
                           [D].[POSTED_DATETIME],
                           [D].[SERIE],
                           [D].[SERIE_2],
                           [D].[REQUERIES_SERIE],
                           [D].[COMBO_REFERENCE],
                           [D].[INVOICE_RESOLUTION],
                           [D].[PARENT_SEQ],
                           [D].[IS_ACTIVE_ROUTE],
                           @ID,
                           [D].[TAX_CODE],
                           [D].[SALES_PACK_UNIT],
                           [D].[STOCK_PACK_UNIT],
                           [D].[CONVERSION_FACTOR]
                    FROM @DETAIL [D];

                    -- ------------------------------------------------------------------------------------
                    -- Retorna el resultado
                    -- ------------------------------------------------------------------------------------
                    SELECT @ID [ID],
                           @LOGIN [LOGIN];
                    --
                    COMMIT;
					
                END TRY
                BEGIN CATCH
                    ROLLBACK;
                    --
                    DECLARE @INSERT_ERROR VARCHAR(1000) = ERROR_MESSAGE();
                    --
                    PRINT 'CATCH de insert: ' + @INSERT_ERROR;
                    --
                    RAISERROR(@INSERT_ERROR, 16, 1);
                END CATCH;
            END;
        END;
        ELSE
        BEGIN
            SET @JSON = 'No cuadra la cantidad de lineas que dice el encabezdo con las del detalle|' + @JSON;
            --
            EXEC [PACASA].[SONDA_SP_INSERT_INVOICE_LOG_EXISTS] @EXISTS_INVOICE = 0,                     -- int
                                                              @DOC_RESOLUTION = @DOC_RESOLUTION,       -- varchar(100)
                                                              @DOC_SERIE = @DOC_SERIE,                 -- varchar(100)
                                                              @DOC_NUM = @DOC_NUM,                     -- int
                                                              @CODE_ROUTE = @CODE_ROUTE,               -- varchar(50)
                                                              @CODE_CUSTOMER = @CODE_CUSTOMER,         -- varchar(50)
                                                              @POSTED_DATETIME = @HEADER_POSTEDDATIME, -- datetime
                                                              @XML = @XML,                             -- xml
                                                              @JSON = @JSON;                           -- varchar(max)
            --
            RAISERROR('No cuadra la cantidad de lineas que dice el encabezdo con las del detalle', 16, 1);
        END;
    END TRY
    BEGIN CATCH
        DECLARE @ERROR VARCHAR(1000) = ERROR_MESSAGE();
        --
        PRINT 'CATCH: ' + @ERROR;
        --
        RAISERROR(@ERROR, 16, 1);
    END CATCH;
END;