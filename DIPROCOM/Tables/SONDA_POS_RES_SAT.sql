CREATE TABLE [PACASA].[SONDA_POS_RES_SAT] (
    [ROWPK]                                   INT           IDENTITY (1, 1) NOT NULL,
    [AUTH_ID]                                 VARCHAR (50)  NOT NULL,
    [AUTH_ASSIGNED_DATETIME]                  DATETIME      NULL,
    [AUTH_POST_DATETIME]                      DATETIME      NULL,
    [AUTH_ASSIGNED_BY]                        VARCHAR (100) NULL,
    [AUTH_DOC_FROM]                           INT           NULL,
    [AUTH_DOC_TO]                             INT           NULL,
    [AUTH_SERIE]                              VARCHAR (100) NOT NULL,
    [AUTH_DOC_TYPE]                           VARCHAR (100) NULL,
    [AUTH_ASSIGNED_TO]                        VARCHAR (100) NULL,
    [AUTH_CURRENT_DOC]                        INT           NULL,
    [AUTH_LIMIT_DATETIME]                     DATETIME      NULL,
    [AUTH_STATUS]                             VARCHAR (15)  NULL,
    [AUTH_BRANCH_NAME]                        VARCHAR (50)  NULL,
    [AUTH_BRANCH_ADDRESS]                     VARCHAR (150) NULL,
    [AUTH_TYPE]                               VARCHAR (150) CONSTRAINT [DF_SONDA_POS_RES_SAT_AUTH_TYPE] DEFAULT ('HANDHELD') NULL,
    [BRANCH_ADDRESS2]                         VARCHAR (30)  NULL,
    [BRANCH_ADDRESS3]                         VARCHAR (30)  NULL,
    [BRANCH_ADDRESS4]                         VARCHAR (30)  NULL,
    [FEL_DOCUMENT_TYPE_CLASSIFICATION_ID]     INT           NULL,
    [FEL_DOCUMENT_TYPE]                       VARCHAR (100) NULL,
    [FEL_STABLISHMENT_CODE_CLASSIFICATION_ID] INT           NULL,
    [FEL_STABLISHMENT_CODE]                   INT           NULL,
    CONSTRAINT [PK_SONDA_POS_RES_SAT] PRIMARY KEY CLUSTERED ([AUTH_ID] ASC, [AUTH_SERIE] ASC)
);




GO
-- =============================================
-- Author:		<Elder Lucas>
-- Create date: <2021-06-02>
-- Description:	<Trigger que previene el atraso de los correlativos en la tabla POS_RES_SAT y que devuelve el correlativo actual para mostrar en el error en SONDA_SD>
-- =============================================
CREATE TRIGGER [PACASA].[PREVENT_LOWER_DOCUMENT]
   ON  [SWIFT_EXPRESS_QA].[PACASA].[SONDA_POS_RES_SAT]
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
			INNER JOIN [PACASA].USERS U ON i.AUTH_ASSIGNED_TO = U.SELLER_ROUTE

	set @actual = ' No se puede actualizar el corelativo a un valor menor: ' + CAST((select d.AUTH_CURRENT_DOC from deleted d) AS VARCHAR)


		--RAISERROR (@actual, 16, 1);
        ROLLBACK TRANSACTION;
			
	INSERT INTO [PACASA].[SONDA_SERVER_ERROR_LOG]
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
DISABLE TRIGGER [PACASA].[PREVENT_LOWER_DOCUMENT]
    ON [PACASA].[SONDA_POS_RES_SAT];

