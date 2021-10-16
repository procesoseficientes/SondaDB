﻿CREATE PROCEDURE [DIPROCOM].[SONDA_OPE_Efficiency]
@fechaReporte date
AS
	SELECT UPPER(ssoh.POSTED_BY) AS OPERS
	INTO #OPERS
	FROM DIPROCOM.SONDA_SALES_ORDER_HEADER ssoh
	GROUP BY ssoh.POSTED_BY

	SELECT ssoh1.POSTED_DATETIME, UPPER(ssoh1.POSTED_BY) AS OPERS
	INTO #SALES
		FROM DIPROCOM.SONDA_SALES_ORDER_HEADER ssoh1
		WHERE CONVERT(date,ssoh1.POSTED_DATETIME,103) = CONVERT(date,@fechaReporte,103)
		AND (
		ssoh1.POSTED_BY LIKE 'COB%' OR
		ssoh1.POSTED_BY LIKE 'TEC%' OR
		ssoh1.POSTED_BY LIKE 'JUT%' OR
		ssoh1.POSTED_BY LIKE 'QUE%'
	)

	SELECT o.OPERS,
COALESCE((
	SELECT count(*) 
	FROM #SALES s
	WHERE CONVERT(date,s.POSTED_DATETIME,103) = CONVERT(date,@fechaReporte,103)
	AND s.OPERS = o.OPERS
	AND CONVERT(time,s.POSTED_DATETIME,114) < '12:00'
	GROUP BY s.OPERS
), 0) AS 'Antes 12:00',
COALESCE((
	SELECT count(*) 
	FROM #SALES s
	WHERE CONVERT(date,s.POSTED_DATETIME,103) = CONVERT(date,@fechaReporte,103)
	AND s.OPERS = o.OPERS
	AND CONVERT(time,s.POSTED_DATETIME,114) >= '12:00' AND CONVERT(time,s.POSTED_DATETIME,114) < '15:30'
	GROUP BY s.OPERS
), 0) AS 'Entre 12:00 - 15:30',
/*COALESCE((
	SELECT count(*) 
	FROM #SALES s
	WHERE CONVERT(date,s.POSTED_DATETIME,103) = CONVERT(date,@fechaReporte,103)
	AND s.OPERS = o.OPERS
	AND CONVERT(time,s.POSTED_DATETIME,114) >= '15:00'  AND CONVERT(time,s.POSTED_DATETIME,114) < '16:00'
	GROUP BY s.OPERS
), 0)AS 'Entre 15:00 - 16:00',*/
COALESCE((
	SELECT count(*) 
	FROM #SALES s
	WHERE CONVERT(date,s.POSTED_DATETIME,103) = CONVERT(date,@fechaReporte,103)
	AND s.OPERS = o.OPERS
	AND CONVERT(time,s.POSTED_DATETIME,114) >= '15:30'  AND CONVERT(time,s.POSTED_DATETIME,114) < '17:00'
	GROUP BY s.OPERS
), 0)AS 'Entre 15:30 - 17:00',
COALESCE((
	SELECT count(*) 
	FROM #SALES s
	WHERE CONVERT(date,s.POSTED_DATETIME,103) = CONVERT(date,@fechaReporte,103)
	AND s.OPERS = o.OPERS
	AND CONVERT(time,s.POSTED_DATETIME,114) >= '17:00'
	GROUP BY s.OPERS
), 0)AS 'Despues 17:00'
FROM #OPERS o
WHERE (
	o.OPERS LIKE 'COB%' OR
	o.OPERS LIKE 'TEC%' OR
	o.OPERS LIKE 'JUT%' OR
	o.OPERS LIKE 'QUE%'
)

DROP TABLE #OPERS, #SALES