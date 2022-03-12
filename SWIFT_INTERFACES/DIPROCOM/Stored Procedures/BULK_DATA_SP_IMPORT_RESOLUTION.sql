-- =============================================
-- Autor:				alejandro.ochoa
-- Fecha de Creacion: 	30-04-2018
-- Description:			SP que importa Resoluciones

/*
-- Ejemplo de Ejecucion:
				-- 
				EXEC [SONDA].[BULK_DATA_SP_IMPORT_RESOLUTION]
*/
-- =============================================
CREATE PROCEDURE [SONDA].[BULK_DATA_SP_IMPORT_RESOLUTION]
AS
BEGIN
  SET NOCOUNT ON;
  --	
	MERGE [SWIFT_EXPRESS].[SONDA].[SONDA_POS_RES_SAT] [TRG]
	USING
		(SELECT [R].*, [U].[SELLER_ROUTE] 
			FROM [SWIFT_INTERFACES_ONLINE].[SONDA].[ERP_VIEW_RESOLUTION] R
			INNER JOIN [SWIFT_EXPRESS].[SONDA].[USERS] U ON [R].[Vendedor_Asignado] = [U].[RELATED_SELLER]) AS [SRC]
	ON [TRG].[AUTH_ID] = [SRC].[CAI] AND [TRG].[AUTH_SERIE] = [SRC].[SERIE]
	WHEN MATCHED THEN
		UPDATE SET
				[TRG].[AUTH_BRANCH_NAME] = [SRC].[Nombre]
				,[TRG].[AUTH_BRANCH_ADDRESS] = [SRC].[Direccion_1]
				,[TRG].[BRANCH_ADDRESS2] = [SRC].[Direccion_2]
				,[TRG].[BRANCH_ADDRESS3] = [SRC].[Direccion_3]
				,[TRG].[BRANCH_ADDRESS4] = [SRC].[Direccion_4]
				,[TRG].[AUTH_LIMIT_DATETIME] = [SRC].[Fecha_Vencimiento]
				,[TRG].[AUTH_ASSIGNED_TO] = [SRC].[SELLER_ROUTE]
	WHEN NOT MATCHED THEN
		INSERT
		( 
			[AUTH_ID] ,
			[AUTH_ASSIGNED_DATETIME] ,
			[AUTH_POST_DATETIME] ,
			[AUTH_ASSIGNED_BY] ,
			[AUTH_DOC_FROM] ,
			[AUTH_DOC_TO] ,
			[AUTH_SERIE] ,
			[AUTH_DOC_TYPE] ,
			[AUTH_ASSIGNED_TO] ,
			[AUTH_CURRENT_DOC] ,
			[AUTH_LIMIT_DATETIME] ,
			[AUTH_STATUS] ,
			[AUTH_BRANCH_NAME] ,
			[AUTH_BRANCH_ADDRESS] ,
			[AUTH_TYPE] ,
			[BRANCH_ADDRESS2] ,
			[BRANCH_ADDRESS3] ,
			[BRANCH_ADDRESS4]
		)
		VALUES  ( [SRC].[Cai] , -- AUTH_ID - varchar(50)
				  GETDATE() , -- AUTH_ASSIGNED_DATETIME - datetime
				  [SRC].[Fecha_Autorizacion] , -- AUTH_POST_DATETIME - datetime
				  'BULK_DATA' , -- AUTH_ASSIGNED_BY - varchar(100)
				  [SRC].[Rango_Inicio] , -- AUTH_DOC_FROM - int
				  [SRC].[Rango_Final] , -- AUTH_DOC_TO - int
				  [SRC].[Serie] , -- AUTH_SERIE - varchar(100)
				  'FACTURA' , -- AUTH_DOC_TYPE - varchar(100)
				  [SRC].[SELLER_ROUTE] , -- AUTH_ASSIGNED_TO - varchar(100)
				  [SRC].[Numero_Actual] , -- AUTH_CURRENT_DOC - int
				  [SRC].[Fecha_Vencimiento] , -- AUTH_LIMIT_DATETIME - datetime
				  '1' , -- AUTH_STATUS - varchar(15)
				  [SRC].[Nombre] , -- AUTH_BRANCH_NAME - varchar(50)
				  [SRC].[Direccion_1] , -- AUTH_BRANCH_ADDRESS - varchar(150)
				  'HANDHELD' , -- AUTH_TYPE - varchar(150)
				  [SRC].[Direccion_2] , -- BRANCH_ADDRESS2 - varchar(30)
				  [SRC].[Direccion_3] , -- BRANCH_ADDRESS3 - varchar(30)
				  [SRC].[Direccion_4]  -- BRANCH_ADDRESS4 - varchar(30)
				);

END