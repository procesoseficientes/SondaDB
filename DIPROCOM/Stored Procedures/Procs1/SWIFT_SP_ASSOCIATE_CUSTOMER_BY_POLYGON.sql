﻿-- =============================================
-- Autor:				rudi.garcia
-- Fecha de Creacion: 	05/10/2017 @ Reborn-TEAM Sprint Drache 
-- Description:			Sp que actualiza los clientes del poligo

/*
-- Ejemplo de Ejecucion:
				EXEC [DIPROCOM].SWIFT_SP_ASSOCIATE_CUSTOMER_BY_POLYGON @POLYGON_ID = 1
*/
-- =============================================


CREATE PROCEDURE [DIPROCOM].[SWIFT_SP_ASSOCIATE_CUSTOMER_BY_POLYGON](
  @POLYGON_ID INT 
)
AS
DECLARE @POLYGON_NAME VARCHAR(250)			 
       ,@POLYGON_ID_PARENT INT = NULL
       ,@POLYGON_TYPE VARCHAR(250)
       ,@GEOMETRY_POLYGON GEOMETRY

DECLARE @CUSTUMERS_BY_REGION TABLE (
  [CODE_CUSTOMER] VARCHAR(50)
 ,[POINT] GEOMETRY 
 ,[GPS] VARCHAR(MAX)
 ,[LATITUDE] VARCHAR(50)
 ,[LONGITUDE]VARCHAR(50)
)

DECLARE @CUSTUMERS_BY_REGION_DELETED TABLE (
  [CODE_CUSTOMER] VARCHAR(50)
)

DECLARE @NEW_CUSTOMERS TABLE (
  [CODE_CUSTOMER] VARCHAR(50)
)

DECLARE @DELETED_CUSTOMERS TABLE (
  [CODE_CUSTOMER] VARCHAR(50)
)

SELECT
  
  @POLYGON_ID_PARENT = [P].[POLYGON_ID_PARENT]
  ,@POLYGON_NAME = [P].[POLYGON_NAME]
  ,@POLYGON_TYPE = [P].[POLYGON_TYPE]
FROM [DIPROCOM].[SWIFT_POLYGON] [P]
WHERE [P].[POLYGON_ID] = @POLYGON_ID



SET @GEOMETRY_POLYGON = [DIPROCOM].[SWIFT_GET_GEOMETRY_POLYGON_BY_POLIGON_ID](@POLYGON_ID);

IF @POLYGON_TYPE = 'REGION'
BEGIN

  INSERT INTO @CUSTUMERS_BY_REGION ([CODE_CUSTOMER], [POINT])
    SELECT
      [CAP].[CODE_CUSTOMER]
     ,[geometry]::[Point]([C].[LATITUDE], [C].[LONGITUDE], 0) [POINT]     
    FROM [DIPROCOM].[SWIFT_CUSTOMER_ASSOCIATE_TO_POLYGON] [CAP]
    INNER JOIN [DIPROCOM].[SWIFT_VIEW_ALL_COSTUMER] [C]
      ON (
      [CAP].[CODE_CUSTOMER] = [C].[CODE_CUSTOMER]
      )
    WHERE [CAP].[POLYGON_ID] = @POLYGON_ID

  INSERT INTO @NEW_CUSTOMERS ([CODE_CUSTOMER])
    SELECT
      [C].[CODE_CUSTOMER]
    FROM @CUSTUMERS_BY_REGION AS [C]
    WHERE @GEOMETRY_POLYGON.[MakeValid]().[STContains]([C].[POINT]) = 1;

   INSERT INTO @DELETED_CUSTOMERS([CODE_CUSTOMER])
   SELECT
      [CC].[CODE_CUSTOMER]
   FROM  @NEW_CUSTOMERS NC
    LEFT JOIN @CUSTUMERS_BY_REGION CC ON(
      CC.[CODE_CUSTOMER] = [NC].[CODE_CUSTOMER]
    )
    WHERE CC.[CODE_CUSTOMER] IS NULL

    DELETE CAP 
    FROM [DIPROCOM].[SWIFT_CUSTOMER_ASSOCIATE_TO_POLYGON] CAP 
    INNER JOIN  @DELETED_CUSTOMERS DC ON (
      [DC].[CODE_CUSTOMER] = [CAP].[CODE_CUSTOMER]
    )

    DELETE CAP 
    FROM [DIPROCOM].[SWIFT_CUSTOMER_GPS_ASSOCIATE_TO_POLYGON] CAP 
    INNER JOIN  @DELETED_CUSTOMERS DC ON (
      [DC].[CODE_CUSTOMER] = [CAP].[CODE_CUSTOMER]
    )
END
ELSE IF (@POLYGON_TYPE = 'SECTOR') BEGIN
    
    DELETE [DIPROCOM].[SWIFT_CUSTOMER_ASSOCIATE_TO_POLYGON] WHERE [POLYGON_ID] = @POLYGON_ID    
    
    INSERT INTO @CUSTUMERS_BY_REGION ([CODE_CUSTOMER], [POINT], [GPS], [LATITUDE], [LONGITUDE])
    SELECT
      [CAP].[CODE_CUSTOMER]
     ,[geometry]::[Point]([C].[LATITUDE], [C].[LONGITUDE], 0) [POINT]     
     ,[GPS] 
     ,[LATITUDE]
     ,[LONGITUDE]
    FROM [DIPROCOM].[SWIFT_CUSTOMER_ASSOCIATE_TO_POLYGON] [CAP]
    INNER JOIN [DIPROCOM].[SWIFT_VIEW_ALL_COSTUMER] [C]
      ON (
      [CAP].[CODE_CUSTOMER] = [C].[CODE_CUSTOMER]
      )
    WHERE [CAP].[POLYGON_ID] = @POLYGON_ID_PARENT

    
    INSERT INTO @CUSTUMERS_BY_REGION_DELETED ([CODE_CUSTOMER])
    SELECT
      [CAP].[CODE_CUSTOMER]
    FROM [DIPROCOM].[SWIFT_POLYGON] [P]
    INNER JOIN [DIPROCOM].[SWIFT_CUSTOMER_ASSOCIATE_TO_POLYGON] [CAP]
      ON (
      [CAP].[POLYGON_ID] = [P].[POLYGON_ID]
      )    
    WHERE [P].[POLYGON_ID_PARENT] = @POLYGON_ID_PARENT

    DELETE CR
    FROM @CUSTUMERS_BY_REGION [CR]
    INNER JOIN @CUSTUMERS_BY_REGION_DELETED CRD ON ( [CRD].[CODE_CUSTOMER] = [CR].[CODE_CUSTOMER])

    INSERT INTO [DIPROCOM].[SWIFT_CUSTOMER_ASSOCIATE_TO_POLYGON]
					(
						[POLYGON_ID]
						,[POLYGON_NAME]
						,[POLYGON_TYPE]
						,[CODE_CUSTOMER]
						,[GPS_CUSTOMER]
						,[LAST_UPDATE]
	  				)
			SELECT
				@POLYGON_ID
				,@POLYGON_NAME
				,@POLYGON_TYPE
				,[C].[CODE_CUSTOMER]
				,[C].[GPS]
				,GETDATE()
			FROM
				@CUSTUMERS_BY_REGION AS [C]
			WHERE
				@GEOMETRY_POLYGON.[MakeValid]().[STContains]([C].[POINT]) = 1;
END
