-----------------------------------------------------------
--Sample code snippet for Cursors
--
--It is recommended to NOT use cursors if you can achieve the 
--same result by using set-based logic. 
--
--More information: https://docs.microsoft.com/en-us/sql/t-sql/language-elements/declare-cursor-transact-sql?view=sql-server-2017
-----------------------------------------------------------

--Create variables for each column that will go in the cursor
DECLARE @COLUMN1  nvarchar(max)
DECLARE @COLUMN2  nvarchar(max)
DECLARE @COLUMN3  nvarchar(max)
DECLARE @COLUMN4  nvarchar(max)
DECLARE @COLUMN5  nvarchar(max)

--Declare CURSOR
DECLARE Sample_CURSOR CURSOR 
FOR
    --Query to scroll through - each column should have a variable declared above.
    SELECT	COLUMN1
           ,COLUMN2
           ,COLUMN3
           ,COLUMN4
           ,COLUMN5
    FROM	[dbo].SampleTable

--Start scrolling through cursor
OPEN Sample_CURSOR  

 --Assign each variable to each column for the first row
FETCH NEXT FROM Sample_CURSOR INTO @COLUMN1,@COLUMN2,@COLUMN3,@COLUMN4,@COLUMN5

WHILE @@FETCH_STATUS = 0  --while there are still rows to scroll through
BEGIN  

    --==================================
    --Add SQL to process each row of data here
    --==================================

     --Assign the next row
    FETCH NEXT FROM Sample_CURSOR INTO @COLUMN1,@COLUMN2,@COLUMN3,@COLUMN4,@COLUMN5
END

CLOSE Sample_CURSOR;  
DEALLOCATE Sample_CURSOR;

