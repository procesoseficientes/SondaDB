-- =============================================
-- Autor:				alberto.ruiz
-- Fecha de Creacion: 	10-02-2016
-- Description:			Actualiza el numero actual de un documento

-- Modificacion 27-06-2016
					-- alberto.ruiz
					-- Se valido que solo se actualizara si es mayor el doc_num

-- Modificacion 05-09-2016
					-- alberto.ruiz
					-- Se comento validacion de que si habia o no actualizado registros porque al usuario le salia como error
/*
-- Ejemplo de Ejecucion:
				DECLARE 
					@DOC_TYPE VARCHAR(50) = 'PAYMENT'
					,@SERIE VARCHAR(100) = 'AAA'
					,@DOC_NUM INT = 1
				--
				SELECT D.DOC_TYPE,D.SERIE,D.CURRENT_DOC FROM [acsa].[SWIFT_DOCUMENT_SEQUENCE] D WHERE DOC_TYPE = @DOC_TYPE AND SERIE = @SERIE
				--
				EXEC [acsa].[SONDA_SP_UPDATE_DOCUMENT_SEQUENCE]
					@DOC_TYPE = 'SONDA_SP_UPDATE_DOCUMENT_SEQUENCE'
					,@SERIE = 'RP-24'
					,@DOC_NUM = '13873'
				--
				SELECT D.DOC_TYPE,D.SERIE,D.CURRENT_DOC FROM [acsa].[SWIFT_DOCUMENT_SEQUENCE] D WHERE DOC_TYPE = @DOC_TYPE AND SERIE = @SERIE
*/
-- =============================================
CREATE PROCEDURE [acsa].[SONDA_SP_UPDATE_DOCUMENT_SEQUENCE]
(	
	@DOC_TYPE VARCHAR(50)
	,@SERIE VARCHAR(100)
	,@DOC_NUM INT
)
AS
BEGIN

--DECLARE @CURRENT_DOC INT = (SELECT CURRENT_DOC FROM acsa.SWIFT_DOCUMENT_SEQUENCE WHERE SERIE = @SERIE AND DOC_TYPE = @DOC_TYPE),
--@RESULT VARCHAR(2000) = ''																													 
						  
-- -------------------------------------------------------------------
-- cambio que valida que la secuencia actual no regrese a una anterior
-- -------------------------------------------------------------------
	--SET NOCOUNT ON;

	--BEGIN TRAN
	--BEGIN TRY

	--IF( @DOC_NUM > @CURRENT_DOC )
	--BEGIN					  
	  
	--	UPDATE [acsa].[SWIFT_DOCUMENT_SEQUENCE]
	--	SET CURRENT_DOC = @DOC_NUM
	--	WHERE DOC_TYPE = @DOC_TYPE
	--		AND SERIE = @SERIE
	--SET @RESULT = 'Actualización completada'
	--END;
	--ELSE
	--BEGIN
	--SET @RESULT = 'El documento nuevo no puede ser menor al documento actual'
	--END;	

	SET NOCOUNT ON;

	BEGIN TRAN
	BEGIN TRY
		UPDATE [acsa].[SWIFT_DOCUMENT_SEQUENCE]
		SET CURRENT_DOC = @DOC_NUM
		WHERE DOC_TYPE = @DOC_TYPE
			AND SERIE = @SERIE
			AND @DOC_NUM>CURRENT_DOC

		/*-- ------------------------------------------------------------------------------------
		-- Valida que se actualizara la secuencia de documentos
		-- ------------------------------------------------------------------------------------
		IF @@ROWCOUNT = 0
		BEGIN
			RAISERROR ('No se actualizo la secuencia de documentos porque no aumento la secuencia',16,1)
		END*/

		-- ------------------------------------------------------------------------------------
		-- Finaliza la tran
		-- ------------------------------------------------------------------------------------
		PRINT 'COMMIT'
		--
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		DECLARE @ERROR VARCHAR(1000) = ERROR_MESSAGE()
		PRINT 'CATCH: ' + @ERROR
		RAISERROR (@ERROR,16,1)
	END CATCH
END
