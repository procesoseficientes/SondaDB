-- =============================================
-- Autor:				diego.as
-- Fecha de Creacion: 	11/17/2017 @ Reborn - TEAM Sprint Eberhard  
-- Description:			SP que obtiene los registros de la autorizacion de facturacion

-- Modificacion 		12/2/2019 @ G-Force Team Sprint Oslo
-- Autor: 				diego.as
-- Historia/Bug:		Product Backlog Item 33218: Configuración de Frases y Escenarios
-- Descripcion: 		12/2/2019 - Se agregan columnas FEL_DOCUMENT_TYPE y FEL_STABLISHMENT_CODE

/*
-- Ejemplo de Ejecucion:
			EXEC [PACASA].[SONDA_SP_GET_COMPLETE_AUTHORIZATION_INFO]
			@AUTH_ASSIGNED_TO = '46'
			,@AUTH_DOC_TYPE = 'FACTURA'
			,@AUTH_STATUS = '1'
			,@INVOICE_IN_ROUTE = 1
*/
-- =============================================
CREATE PROCEDURE [PACASA].[SONDA_SP_GET_COMPLETE_AUTHORIZATION_INFO]
(
    @AUTH_ASSIGNED_TO VARCHAR(100),
    @AUTH_DOC_TYPE VARCHAR(100),
    @AUTH_STATUS VARCHAR(10),
    @INVOICE_IN_ROUTE INT
)
AS
BEGIN
    --
    SET NOCOUNT ON;

    --
    SELECT [S].[ROWPK],
           [S].[AUTH_ID],
           [S].[AUTH_ASSIGNED_DATETIME],
           [S].[AUTH_POST_DATETIME],
           [S].[AUTH_ASSIGNED_BY],
           [S].[AUTH_DOC_FROM],
           [S].[AUTH_DOC_TO],
           [S].[AUTH_SERIE],
           [S].[AUTH_DOC_TYPE],
           [S].[AUTH_ASSIGNED_TO],
           [S].[AUTH_CURRENT_DOC],
           [S].[AUTH_LIMIT_DATETIME],
           [S].[AUTH_STATUS],
           [S].[AUTH_BRANCH_NAME],
           [S].[AUTH_BRANCH_ADDRESS],
           [S].[BRANCH_ADDRESS2],
           [S].[BRANCH_ADDRESS3],
           [S].[BRANCH_ADDRESS4],
           [S].[AUTH_TYPE],
           [E].[CODE_ENTERPRISE],
           [E].[NAME_ENTERPRISE],
           [E].[NIT] [NIT_ENTERPRISE],
           [E].[ENTERPRISE_EMAIL_ADDRESS],
           [E].[PHONE_NUMBER],
           [U].[NAME_USER],
           @INVOICE_IN_ROUTE [INVOICE_IN_ROUTE],
           [S].[FEL_DOCUMENT_TYPE],
           [S].[FEL_STABLISHMENT_CODE]
    FROM [PACASA].[SONDA_POS_RES_SAT] [S]
        INNER JOIN [PACASA].[USERS] [U]
            ON ([S].[AUTH_ASSIGNED_TO] = [U].[SELLER_ROUTE])
        INNER JOIN [dbo].[SWIFT_ENTERPRISE] [E]
            ON ([E].[CODE_ENTERPRISE] = [U].[ENTERPRISE])
    WHERE [S].[AUTH_ASSIGNED_TO] = @AUTH_ASSIGNED_TO
          AND [S].[AUTH_DOC_TYPE] = @AUTH_DOC_TYPE
          AND [S].[AUTH_STATUS] = @AUTH_STATUS;
END;