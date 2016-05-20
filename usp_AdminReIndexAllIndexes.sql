SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_AdminReIndexAllIndexes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_AdminReIndexAllIndexes]
GO

CREATE PROCEDURE usp_AdminReIndexAllIndexes
	@sConfirm Char(1) = 'N'
AS

/****************************************************************\
	Name:			usp_AdminReIndexAllIndexes

	Description:	This stored procedure will loop through all
					tables in the database and dynamically rebuilds
					the	indexes. By dynamically rebuilting, indexes
					enforcing either PRIMARY KEY or UNIQUE
					constraints can be rebuilt without having to
					drop and re-create those constraints. This means
					an index can be rebuilt without knowing the
					table's structure or constraints, which could
					occur after a bulk copy of data into the table

	Programmer:		Paul Spoerry

	Modification History:
	$History: usp_AdminReIndexAllIndexes.sql $
		
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
		
		*****************  Version 1  *****************
		User: Pspoerry     Date: 9/04/02    Time: 9:35a
		Created in $/GroupWeb/Phase3/Database/Stored Procedures
		This stored procedure will loop through all tables in the database and
		dynamically rebuilds	the indexes. By dynamically rebuilting, indexes
		enforcing either PRIMARY KEY or UNIQUE constraints can be rebuilt
		without having to drop and re-create those constraints. This means		an
		index can be rebuilt without knowing the table's structure or
		constraints, which could occur after a bulk copy of data into the table
		
 
\*****************************************************************/

SET NOCOUNT ON

Declare @TableName Varchar(255)
Declare TableCursor CURSOR FOR
Select TABLE_NAME From INFORMATION_SCHEMA.TABLES
Where TABLE_TYPE='BASE TABLE'
Declare @Command Varchar(255)
 
OPEN TableCursor
FETCH NEXT FROM TableCursor INTO @TableName
WHILE @@FETCH_STATUS =0
BEGIN

PRINT 'Defragmenting ' + @TableName
DBCC DBREINDEX(@TableName) --this command will rebuild indexes on all tables
FETCH NEXT FROM TableCursor INTO @TableName

END
Close TableCursor
DEALLOCATE TableCursor


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

