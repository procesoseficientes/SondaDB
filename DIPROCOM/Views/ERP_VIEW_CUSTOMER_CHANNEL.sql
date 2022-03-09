
-- =============================================
-- Autor:			alejandro.ochoa
-- Fecha: 			6/01/2017 @Logistica3W
-- Description:		Se crea la vista para obtener Maestro de Canales y Clientes Asociados

/*
-- Ejemplo de Ejecucion:
    USE SWIFT_INTERFACES_ONLINE
    GO
    
     SELECT  * FROM  l3w.[ERP_VIEW_CUSTOMER_CHANNEL]
GO
*/
-- =============================================
CREATE VIEW [DIPROCOM].[ERP_VIEW_CUSTOMER_CHANNEL]
AS

SELECT
 NULL ChannelID
 ,NULL ChannelName
 ,NULL	Code_Customer
 ,NULL [Owner]
 ,NULL ChannelType
 ,NULL LAST_UPDATE_BY