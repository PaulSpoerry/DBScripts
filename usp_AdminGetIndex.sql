SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_AdminGetIndex]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_AdminGetIndex]
GO



CREATE PROCEDURE usp_AdminGetIndex
    @iTableID		INT,
	@iIndexID		INT = NULL
AS

/****************************************************************\
	Name:			usp_AdminGetIndex

	Description:	This stored procedure will return the index name
					for an index that has been reporting problems
					through DBCC

	Programmer:		Craig Clearman

	Modification History:
	$History: usp_AdminGetIndex.sql $
		
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

SELECT		name, indid
FROM		sysindexes
WHERE		id = @iTableID AND
			(indid = @iIndexID OR @iIndexID IS NULL)
ORDER BY	indid



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

