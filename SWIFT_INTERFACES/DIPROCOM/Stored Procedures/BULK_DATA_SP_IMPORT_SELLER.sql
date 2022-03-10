-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	29-02-2016
-- Description:			SP que importa vendedores de SAP

-- Modificacion 04-Apr-17 @ A-Team Sprint Garai
					-- alberto.ruiz
					-- Se ajusto para que inserte en la tabla de Swift_Express

-- Modificacion 25-Apr-17 @ A-Team Sprint Hondo
					-- alberto.ruiz
					-- Se agrega la columna de GPS

-- Modificacion 08-Jun-17 @ A-Team Sprint Jibade
					-- alberto.ruiz
					-- Se agrega columna source

/*
-- Ejemplo de Ejecucion:
				-- 
				EXEC [DIPROCOM].[BULK_DATA_SP_IMPORT_SELLER]
*/
-- =============================================
CREATE PROCEDURE [DIPROCOM].[BULK_DATA_SP_IMPORT_SELLER]
AS
BEGIN

	TRUNCATE TABLE  [SWIFT_EXPRESS_QA].DIPROCOM.[SWIFT_SELLER]

	SET NOCOUNT ON;
	--
	MERGE [SWIFT_EXPRESS_QA].DIPROCOM.[SWIFT_SELLER] TRG
	USING (SELECT * FROM SWIFT_INTERFACES_ONLINE_QA.DIPROCOM.ERP_VIEW_SELLER) AS SRC
	ON 
		TRG.SELLER_CODE = SRC.SELLER_CODE
		AND [TRG].[OWNER] = [SRC].[OWNER]
		AND [TRG].[OWNER_ID] = [SRC].[OWNER_ID]
	WHEN MATCHED THEN 
		UPDATE 
			SET TRG.[SELLER_CODE] = SRC.[SELLER_CODE]
			  ,TRG.[SELLER_NAME] = SRC.[SELLER_NAME]
			  ,[TRG].[OWNER] = [SRC].[OWNER]
			  ,[TRG].[OWNER_ID] = [SRC].[OWNER_ID]
			  ,[TRG].[GPS] = [SRC].[GPS]
			  ,[TRG].[SOURCE] = [SRC].[OWNER]
	WHEN NOT MATCHED THEN 
	INSERT (
		[SELLER_CODE]
		,[SELLER_NAME]
		,[OWNER]
		,[OWNER_ID]
		,[GPS]
		,[SOURCE]
		,[STATUS]
	)
	VALUES (
		SRC.[SELLER_CODE]
		,SRC.[SELLER_NAME]
		,[SRC].[OWNER]
		,[SRC].[OWNER_ID]
		,[SRC].[GPS]
		,[SRC].[OWNER]
		,'ACTIVE'
	);
END