-- =============================================
-- Autor:				diego.as
-- Fecha de Creacion: 	6/19/2019 @ G-Force Team Sprint Dubai
-- Historia/Bug:		Product Backlog Item 29713: Agregar funcionalidad de Cobros en Preventa
-- Description:			SP que obtiene todas las facturas vencidas para los clientes de la ruta que recibe como parametro     

-- Modificacion 		7/12/2019 @ G-Force Team Sprint Estocolmo
-- Autor: 				diego.as
-- Historia/Bug:		Product Backlog Item 30461: Visualizacion de Ultima fecha y precio de compra
-- Descripcion: 		7/12/2019 - Se agrega columna LAST_PURCHASE_DATE por modificacion al SP [SWIFT_SP_GET_CUSTUMER_FOR_SCOUTING]

/*
-- Ejemplo de Ejecucion:
        EXEC [PACASA].[SONDA_SP_GET_OVERDUE_INVOICE_BY_CUSTOMER_FOR_ROUTE] @CODE_ROUTE = 'RP-01'

	'CLIE008426               ''CLIE008426'
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SONDA_SP_GET_OVERDUE_INVOICE_BY_CUSTOMER_FOR_ROUTE]
(@CODE_ROUTE AS VARCHAR(50))
AS
BEGIN
    --
    -- ------------------------------------------------------------------------------------
    -- Tabla que almacena el listado de clientes de la ruta
    -- ------------------------------------------------------------------------------------
    DECLARE @CUSTOMER TABLE
    (
        [CODE_CUSTOMER] VARCHAR(50),
        [NAME_CUSTOMER] VARCHAR(250),
        [TAX_ID_NUMBER] VARCHAR(50),
        [ADRESS_CUSTOMER] VARCHAR(250),
        [PHONE_CUSTOMER] VARCHAR(250),
        [CONTACT_CUSTOMER] VARCHAR(250),
        [CREDIT_LIMIT] NUMERIC(18, 6),
        [EXTRA_DAYS] INT,
        [DISCOUNT] NUMERIC(18, 6),
        [GPS] VARCHAR(250),
        [RGA_CODE] VARCHAR(150),
        [DISCOUNT_LIST_ID] INT,
        [BONUS_LIST_ID] INT,
        [PRICE_LIST_ID] VARCHAR(50),
        [SALES_BY_MULTIPLE_LIST_ID] INT,
        [PREVIUS_BALANCE] DECIMAL(18, 6),
        [LAST_PURCHASE] NUMERIC(18, 6),
        [INVOICE_NAME] VARCHAR(250),
        [SPECIAL_PRICE_LIST_ID] INT,
        [CODE_CHANNEL] VARCHAR(25),
        [GROUP_NUM] INT,
        [OUTSTANDING_BALANCE] NUMERIC(18, 6),
        [LAST_PURCHASE_DATE] DATE
    );


    -- ----------------------------------------------------------------------------------
    -- Se obtienen todos los clientes de la ruta actual
    -- ----------------------------------------------------------------------------------
    INSERT INTO @CUSTOMER
    EXEC [PACASA].[SWIFT_SP_GET_CUSTUMER_FOR_SCOUTING] @CODE_ROUTE = @CODE_ROUTE; -- varchar(50)

    -- -------------------------------------------------------------------------------------------
    -- Obtenemos las facturas del cliente o los clientes que se hayan configurado
    -- -------------------------------------------------------------------------------------------
    SELECT [OI].[ID],
           [OI].[INVOICE_ID],
           [OI].[DOC_ENTRY],
           LTRIM(RTRIM([OI].[CODE_CUSTOMER])) AS CODE_CUSTOMER,
           [OI].[CREATED_DATE],
           [OI].[DUE_DATE],
           [OI].[TOTAL_AMOUNT],
           [OI].[PENDING_TO_PAID],
           [OI].[IS_EXPIRED]
    FROM [PACASA].[SWIFT_OVERDUE_INVOICE_BY_CUSTOMER] AS [OI]
        INNER JOIN @CUSTOMER AS [C]
            ON [C].[CODE_CUSTOMER] = [OI].[CODE_CUSTOMER]
    WHERE [OI].[ID] > 0;

END;