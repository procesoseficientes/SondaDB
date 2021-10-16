CREATE PROCEDURE [DIPROCOM].[SONDA_SP_ADD_SALES_ORDER_BY_XML_BK] (@XML XML
, @JSON VARCHAR(MAX))
AS
BEGIN
  SET NOCOUNT ON;
  --
  DECLARE @DETAIL TABLE (
    [SKU] [VARCHAR](25) NOT NULL
   ,[LINE_SEQ] [INT] NOT NULL
   ,[QTY] [NUMERIC](18, 2) NULL
   ,[PRICE] [MONEY] NULL
   ,[DISCOUNT] [MONEY] NULL
   ,[TOTAL_LINE] [MONEY] NULL
   ,[POSTED_DATETIME] [DATETIME] NULL
   ,[SERIE] [VARCHAR](50) NULL
   ,[SERIE_2] [VARCHAR](50) NULL
   ,[REQUERIES_SERIE] [INT] NULL
   ,[COMBO_REFERENCE] [VARCHAR](50) NULL
   ,[PARENT_SEQ] [INT] NULL
   ,[IS_ACTIVE_ROUTE] [INT] NULL
   ,[CODE_PACK_UNIT] [VARCHAR](50) NULL
   ,[IS_BONUS] [INT] NULL
   ,[LONG] [NUMERIC](18, 6) NULL
  );
  --
  DECLARE @RESULT_VALIDATION TABLE (
    [EXISTS] [INT]
   ,[SALES_ORDER_ID] [INT]

  )
  --
  DECLARE @ID INT
         ,@HEADER_POSTEDDATIME DATETIME
         ,@DETAIL_QTY INT
         ,@HEADER_DETAIL_QTY INT
         ,@DOC_SERIE VARCHAR(100)
         ,@DOC_NUM INT
         ,@CODE_ROUTE VARCHAR(50)
         ,@CODE_CUSTOMER VARCHAR(50)
         ,@EXISTS INT = 0
         ,@SALES_ORDER_ID INT
         ,@WAREHOUSE VARCHAR(50)
         ,@DEVICE_ID VARCHAR(50);
		 --,@COMMITTED_INVENTORY INT;
  --
  BEGIN TRY
    -- ------------------------------------------------------------------------------------
    -- Obtiene la fecha del encabezado
    -- ------------------------------------------------------------------------------------
    SELECT
      @HEADER_POSTEDDATIME = x.Rec.query('./PostedDatetime').value('.', 'datetime')
     ,@HEADER_DETAIL_QTY = x.Rec.query('./DetailQty').value('.', 'int')
     ,@DOC_SERIE = x.Rec.query('./DocSerie').value('.', 'varchar(50)')
     ,@DOC_NUM = x.Rec.query('./DocNum').value('.', 'int')
     ,@CODE_ROUTE = x.Rec.query('./PosTerminal').value('.', 'varchar(50)')
     ,@CODE_CUSTOMER = x.Rec.query('./ClientId').value('.', 'varchar(50)')
    FROM @XML.nodes('/Data/salesOrder') AS x (Rec)

    -- ------------------------------------------------------------------------------------
    -- Obtiene los datos generales de la ruta
    -- ------------------------------------------------------------------------------------
    SELECT
      @WAREHOUSE = x.Rec.query('./warehouse').value('.', 'varchar(50)')
     ,@DEVICE_ID = x.Rec.query('./uuid').value('.', 'varchar(50)')
    FROM @XML.nodes('/Data') AS x (Rec)

    -- ------------------------------------------------------------------------------------
    -- Obtiene el detalle
    -- ------------------------------------------------------------------------------------
    INSERT INTO @DETAIL ([SKU]
    , [LINE_SEQ]
    , [QTY]
    , [PRICE]
    , [DISCOUNT]
    , [TOTAL_LINE]
    , [POSTED_DATETIME]
    , [SERIE]
    , [SERIE_2]
    , [REQUERIES_SERIE]
    , [COMBO_REFERENCE]
    , [PARENT_SEQ]
    , [IS_ACTIVE_ROUTE]
    , [CODE_PACK_UNIT]
    , [IS_BONUS]
    , [LONG])
      SELECT
        x.Rec.query('./Sku').value('.', 'varchar(50)')
       ,x.Rec.query('./LineSeq').value('.', 'int')
       ,x.Rec.query('./Qty').value('.', 'int')
       ,x.Rec.query('./Price').value('.', 'money')
       ,x.Rec.query('./Discount').value('.', 'money')
       ,x.Rec.query('./TotalLine').value('.', 'money')
       ,@HEADER_POSTEDDATIME
       ,x.Rec.query('./Serie').value('.', 'varchar(50)')
       ,x.Rec.query('./Serie2').value('.', 'varchar(50)')
       ,x.Rec.query('./RequeriesSerie').value('.', 'int')
       ,x.Rec.query('./ParentSeq').value('.', 'varchar(50)')
       ,x.Rec.query('./RequeriesSerie').value('.', 'int')
       ,x.Rec.query('./IsActiveRoute').value('.', 'int')
       ,x.Rec.query('./CodePackUnit').value('.', 'varchar(50)')
       ,x.Rec.query('./IsBonus').value('.', 'int')
       ,CASE x.Rec.query('./Long').value('.', 'varchar(50)')
          WHEN 'null' THEN NULL
          ELSE x.Rec.query('./Long').value('.', 'varchar(50)')
        END
      FROM @XML.nodes('/Data/salesOrder/SaleDetails') AS x (Rec)
    --
    SET @DETAIL_QTY = @@rowcount

    -- ------------------------------------------------------------------------------------
    -- Valida cantidad de detalle con la del encabezado
    -- ------------------------------------------------------------------------------------
    IF (@DETAIL_QTY = @HEADER_DETAIL_QTY)
    BEGIN
      -- ------------------------------------------------------------------------------------
      -- Valida si existe la orden de venta
      -- ------------------------------------------------------------------------------------
	  --SET @COMMITTED_INVENTORY=0
      INSERT INTO @RESULT_VALIDATION
      EXEC [DIPROCOM].[SONDA_SP_VALIDATED_IF_EXISTS_SALES_ORDER_2] @DOC_SERIE = @DOC_SERIE
                                                               ,@DOC_NUM = @DOC_NUM
                                                               , -- int
                                                                @CODE_ROUTE = @CODE_ROUTE
                                                               , -- varchar(50)
                                                                @CODE_CUSTOMER = @CODE_CUSTOMER
                                                               , -- varchar(50)
                                                                @POSTED_DATETIME = @HEADER_POSTEDDATIME
                                                               , -- datetime
                                                                @DETAIL_QTY = 0
                                                               , -- int
                                                                @XML = @XML
                                                               , -- xml
                                                                @JSON = @JSON
                                                               , -- varchar(max)
                                                                @COMMITTED_INVENTORY = 0 -- int
      --
      SELECT
        @EXISTS = [R].[EXISTS]
       ,@SALES_ORDER_ID = [R].[SALES_ORDER_ID]
      FROM @RESULT_VALIDATION [R]
      --
      IF (@EXISTS = 1)
      BEGIN
        PRINT '--> ya existe la orden de venta con el ID :' + CAST(@SALES_ORDER_ID AS VARCHAR)

--        UPDATE [DIPROCOM].[SONDA_SALES_ORDER_HEADER]
--        SET [IS_READY_TO_SEND] = 1
--        WHERE [SALES_ORDER_ID] = @SALES_ORDER_ID
--        IF (@COMMITTED_INVENTORY = 1)
--        BEGIN
--          EXEC [DIPROCOM].[SONDA_SP_COMMIT_INVENTORY_BY_SALES_ORDER_ID] @SALE_ORDER_ID = @SALES_ORDER_ID
--        END
        --
        SELECT
          @SALES_ORDER_ID [ID]
        RETURN 0
      END
      ELSE
      BEGIN
      BEGIN TRY
        BEGIN TRAN

        -- ------------------------------------------------------------------------------------
        -- Inserta el encabezado
        -- ------------------------------------------------------------------------------------
        INSERT INTO [DIPROCOM].[SONDA_SALES_ORDER_HEADER] ([TERMS]
        , [POSTED_DATETIME]
        , [CLIENT_ID]
        , [POS_TERMINAL]
        , [GPS_URL]
        , [TOTAL_AMOUNT]
        , [STATUS]
        , [POSTED_BY]
        , [IMAGE_1]
        , [IMAGE_2]
        , [IMAGE_3]
        , [DEVICE_BATTERY_FACTOR]
        , [VOID_DATETIME]
        , [VOID_REASON]
        , [VOID_NOTES]
        , [VOIDED]
        , [CLOSED_ROUTE_DATETIME]
        , [IS_ACTIVE_ROUTE]
        , [GPS_EXPECTED]
        , [DELIVERY_DATE]
        , [SALES_ORDER_ID_HH]
        , [ATTEMPTED_WITH_ERROR]
        , [IS_POSTED_ERP]
        , [POSTED_ERP]
        , [POSTED_RESPONSE]
        , [IS_PARENT]
        , [REFERENCE_ID]
        , [WAREHOUSE]
        , [TIMES_PRINTED]
        , [DOC_SERIE]
        , [DOC_NUM]
        , [IS_VOID]
        , [SALES_ORDER_TYPE]
        , [DISCOUNT]
        , [IS_DRAFT]
        , [ASSIGNED_BY]
        , [TASK_ID]
        , [COMMENT]
        , [ERP_REFERENCE]
        , [PAYMENT_TIMES_PRINTED]
        , [PAID_TO_DATE]
        , [TO_BILL]
        , [HAVE_PICKING]
        , [AUTHORIZED]
        , [AUTHORIZED_BY]
        , [AUTHORIZED_DATE]
        , [DISCOUNT_BY_GENERAL_AMOUNT]
        , [IS_READY_TO_SEND])
          SELECT
            NULL
           ,@HEADER_POSTEDDATIME
           ,x.Rec.query('./ClientId').value('.', 'varchar(50)')
           ,@CODE_ROUTE
           ,x.Rec.query('./GpsUrl').value('.', 'varchar(50)')
           ,x.Rec.query('./TotalAmount').value('.', 'money')
           ,x.Rec.query('./Status').value('.', 'int')
           ,x.Rec.query('./PostedBy').value('.', 'varchar(50)')
           ,x.Rec.query('./Image1').value('.', 'varchar(MAX)')
           ,x.Rec.query('./Image2').value('.', 'varchar(MAX)')
           ,x.Rec.query('./Image3').value('.', 'varchar(MAX)')
           ,x.Rec.query('./DeviceBatteryFactor').value('.', 'int')
           ,CASE x.Rec.query('./VoidDatetime').value('.', 'varchar(50)')
              WHEN 'null' THEN NULL
              ELSE x.Rec.query('./VoidDatetime').value('.', 'DATETIME')
            END
           ,CASE x.Rec.query('./VoidReason').value('.', 'varchar(50)')
              WHEN 'null' THEN NULL
              ELSE x.Rec.query('./VoidReason').value('.', 'VARCHAR(25)')
            END
           ,CASE x.Rec.query('./VoidNotes').value('.', 'varchar(50)')
              WHEN 'null' THEN NULL
              ELSE x.Rec.query('./VoidNotes').value('.', 'VARCHAR(MAX)')
            END
           ,CASE x.Rec.query('./Voided').value('.', 'varchar(50)')
              WHEN 'null' THEN NULL
              ELSE x.Rec.query('./Voided').value('.', 'INT')
            END
           ,CASE x.Rec.query('./ClosedRouteDatetime').value('.', 'varchar(50)')
              WHEN 'null' THEN NULL
              ELSE x.Rec.query('./ClosedRouteDatetime').value('.', 'DATETIME')
            END
           ,x.Rec.query('./IsActiveRoute').value('.', 'int')
           ,x.Rec.query('./GpsUrl').value('.', 'varchar(50)')
           ,x.Rec.query('./DeliveryDate').value('.', 'DATETIME')
           ,x.Rec.query('./SalesOrderId').value('.', 'int')
           ,0
           ,NULL
           ,NULL
           ,NULL
           ,x.Rec.query('./IsParent').value('.', 'int')
           ,x.Rec.query('./ReferenceId').value('.', 'varchar(150)')
           ,@WAREHOUSE
           ,x.Rec.query('./TimesPrinted').value('.', 'int')
           ,x.Rec.query('./DocSerie').value('.', 'varchar(50)')
           ,x.Rec.query('./DocNum').value('.', 'int')
           ,x.Rec.query('./IsVoid').value('.', 'int')
           ,x.Rec.query('./SalesOrderType').value('.', 'varchar(50)')
           ,0
           ,x.Rec.query('./IsDraft').value('.', 'int')
           ,'HH'
           ,x.Rec.query('./TaskId').value('.', 'int')
           ,x.Rec.query('./Comment').value('.', 'varchar(250)')
           ,NULL
           ,x.Rec.query('./PaymentTimesPrinted').value('.', 'int')
           ,x.Rec.query('./PaidToDate').value('.', 'numeric(18,6)')
           ,x.Rec.query('./ToBill').value('.', 'int')
           ,0
           ,x.Rec.query('./Authorized').value('.', 'int')
           ,NULL
           ,NULL
           ,x.Rec.query('./Discount').value('.', 'numeric(18,6)')
           ,0
          FROM @XML.nodes('/Data/salesOrder') AS x (Rec)
        --
        SET @ID = SCOPE_IDENTITY()

        -- ------------------------------------------------------------------------------------
        -- inserta el detalle
        -- ------------------------------------------------------------------------------------
        INSERT INTO [DIPROCOM].[SONDA_SALES_ORDER_DETAIL] ([SALES_ORDER_ID]
        , [SKU]
        , [LINE_SEQ]
        , [QTY]
        , [PRICE]
        , [DISCOUNT]
        , [TOTAL_LINE]
        , [POSTED_DATETIME]
        , [SERIE]
        , [SERIE_2]
        , [REQUERIES_SERIE]
        , [COMBO_REFERENCE]
        , [PARENT_SEQ]
        , [IS_ACTIVE_ROUTE]
        , [CODE_PACK_UNIT]
        , [IS_BONUS]
        , [LONG])
          SELECT
            @ID
           ,[D].[SKU]
           ,[D].[LINE_SEQ]
           ,[D].[QTY]
           ,[D].[PRICE]
           ,[D].[DISCOUNT]
           ,[D].[TOTAL_LINE]
           ,[D].[POSTED_DATETIME]
           ,[D].[SERIE]
           ,[D].[SERIE_2]
           ,[D].[REQUERIES_SERIE]
           ,[D].[COMBO_REFERENCE]
           ,[D].[PARENT_SEQ]
           ,[D].[IS_ACTIVE_ROUTE]
           ,[D].[CODE_PACK_UNIT]
           ,[D].[IS_BONUS]
           ,[D].[LONG]
          FROM @DETAIL [D]

        -- ------------------------------------------------------------------------------------
        -- Retorna el resultado
        -- ------------------------------------------------------------------------------------
        SELECT
          @ID [ID]
        --
        COMMIT
      END TRY
      BEGIN CATCH
        ROLLBACK
        DECLARE @INSERT_ERROR VARCHAR(1000) = ERROR_MESSAGE()
        PRINT 'CATCH de insert: ' + @INSERT_ERROR
        RAISERROR (@INSERT_ERROR, 16, 1)
      END CATCH
      END
    END
    ELSE
    BEGIN
      RAISERROR ('No cuadra la cantidad de lineas que dice el encabezdo con las del detalle', 16, 1)
    END
  END TRY
  BEGIN CATCH
    DECLARE @ERROR VARCHAR(1000) = ERROR_MESSAGE()
    PRINT 'CATCH: ' + @ERROR
    RAISERROR (@ERROR, 16, 1)
  END CATCH
END
