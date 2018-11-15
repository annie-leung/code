--==========================================================================================
-- Description:   Resets any Identity(1,1) fields after a deletion
-- Last Modified: dd/MM/yyyy - XX - <Change description>
-- ==========================================================================================

--Delete from Table
DELETE FROM Table

--Reset table Identity Field to be 0
DBCC CHECKIDENT ('[Table]', RESEED, 0);
GO