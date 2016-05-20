SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_AdminDropStatistics]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_AdminDropStatistics]
GO





CREATE PROCEDURE usp_AdminDropStatistics
    @dtBeforeDate		DATETIME = NULL
AS

/****************************************************************\
	Name:			usp_AdminDropStatistics

	Description:	This stored procedure will drop any statistics
					created automatically when auto create 
					statistics was set on the database. Unset that
					option to permanently delete them, because they
					may be recreated after this drop statistics
					procedure otherwise.

	Programmer:		Craig Clearman

	Modification History:
	$History: usp_AdminDropStatistics.sql $
		
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

DECLARE	@sTableName				SYSNAME
DECLARE	@sStatisticName			SYSNAME

DECLARE curStatistics CURSOR
FOR
	SELECT		o.name AS table_name,
				i.name AS statistic_name
	FROM		sysobjects o
	INNER JOIN	sysindexes i
		ON		o.id = i.id
	WHERE		i.indid != 0 AND
				i.indid != 255 AND
				o.xtype = 'U' AND
				i.name like '_WA_SYS%'
	ORDER BY	o.name,
				i.name

OPEN	curStatistics

FETCH NEXT FROM curStatistics
INTO	@sTableName, 
		@sStatisticName

WHILE @@FETCH_STATUS = 0
BEGIN
	EXECUTE('DROP STATISTICS ' + @sTableName + '.' + @sStatisticName)

	FETCH NEXT FROM curStatistics
	INTO	@sTableName, 
			@sStatisticName
END

DEALLOCATE curStatistics





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

