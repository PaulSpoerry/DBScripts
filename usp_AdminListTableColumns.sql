SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_AdminListTableColumns]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_AdminListTableColumns]
GO





CREATE PROCEDURE usp_AdminListTableColumns
	@sTableName 	SYSNAME
AS

/****************************************************************\
	Name:			usp_AdminListTableColumns

	Description:	This stored procedure will list all of the columns
					defined for a table.

	Programmer:		Craig Clearman

	Modification History:
	$History: usp_AdminListTableColumns.sql $
		
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
		User: Ksturgeon    Date: 2/20/02    Time: 2:59p
		Created in $/GroupWeb/Phase3/Database/Stored Procedures
		Scripted from Database to eliminate inconsistency in naming
		conventions. Names in VSS now coincide with names of procs in database.
 
\*****************************************************************/

SET NOCOUNT ON

SELECT		column_name, character_maximum_length
FROM		information_schema.columns col
WHERE		col.table_name = @sTableName
ORDER BY	col.ordinal_position





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

