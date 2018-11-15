--==========================================================================================
-- Author:        <Author Name>
-- Create date:   <Creation Date>
-- Description:   Creates a Date Dimension table.  Update the @startdate and @enddate
--                variables to change the date range of the dimension table.
-- Last Modified: dd/MM/yyyy - XX - <Change description>
--
-- SELECT * FROM dbo.D_Date
-- ==========================================================================================
--Create Dimension Date Table
CREATE TABLE [dbo].[D_Date]
(
   [D_Date_Key] INT 
  ,[Full_Date] DATE 
  ,[Month_Year] INT 
  ,[Day_Of_Week_Number] INT 
  ,[Day_Of_Week_Name] VARCHAR(10)
  ,[Day_Of_Month_Number] INT 
  ,[Day_Of_Year_Number] INT 
  ,[Week_Of_Year_Number] INT 
  ,[Month_Name] VARCHAR(9) 
  ,[Month_Number] INT 
  ,[Calendar_Quarter] INT 
  ,[Calendar_Year] INT 
  ,[Calendar_Semester] INT 
  ,[Financial_Month] INT 
  ,[Financial_Quarter] INT 
  ,[Financial_Semester] INT 
  ,[Financial_Year] INT 
  ,[Is_Week_Day] BIT 
CONSTRAINT [D_Date_PK] PRIMARY KEY ([D_Date_Key])
)

--------------------------------------
--Populates the date dimension
--------------------------------------
DECLARE @startdate DATE = '2010-01-01' --change start date if required
       ,@enddate   DATE = '2100-12-31' --change end date if required
       
DECLARE @datelist TABLE (FullDate DATE) 

--recursive date query
;WITH dt_cte 
AS 
( 
    SELECT @startdate AS FullDate 
    UNION ALL 
    SELECT DATEADD(DAY,1,FullDate) AS FullDate 
    FROM dt_cte 
    WHERE dt_cte.FullDate < @enddate 
) 
INSERT INTO @datelist
SELECT FullDate FROM dt_cte 
OPTION (MAXRECURSION 0) 

--Populate Date Dimension
INSERT INTO [dbo].[D_Date]

SELECT CONVERT(INT,CONVERT(VARCHAR,dl.FullDate,112)) as DateKey
       ,dl.FullDate
       ,CAST(FORMAT(dl.FullDate,'yyyyMM') AS INT) AS MonthYear
       ,DATEPART(dw,dl.FullDate) as DayOfWeekNumber
       ,DATENAME(weekday,dl.FullDate) as DayOfWeekName
       ,DATEPART(d,dl.FullDate) as DayOfMonthNumber
       ,DATEPART(dy,dl.FullDate) as DayOfYearNumber
       ,DATEPART(wk, dl.FullDate) as WeekOfYearNumber
       ,DATENAME(MONTH,dl.FullDate) as [MonthName]
       ,MONTH(dl.FullDate) as MonthNumber
       ,DATEPART(qq, dl.FullDate) as CalendarQuarter
       ,YEAR(dl.FullDate) as CalendarYear
       ,CASE DATEPART(qq, dl.FullDate) 
          WHEN 1 THEN 1 
          WHEN 2 THEN 1 
          WHEN 3 THEN 2 
          WHEN 4 THEN 2 
        END AS CalendarSemester, 
       ,MONTH(dl.FullDate) + IIF(MONTH(dl.FullDate) >= 7, -6, 6) AS FiscalMonth,
       ,CASE DATEPART(qq, dl.FullDate) 
          WHEN 1 THEN 3 
          WHEN 2 THEN 4 
          WHEN 3 THEN 1 
          WHEN 4 THEN 2 
        END as FiscalQuarter, 
       ,CASE DATEPART(qq, dl.FullDate) 
          WHEN 1 THEN 2 
          WHEN 2 THEN 2 
          WHEN 3 THEN 1 
          WHEN 4 THEN 1 
        END as FiscalSemester,
       ,CASE DATEPART(qq, dl.FullDate) 
          WHEN 1 THEN YEAR(dl.FullDate) 
          WHEN 2 THEN YEAR(dl.FullDate) 
          WHEN 3 THEN YEAR(dl.FullDate) + 1 
          WHEN 4 THEN YEAR(dl.FullDate) + 1 
        END as FiscalYear
       ,IIF(datepart(dw,dl.FullDate) IN (1,7),0,1) AS IsWeekDay 
FROM   @datelist dl 
LEFT JOIN [dbo].[D_Date] dt ON dt.Full_Date = dl.FullDate
WHERE  dt.D_Date_Key IS NULL
ORDER BY DateKey DESC 
