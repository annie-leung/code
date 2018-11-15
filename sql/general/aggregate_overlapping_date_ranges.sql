--==========================================================================================
-- Author:        Annie Leung
-- Description:   Calculates an aggregated time period table based on other time period rows that overlap
-- Last Modified: dd/MM/yyyy - XX - <Change description>
--
-- 
-- ==========================================================================================
IF OBJECT_ID('tempdb..#Links') IS NOT NULL
    DROP TABLE #Links

CREATE TABLE #Links
(
    MortgageId     INT 
   ,StartDate    DATE
   ,EndDate    DATE
)

DECLARE @CalcDate AS DATE = '20180201'

INSERT INTO #Links
VALUES (1,'20180101','20180110')
      ,(1,'20180105','20180115')
      ,(1,'20170105','20180116')
      ,(1,'20180120',@CalcDate)
      ,(1,'20180130',@CalcDate)
      ,(2,'20180101','20180110')
      ,(2,'20180105','20180115')
      ,(2,'20170105','20180116')
      ,(2,'20180120',@CalcDate)
      ,(2,'20180130',@CalcDate)



SELECT  s1.MortgageId
       ,s1.StartDate
       ,MIN(t1.EndDate) AS EndDate 
FROM #Links s1 
INNER JOIN #Links t1 ON s1.StartDate <= t1.EndDate AND t1.MortgageId = s1.MortgageId
AND NOT EXISTS
(
    SELECT 1 
    FROM #Links t2 
    WHERE t1.EndDate >= t2.StartDate 
    AND   t1.EndDate < t2.EndDate
    AND   t1.Mortgageid = t2.MortgageId
) 
WHERE NOT EXISTS
(
    SELECT 1
    FROM   #Links s2 
    WHERE  s1.StartDate > s2.StartDate 
    AND    s1.StartDate <= s2.EndDate
    AND    s1.MortgageId = s2.MortgageId
) 
GROUP BY s1.MortgageId, s1.StartDate 
ORDER BY s1.MortgageId, s1.StartDate 
GO
