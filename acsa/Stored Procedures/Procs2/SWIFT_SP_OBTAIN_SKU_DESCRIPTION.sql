﻿CREATE PROCEDURE [acsa].[SWIFT_SP_OBTAIN_SKU_DESCRIPTION]

@CODE_SKU VARCHAR(50)

AS

SELECT DESCRIPTION_SKU FROM SWIFT_VIEW_ALL_SKU WHERE CODE_SKU=@CODE_SKU




