-- =============================================
-- Author:		<Elder Lucas>
-- Create date: <2021-06-02>
-- Description:	<Trigger que previene el atraso de los correlativos en la tabla POS_RES_SAT y que devuelve el correlativo actual para mostrar en el error en SONDA_SD>
-- =============================================
CREATE TRIGGER [acsa].[PREVENT_LOWER_DOCUMENT]
   ON  [SWIFT_EXPRESS_QA].[acsa].[SONDA_POS_RES_SAT]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    IF EXISTS 
	(
		SELECT 1 FROM inserted i
		JOIN deleted d on i.AUTH_SERIE = d.AUTH_SERIE
		WHERE i.AUTH_CURRENT_DOC < d.AUTH_CURRENT_DOC 
	)
	BEGIN
	declare @actual VARCHAR(100) = '',
			@LOGIN_ID VARCHAR(50) = '',
			@CODE_ROUTE VARCHAR(50) = '',
			@SOURCE_ERROR VARCHAR(50) = 'SendResolution_request | SendResolution',
			@FECHA DATETIME = GETDATE(),
			@DOC_SERIE VARCHAR(100) = '',
			@DOC_NUM INT = 0,
			@ERROR_MESSAGE VARCHAR(MAX) = '';

			SELECT @ERROR_MESSAGE = ('Fin de ruta forzado, se trató de actualizar a un documento inferior, actual: ' + CAST(d.AUTH_CURRENT_DOC AS VARCHAR) + ' insertando: ' + CAST(i.AUTH_CURRENT_DOC AS VARCHAR)),
				   @LOGIN_ID = U.LOGIN,
				   @CODE_ROUTE = U.SELLER_ROUTE,
				   @DOC_SERIE = i.AUTH_SERIE,
				   @DOC_NUM = i.AUTH_CURRENT_DOC
			FROM inserted i 
			JOIN deleted d on i.AUTH_SERIE = d.AUTH_SERIE
			INNER JOIN [acsa].USERS U ON i.AUTH_ASSIGNED_TO = U.SELLER_ROUTE

	set @actual = ' No se puede actualizar el corelativo a un valor menor: ' + CAST((select d.AUTH_CURRENT_DOC from deleted d) AS VARCHAR)


		--RAISERROR (@actual, 16, 1);
        ROLLBACK TRANSACTION;
			
	INSERT INTO [acsa].[SONDA_SERVER_ERROR_LOG]
           ([LOG_DATETIME]
           ,[CODE_ROUTE]
           ,[LOGIN]
           ,[SOURCE_ERROR]
           ,[DOC_RESOLUTION]
           ,[DOC_SERIE]
           ,[DOC_NUM]
           ,[MESSAGE_ERROR]
           ,[SEVERITY_CODE]
           ,[TYPE])
     VALUES(
           @FECHA
           ,@CODE_ROUTE
           ,@LOGIN_ID
           ,@SOURCE_ERROR
           ,'Sin Resolucion'
           ,@DOC_SERIE
           ,@DOC_NUM
           ,@ERROR_MESSAGE
           ,-200
           ,'INFO'
		   )

        RETURN;
	END

END
GO
DISABLE TRIGGER [acsa].[PREVENT_LOWER_DOCUMENT]
    ON [SWIFT_EXPRESS_QA].[acsa].[SONDA_POS_RES_SAT];

