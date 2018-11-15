--==========================================================================================
-- Author:      Annie Leung
-- Create date: 2 November 2018
-- Description: Use the following script to search for view/stored proc definitions for a specified text string
-- Last Modified: dd/MM/yyyy - XX - <Change description>
--
-- Run Instructions: Change the text to search for with m.definition in where clause
--  o.type_desc include: 'SQL_STORED_PROCEDURE'
--                       'VIEW'
--                       'SQL_TABLE_VALUED_FUNCTION'
--                       'SQL_SCALAR_FUNCTION'
--                       'SQL_INLINE_TABLE_VALUED_FUNCTION'
-- ==========================================================================================

SELECT DISTINCT
       o.name AS Object_Name,
       o.type_desc,
       m.definition
FROM   sys.sql_modules m
INNER JOIN sys.objects o ON m.object_id = o.object_id
WHERE m.definition Like '%[ABD]%'
AND   o.type_desc = 'SQL_STORED_PROCEDURE'
