-- =============================================
-- Autor:				        rudi.garcia
-- Fecha de Creacion: 	14-03-2016 
-- Description:			    Inserta un cliente proveniente de scouting

-- MODIFICADO: 26-07-2016 Sprint η
	-- Autor: diego.as
	-- Descripcion: Se agrega parametro @SYNC_ID y validacion con el mismo para evitar duplicidad en la insercion de un scouting

--Ejemplo de ejecucion:
/*
  EXEC [acsa].SONDA_SP_INSERT_SCOUTING
			    --Customer
          @CODE_CUSTOMER = '-10'
	        ,@NAME_CUSTOMER = 'NOMBRE PRUEBA'
	        ,@CLASSIFICATION_CUSTOMER = '60'
        	,@PHONE_CUSTOMER = '59888598'
        	,@ADDRESS_CUSTOMER = 'GT'
        	,@CONTACT_CUSTOMER = 'PEDRO'
        	,@CODE_ROUTE = '001'
        	,@SELLER_CODE = 'V001'        	
        	,@LAST_UPDATE_BY = 'OPER1@DIPROCOM'        	
        	,@SING = ''
        	,@PHOTO = ''
        	,@STATUS = 'NEW'
        	,@NEW = '1'
        	,@GPS = '14.594135,-90.4948001'
        	,@REFERENCE = 'MIXCO'
        	,@POST_DATETIME = '10-Nov-15 9:37:50 AM'
        	,@POS_SALE_NAME = 'Anonimo'
        	,@INVOICE_NAME = 'Nombre Facturacion'
        	,@INVOICE_ADDRESS = 'Direccion Facturacion'
        	,@NIT = '45455-45'
        	,@CONTACT_ID = 'LUIS'
			,@SYNC_ID = 'oper203@DIPROCOM2016/07/2517:11:47'
          --Frequency
          ,@MONDAY = '1'
          ,@TUESDAY = '0'
          ,@WEDNESDAY = '1'
          ,@THURSDAY = '1'
          ,@FRIDAY = '0'
          ,@SATURDAY = '0'
          ,@SUNDAY = '0'          
          ,@FREQUENCY_WEEKS = '1'
          ,@LAST_DATE_VISITED = '09-Nov-15'

					SELECT * 
          FROM [acsa].SWIFT_CUSTOMERS_NEW
          --WHERE CODE_CUSTOMER = 'C8888'
          ORDER BY CUSTOMER DESC

          SELECT *
          FROM [acsa].SWIFT_CUSTOMER_FREQUENCY_NEW 
          --WHERE CODE_CUSTOMER = 'C8888'
          ORDER BY CODE_FREQUENCY DESC
*/

-- =============================================
CREATE PROCEDURE [acsa].[SONDA_SP_INSERT_SCOUTING_Pruebas]
	-- ----------------------------------------------------------------------------------
  -- Parametros para customer
	-- ----------------------------------------------------------------------------------
  @CODE_CUSTOMER VARCHAR(50)
	,@NAME_CUSTOMER VARCHAR(50)
	,@CLASSIFICATION_CUSTOMER VARCHAR(50) = NULL
	,@PHONE_CUSTOMER VARCHAR(50) = NULL
	,@ADDRESS_CUSTOMER VARCHAR(MAX) = NULL
	,@CONTACT_CUSTOMER VARCHAR(50) = NULL
	,@CODE_ROUTE VARCHAR(50)
	,@SELLER_CODE VARCHAR(50) = NULL	
	,@LAST_UPDATE_BY VARCHAR(50)
	--,@HHID VARCHAR(50) = NULL
	,@SING VARCHAR(MAX) = NULL
	,@PHOTO VARCHAR(MAX) = NULL
	,@STATUS VARCHAR(20) = NULL
	,@NEW VARCHAR(10) = 1
	,@GPS VARCHAR(MAX) = '0,0'
	,@REFERENCE VARCHAR(150) = NULL	
	,@POST_DATETIME datetime = NULL
	,@POS_SALE_NAME VARCHAR(150) = '...'
	,@INVOICE_NAME VARCHAR(150) = '...'
	,@INVOICE_ADDRESS VARCHAR(150) = '...'
	,@NIT VARCHAR(150) = '...'
	,@CONTACT_ID VARCHAR(150) = '...'
	,@SYNC_ID VARCHAR(250)

  -- ----------------------------------------------------------------------------------
  -- Parametros para frequency
	-- ----------------------------------------------------------------------------------
  ,@MONDAY VARCHAR(2) 
  ,@TUESDAY VARCHAR(2)
  ,@WEDNESDAY VARCHAR(2)
  ,@THURSDAY VARCHAR(2)
  ,@FRIDAY VARCHAR(2)
  ,@SATURDAY VARCHAR(2)
  ,@SUNDAY VARCHAR(2)  
  ,@FREQUENCY_WEEKS VARCHAR(2) = NULL
  ,@LAST_DATE_VISITED DATETIME = NULL
AS
BEGIN
  	SET NOCOUNT ON;
  	DECLARE @ID INT
          ,@HHID VARCHAR(50) = NULL
		  ,@EXISTE INT = 0
		 
		 BEGIN TRAN
			BEGIN TRY
		  
		--
		--SELECT @EXISTE = COUNT(*) FROM [acsa].SWIFT_CUSTOMERS_NEW WHERE SYNC_ID = @SYNC_ID
		
		--
	    IF(SELECT @EXISTE) = 0 BEGIN --SI NO EXISTE EL ID DE SINCRONIZACION
			PRINT('Se inserta el cliente')
			-- ----------------------------------------------------------------------------------
			-- Se inserte el cliente
			-- ----------------------------------------------------------------------------------
			INSERT INTO [acsa].[SWIFT_CUSTOMERS_NEW](
				  [CODE_CUSTOMER]
    				,[NAME_CUSTOMER]
        			,[CLASSIFICATION_CUSTOMER]
        			,[PHONE_CUSTOMER]
        			,[ADRESS_CUSTOMER]
        			,[CONTACT_CUSTOMER]
        			,[CODE_ROUTE]
        			,[LAST_UPDATE]
        			,[LAST_UPDATE_BY]
        			,[SELLER_DEFAULT_CODE]
        			,[SIGN]
        			,[PHOTO]
        			,[STATUS]
        			,[NEW]
        			,[GPS]
        			,[CODE_CUSTOMER_HH]
        			,[REFERENCE]
        			,[POST_DATETIME]
        			,[POS_SALE_NAME]
        			,[INVOICE_NAME]
        			,[INVOICE_ADDRESS]
        			,[NIT]
        			,[CONTACT_ID]
        			,[LATITUDE]
        			,[LONGITUDE]
					,[SYNC_ID]
				)
			  VALUES (
				  @HHID
					,@NAME_CUSTOMER
					,@CLASSIFICATION_CUSTOMER
					,@PHONE_CUSTOMER
					,@ADDRESS_CUSTOMER
					,@CONTACT_CUSTOMER
					,@CODE_ROUTE
					,GETDATE()
					,@LAST_UPDATE_BY
					,@SELLER_CODE
        			,@SING
        			,@PHOTO
        			,@STATUS
        			,@NEW
        			,@GPS
					,@CODE_CUSTOMER
					,@REFERENCE
        			,@POST_DATETIME
        			,@POS_SALE_NAME
        			,@INVOICE_NAME
        			,@INVOICE_ADDRESS
        			,@NIT
        			,@CONTACT_ID
        			,RTRIM(LTRIM(SUBSTRING(@GPS,1,CHARINDEX(',',@GPS) - 1)))
        			,RTRIM(LTRIM(SUBSTRING(@GPS,CHARINDEX(',',@GPS) + 1,LEN(@GPS))))
					,@SYNC_ID
			  )
		  
			  --
			  PRINT('Se obtiene el id generado')
			  
			  -- ----------------------------------------------------------------------------------
			  -- Se obtiene el id generado
			  -- ----------------------------------------------------------------------------------  
			  SELECT @ID = SCOPE_IDENTITY()
			  PRINT(@ID)      
			  
			  --
			  PRINT('Validar si el CODE_CUSTOMER es nulo, se actualiza el CODE_CUSTOMER con el id generado')
  
			  -- ----------------------------------------------------------------------------------
			  -- Validar si el CODE_CUSTOMER es nulo, se actualiza el CODE_CUSTOMER con el id generado
			  -- ----------------------------------------------------------------------------------      
     
			  UPDATE [acsa].[SWIFT_CUSTOMERS_NEW] SET
			  [CODE_CUSTOMER] = 'SO-' + CONVERT(VARCHAR(10), @ID)
			  WHERE CUSTOMER = @ID
			  
			  --
			  SET @HHID = 'SO-' + CONVERT(VARCHAR(10), @ID)
     
			  --
			  PRINT('Se inserte la frecuencia del cliente')

			  -- ----------------------------------------------------------------------------------
			  -- Se inserte la frecuencia del cliente
			  -- ----------------------------------------------------------------------------------
			  INSERT [acsa].SWIFT_CUSTOMER_FREQUENCY_NEW(          
        			CODE_CUSTOMER
        			,SUNDAY
        			,MONDAY
        			,TUESDAY
        			,WEDNESDAY
        			,THURSDAY
        			,FRIDAY
        			,SATURDAY
        			,LAST_UPDATED
        			,LAST_UPDATED_BY
				    ,FREQUENCY_WEEKS
        			,LAST_DATE_VISITED          
				)	
				VALUES (
        			@HHID
        			,@SUNDAY
        			,@MONDAY
        			,@TUESDAY
        			,@WEDNESDAY
        			,@THURSDAY
        			,@FRIDAY
        			,@SATURDAY
        			,GETDATE()
				    ,@LAST_UPDATE_BY
        			,@FREQUENCY_WEEKS
        			,@LAST_DATE_VISITED
				);

				--
			    SELECT @HHID AS ID
	    END
				--
			    COMMIT TRAN

		--
		END TRY
		BEGIN CATCH
			ROLLBACK
			DECLARE @ERROR VARCHAR(1000)= ERROR_MESSAGE()
			RAISERROR (@ERROR,16,1)
		END CATCH
		
END
