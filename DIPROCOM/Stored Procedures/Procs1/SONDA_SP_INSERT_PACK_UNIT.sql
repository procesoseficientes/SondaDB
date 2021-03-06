-- =============================================
-- Author:         diego.as
-- Create date:    15-02-2016
-- Description:    Inserta registros en la Tabla 
--				   [PACASA].[SONDA_PACK_UNIT]
--				   con transacción y control de errores.

/*
Ejemplo de Ejecucion:

		EXEC [PACASA].[SONDA_SP_INSERT_PACK_UNIT]
			@CODE_PACK_UNIT = 'COD001'
			,@DESCRIPTION_PACK_UNIT = 'EJEMPLO' 
			,@ORDER = 1
			,@LAST_UPDATE_BY = 'oper1@DIPROCOM' 
						
		----------------------------------------			
		SELECT * FROM [PACASA].[SONDA_PACK_UNIT]
		
				
*/
-- =============================================

CREATE PROCEDURE [PACASA].[SONDA_SP_INSERT_PACK_UNIT]
(
	@CODE_PACK_UNIT VARCHAR(25)
	,@DESCRIPTION_PACK_UNIT VARCHAR(250)
	,@ORDER INT
	,@LAST_UPDATE_BY VARCHAR(25)
)
AS
BEGIN
    SET NOCOUNT ON;
	--
	DECLARE	@ID INT

    BEGIN TRAN TransAdd
    BEGIN TRY
		
		INSERT INTO [PACASA].[SONDA_PACK_UNIT](
				[CODE_PACK_UNIT]
				,[DESCRIPTION_PACK_UNIT]
				,[ORDER]
				,[LAST_UPDATE]
				,[LAST_UPDATE_BY]
			)
		VALUES(
				@CODE_PACK_UNIT
				,@DESCRIPTION_PACK_UNIT
				,@ORDER
				,GETDATE()
				,@LAST_UPDATE_BY
			)
		--
		SET @ID = SCOPE_IDENTITY()
		--
        COMMIT TRAN TransAdd

		SELECT @ID AS ID
    END TRY
    BEGIN CATCH
		ROLLBACK
		DECLARE @ERROR VARCHAR(1000)= ERROR_MESSAGE()
		RAISERROR (@ERROR,16,1)
    END CATCH
END
