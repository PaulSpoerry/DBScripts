SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_AdminShrinkLogFile]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_AdminShrinkLogFile]
GO

CREATE PROCEDURE usp_AdminShrinkLogFile
AS
/****************************************************************\
	Name:			usp_AdminShrinkLogFile

	Description:	This stored procedure will grab the logical file
					name for the Transaction Log, determine it's 
					original size, attempt to wrap the transaction
					log to order the active section at the top. It
					will then attempt to shrink the transaction 
					log and report the new file size out.

	Programmer:		Paul Spoerry

	Modification History:
	$History: usp_AdminShrinkLogFile.sql $
		
		*****************  Version 1  *****************
		User: Pspoerry     Date: 3/15/11    Time: 1:06p
		Created in $/GroupWeb/GroupWeb 3.1.1/Database/Stored Procedures
		
		*****************  Version 1  *****************
		User: Pspoerry     Date: 4/06/10    Time: 9:12a
		Created in $/GroupWeb/GroupWeb 3.1.0/Database/Stored Procedures
		
		*****************  Version 1  *****************
		User: Pspoerry     Date: 11/29/07   Time: 11:53a
		Created in $/GroupWeb/GroupWeb 3.1.0/Database/Stored Procedures
		
		*****************  Version 1  *****************
		User: Ksturgeon    Date: 10/25/07   Time: 2:55p
		Created in $/GroupWeb/GroupWeb 3.0.2/Database/Stored Procedures
		
		*****************  Version 1  *****************
		User: Ksturgeon    Date: 1/16/07    Time: 1:53p
		Created in $/GroupWeb/GroupWeb 3.0.0/GroupWeb 3.0.1/Database/Stored Procedures
		
		*****************  Version 1  *****************
		User: Pspoerry     Date: 11/23/05   Time: 12:11p
		Created in $/GroupWeb/GroupWeb 3.0.0/Database/Stored Procedures
		
		*****************  Version 1  *****************
		User: Ksturgeon    Date: 9/08/05    Time: 1:19p
		Created in $/GroupWeb/GW300.root/Database/Stored Procedures
		
		*****************  Version 1  *****************
		User: Ksturgeon    Date: 10/28/02   Time: 1:04p
		Created in $/GroupWeb/GroupWeb 2.0 Development/Database/Stored Procedures
		
		*****************  Version 2  *****************
		User: Pspoerry     Date: 9/23/02    Time: 9:57a
		Updated in $/GroupWeb/Phase3/Database/Stored Procedures
		modified to drop dummytrans table if it already exists(in case the load
		terminated prior to the drop table statement)
		
		*****************  Version 1  *****************
		User: Pspoerry     Date: 9/06/02    Time: 9:48a
		Created in $/GroupWeb/Phase3/Database/Stored Procedures
		This stored procedure will grab the logical file name for the
		Transaction Log, determine it's original size, attempt to wrap the
		transaction log to order the active section at the top. It will then
		attempt to shrink the transaction 
		log and report the new file size out.
		

 
\*****************************************************************/
    
SET NOCOUNT ON 
DECLARE @LogicalFileName sysname, @MaxMinutes INT, @NewSize INT 

Select @LogicalFileName = (SELECT RTrim(name) From sysfiles Where fileid = 2), @MaxMinutes = 10, @NewSize = 10
-- @LogicalFileName = logical file name that you want to shrink.
-- @MaxMinutes = Limit on time allowed to wrap log. 
-- @NewSize = in MB 

-- Setup / initialize 
DECLARE @OriginalSize int 
Select @OriginalSize = size -- in 8K pages 
From sysfiles 
Where name = @LogicalFileName 

Select 'Original Size of ' + db_name() + ' LOG is ' + CONVERT(VARCHAR(30),@OriginalSize) + ' 8K pages or ' + CONVERT(VARCHAR(30),(@OriginalSize*8/1024)) + 'MB' 
From sysfiles 
Where name = @LogicalFileName 

-- Check to see if Dummy Transaction table exists, if it does drop it and recreate it
If EXISTS (Select * from dbo.sysobjects Where id = object_id(N'[dbo].[DummyTrans]') and OBJECTPROPERTY(id, N'IsTable') = 1)
Begin
	Drop Table DummyTrans
End

Create Table DummyTrans (DummyColumn char (8000) not null) 

-- Wrap log and truncate it. 
DECLARE @Counter INT, @StartTime DATETIME, @TruncLog VARCHAR(255) 
Select @StartTime = GETDATE(), @TruncLog = 'BACKUP LOG ['+ db_name() + '] WITH TRUNCATE_ONLY' 

-- Try an initial shrink. 
DBCC SHRINKFILE (@LogicalFileName, @NewSize) 
EXEC (@TruncLog) 

-- Wrap the log if necessary. 
While @MaxMinutes > DATEDIFF (mi, @StartTime, GETDATE()) -- time has not expired 
AND @OriginalSize = (SELECT size FROM sysfiles WHERE name = @LogicalFileName) -- the log has not shrunk 
AND (@OriginalSize * 8 /1024) > @NewSize -- The value passed in for new size is smaller than the current size. 
Begin -- Outer loop. 

	Select @Counter = 0 
	While ((@Counter < @OriginalSize / 16) AND (@Counter < 50000)) 
	Begin -- update 
		Insert DummyTrans VALUES ('Fill Log') -- Because it is a char field it inserts 8000 bytes. 
		Delete DummyTrans 
		Select @Counter = @Counter + 1 
	End -- update 
	EXEC (@TruncLog) -- See if a trunc of the log shrinks it. 

END -- outer loop 

Select 'Final Size of ' + db_name() + ' LOG is ' + CONVERT(VARCHAR(30),size) + ' 8K pages or ' + CONVERT(VARCHAR(30),(size*8/1024)) + 'MB' 
From sysfiles 
Where name = @LogicalFileName 

If EXISTS (Select * from dbo.sysobjects Where id = object_id(N'[dbo].[DummyTrans]') and OBJECTPROPERTY(id, N'IsTable') = 1)
Begin
	Drop Table DummyTrans
End

PRINT '*** Transaction log shrink complete ***' 
SET NOCOUNT OFF 
