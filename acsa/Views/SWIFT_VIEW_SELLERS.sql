﻿CREATE VIEW [acsa].[SWIFT_VIEW_SELLERS]
AS
SELECT CORRELATIVE, [LOGIN], NAME_USER FROM [acsa].USERS WHERE TYPE_USER = 'Vendedor'




