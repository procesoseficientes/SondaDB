﻿-- Modificacion 4/3/2017 @ A-Team Sprint Garai
-- diego.as
-- Se agrega la columna IS_READY_TO_SEND para filtrar las facturas.

-- Modificacion 7/30/2017 @ Reborn-Team Sprint Bearbeitung
-- diego.as
-- Se agrega columna TELEPHONE_NUMBER al select

-- Modificacion 12/15/2017 @ Reborn-Team Sprint Pannen
-- diego.as
-- Se agrega columna COMMENT al select				

-- Modificacion			
-- 16-12-2018 
-- Christian Hernandez
-- Se agregaron las columnas de lista de tipo de pago, pago al credito y en efectivo. 

-- Modificacion 20/11/2019 @ A-Team Sprint Oslo
-- Denis Villagrán
-- Se agregaron las columnas relacionadas con las operaciones de FEL.
-- [ELECTRONIC_SIGNATURE], [DOCUMENT_SERIES], [DOCUMENT_NUMBER], [DOCUMENT_URL],
-- [SHIPMENT], [VALIDATION_RESULT], [SHIPMENT_DATETIME], [SHIPMENT_RESPONSE]
/*==========================================

	EXEC [acsa].[SWIFT_SP_GET_INVOICE]
		@DATE_FROM = '7/30/2017',
		@DATE_TO = '12/31/2017'

==========================================*/
CREATE PROC [acsa].[SWIFT_SP_GET_INVOICE]
    @DATE_FROM DATE,
    @DATE_TO DATE
AS
BEGIN
    SELECT [I].[INVOICE_ID],
           [I].[TERMS],
           [I].[POSTED_DATETIME],
           [I].[CLIENT_ID],
           [I].[POS_TERMINAL],
           [I].[TOTAL_AMOUNT],
           [I].[CASH_AMOUNT],
           [I].[CREDIT_AMOUNT],
           (CASE
                WHEN [I].[CREDIT_AMOUNT] > 0 THEN
                    'Crédito'
                ELSE
                    'Contado'
            END
           ) AS [TYPE_INVOICE],
           [I].[STATUS],
           [I].[POSTED_BY],
           [I].[IMAGE_1],
           [I].[IMAGE_2],
           [I].[IMAGE_3],
           [I].[IS_POSTED_OFFLINE],
           [I].[INVOICED_DATETIME],
           [I].[DEVICE_BATTERY_FACTOR],
           [I].[CDF_INVOICENUM],
           [I].[CDF_DOCENTRY],
           [I].[CDF_SERIE],
           [I].[CDF_NIT],
           [I].[CDF_NOMBRECLIENTE],
           [I].[CDF_RESOLUCION],
           [I].[CDF_POSTED_ERP],
           [I].[IS_CREDIT_NOTE],
           (CASE
                WHEN [I].[VOID_DATETIME] IS NULL THEN
                    'N/A'
                ELSE
                    CAST(CONVERT(DATE, [I].[VOID_DATETIME]) AS VARCHAR)
            END
           ) AS [VOID_DATETIME],
           [I].[CDF_PRINTED_COUNT],
           (CASE
                WHEN [I].[VOID_REASON] IS NULL THEN
                    'N/A'
                ELSE
                    [I].[VOID_REASON]
            END
           ) AS [VOID_REASON],
           [I].[VOID_NOTES],
           [I].[VOIDED_INVOICE],
           [I].[CLOSED_ROUTE_DATETIME],
           [I].[CLEARING_DATETIME],
           (CASE
                WHEN [I].[IS_ACTIVE_ROUTE] = 1 THEN
                    'En ruta'
                ELSE
                    'Ruta finalizada'
            END
           ) AS [IS_ACTIVE_ROUTE],
           (CASE
                WHEN [I].[VOIDED_INVOICE] IS NULL THEN
                    'Emitido'
                ELSE
                    'Anulado'
            END
           ) AS [STATUS_DOC],
           --,I.[GPS_URL] AS [GPS_INVOICE]
           SUBSTRING([I].[GPS_URL], 1, CHARINDEX(',', [I].[GPS_URL]) - 1) AS [GPS_INVOICE_LATITUDE],
           SUBSTRING([I].[GPS_URL], CHARINDEX(',', [I].[GPS_URL]) + 1, LEN([I].[GPS_URL])) AS [GPS_INVOICE_LONGITUDE],
           --,I.[GPS_EXPECTED] AS [GPS_EXPECTED]
           SUBSTRING([I].[GPS_EXPECTED], 1, CHARINDEX(',', [I].[GPS_EXPECTED]) - 1) AS [GPS_EXPECTED_LATITUDE],
           SUBSTRING([I].[GPS_EXPECTED], CHARINDEX(',', [I].[GPS_EXPECTED]) + 1, LEN([I].[GPS_EXPECTED])) AS [GPS_EXPECTED_LONGITUDE],
           [dbo].[SONDA_FN_CALCULATE_DISTANCE]([I].[GPS_EXPECTED], [I].[GPS_URL]) [GPS_DISTANCE],
           [I].[TELEPHONE_NUMBER],
           CASE
               WHEN [I].[COMMENT] IS NULL THEN
                   'N/A'
               ELSE
                   [I].[COMMENT]
           END AS [COMMENT],
           [I].[ELECTRONIC_SIGNATURE],
           [I].[DOCUMENT_SERIES],
           [I].[DOCUMENT_NUMBER],
           [I].[DOCUMENT_URL],
           [I].[SHIPMENT],
           [I].[VALIDATION_RESULT],
           [I].[SHIPMENT_DATETIME],
           [I].[SHIPMENT_RESPONSE]
    FROM [SWIFT_EXPRESS].[acsa].[SONDA_POS_INVOICE_HEADER] [I]
    WHERE CONVERT(DATE, [I].[POSTED_DATETIME])
          BETWEEN @DATE_FROM AND @DATE_TO
          AND [I].[IS_READY_TO_SEND] = 1
    ORDER BY [I].[CDF_SERIE],
             [I].[INVOICE_ID];


END;