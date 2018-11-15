--==========================================================================================
-- Description:   Get's the last modified and created datetime for sql server objects
-- Last Modified: dd/MM/yyyy - XX - <Change description>
-- ==========================================================================================
SELECT [name],
       [type_desc],
       [modify_date],
       [create_date]
FROM   [sys].[objects]
WHERE  ( [modify_date] > '2018-05-01'
          OR [create_date] > '2018-05-01' )
       AND [type_desc] IN ( 'SQL_STORED_PROCEDURE'
                          , 'SQL_SCALAR_FUNCTION'
                          , 'SQL_TRIGGER'
                          , 'USER_TABLE'
                          , 'SQL_TABLE_VALUED_FUNCTION' 
                          )
ORDER  BY [type_desc],
          [name]  