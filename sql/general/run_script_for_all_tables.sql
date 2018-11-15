--==========================================================================================
-- Description:   Run the same script for all tables
-- Last Modified: dd/MM/yyyy - XX - <Change description>
-- ==========================================================================================-- Disable constraints for all tables:EXEC sp_msforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT all'
-- Re-enable constraints for all tables:EXEC sp_msforeachtable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all'
