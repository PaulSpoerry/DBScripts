SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_AdminListAllIndexes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_AdminListAllIndexes]
GO




CREATE PROCEDURE usp_AdminListAllIndexes
AS
/****************************************************************\
	Name:			usp_AdminListAllIndexes

	Description:	This stored procedure will list all of the
					indexes against user tables within a database.
					Script Author: Eddy Djaja, Publix Super Markets, Inc.

	Programmer:		Ken Sturgeon

	Modification History:
	$History: usp_AdminListAllIndexes.sql $
		
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
		User: Pspoerry     Date: 6/06/02    Time: 1:38p
		Updated in $/GroupWeb/Phase3/Database/Stored Procedures
		added drop and recreate statement
		
		*****************  Version 1  *****************
		User: Ksturgeon    Date: 5/20/02    Time: 6:52a
		Created in $/GroupWeb/Phase3/Database/Stored Procedures
		
		*****************  Version 1  *****************
		User: Ksturgeon    Date: 5/20/02    Time: 6:51a
		Created in $/GroupWeb/Phase3/Database/Stored Procedures
 
\*****************************************************************/
    
-- SET UP SOME CONSTANT VALUES FOR OUTPUT QUERY
DECLARE @empty VARCHAR(1) 
SELECT @empty = ''
DECLARE @des1		VARCHAR(35),	-- 35 matches spt_values
		@des2		VARCHAR(35),
		@des4		VARCHAR(35),
		@des32		VARCHAR(35),
		@des64		VARCHAR(35),
		@des2048	VARCHAR(35),
		@des4096	VARCHAR(35),
		@des8388608	VARCHAR(35),
		@des16777216	VARCHAR(35)
SELECT @des1 = name FROM master.dbo.spt_values WHERE type = 'I' AND number = 1
SELECT @des2 = name FROM master.dbo.spt_values WHERE type = 'I' AND number = 2
SELECT @des4 = name FROM master.dbo.spt_values WHERE type = 'I' AND number = 4
SELECT @des32 = name FROM master.dbo.spt_values WHERE type = 'I' AND number = 32
SELECT @des64 = name FROM master.dbo.spt_values WHERE type = 'I' AND number = 64
SELECT @des2048 = name FROM master.dbo.spt_values WHERE type = 'I' AND number = 2048
SELECT @des4096 = name FROM master.dbo.spt_values WHERE type = 'I' AND number = 4096
SELECT @des8388608 = name FROM master.dbo.spt_values WHERE type = 'I' AND number = 8388608
SELECT @des16777216 = name FROM master.dbo.spt_values WHERE type = 'I' AND number = 16777216

SELECT	o.name, 
		i.name,
		'index description' = convert(varchar(210), --bits 16 off, 1, 2, 16777216 on, located on group
				CASE WHEN (i.status & 16)<>0 THEN 'clustered' ELSE 'nonclustered' END 
				+ CASE WHEN (i.status & 1)<>0 THEN ', '+@des1 ELSE @empty END
				+ CASE WHEN (i.status & 2)<>0 THEN ', '+@des2 ELSE @empty END
				+ CASE WHEN (i.status & 4)<>0 THEN ', '+@des4 ELSE @empty END
				+ CASE WHEN (i.status & 64)<>0 THEN ', '+@des64 ELSE 
						CASE WHEN (i.status & 32)<>0 THEN ', '+@des32 ELSE @empty END END
				+ CASE WHEN (i.status & 2048)<>0 THEN ', '+@des2048 ELSE @empty END
				+ CASE WHEN (i.status & 4096)<>0 THEN ', '+@des4096 ELSE @empty END
				+ CASE WHEN (i.status & 8388608)<>0 THEN ', '+@des8388608 ELSE @empty END
				+ CASE WHEN (i.status & 16777216)<>0 THEN ', '+@des16777216 ELSE @empty END),
		'index column 1' = index_col(o.name,indid, 1),
		'index column 2' = index_col(o.name,indid, 2),
		'index column 3' = index_col(o.name,indid, 3)
FROM	sysindexes i, sysobjects o
WHERE	i.id = o.id 
	AND indid > 0 
	AND indid < 255
	AND o.type = 'U'
	--exclude autostatistic index
	AND (i.status & 64) = 0
	AND (i.status & 8388608) = 0
	AND (i.status & 16777216)= 0
ORDER BY o.name


