﻿CREATE PROCEDURE [acsa].[SONDA_SP_GET_MANIFEST_HEADER]
@MANIFEST_HEADER INT,
@pResult VARCHAR(250) OUTPUT
AS
BEGIN TRY

	IF EXISTS(SELECT 1 FROM SWIFT_MANIFEST_HEADER A WHERE A.MANIFEST_HEADER = @MANIFEST_HEADER AND
	STATUS = 'ACCEPTED') BEGIN
			SELECT	@pResult	= 'ERROR, MANIFIESTO YA SE ENCUENTRA EN PROCESO DE ENTREGA';
		RETURN 2
	END

	IF EXISTS(SELECT 1 FROM SWIFT_MANIFEST_HEADER A WHERE A.MANIFEST_HEADER = @MANIFEST_HEADER AND
	STATUS = 'COMPLETED') BEGIN
			SELECT	@pResult	= 'ERROR, MANIFIESTO YA FUE COMPLETAMENTE ENTREGADO';
		RETURN 2
	END
	SELECT DISTINCT
		A.MANIFEST_HEADER
		,A.CODE_MANIFEST_HEADER
		,A.COMMENTS
		,A.CREATED_DATE AS 'FECHA_CREACION'
		,A.LAST_UPDATE_BY AS 'USUARIO_CREADOR'
		,(
			SELECT COUNT(E.CODE_PICKING) FROM [acsa].SWIFT_MANIFEST_DETAIL E WHERE E.CODE_MANIFEST_HEADER = A.MANIFEST_HEADER 
		) AS 'CANTIDAD_PEDIDOS'
		,B.NAME_DRIVER AS 'PILOTO_ASIGNADO'
		,C.PLATE_VEHICLE AS 'VEHICLE'
		,D.NAME_ROUTE AS 'GEO_RUTA'
		,A.STATUS
		,A.ACCEPTED_STAMP

	FROM
		[acsa].SWIFT_MANIFEST_HEADER AS A
	LEFT OUTER JOIN
		[acsa].SWIFT_DRIVERS AS B
	ON A.CODE_DRIVER = B.CODE_DRIVER
	LEFT OUTER JOIN
		[acsa].SWIFT_VEHICLES AS C
	ON A.CODE_VEHICLE = C.CODE_VEHICLE
	LEFT OUTER JOIN
		[acsa].SWIFT_ROUTES AS D
	ON A.CODE_ROUTE = D.CODE_ROUTE
	WHERE A.MANIFEST_HEADER = @MANIFEST_HEADER
	
	IF (@@ROWCOUNT > 0) 
	BEGIN
		SELECT	@pResult	= 'OK';
		RETURN 0
	END
	ELSE
	BEGIN
		SELECT	@pResult	= 'No existe el numero de Manifiesto';
		RETURN 2
	END
END TRY
BEGIN CATCH
	SELECT	@pResult	= ERROR_MESSAGE()
	RETURN -1
END CATCH




