
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_UtilFindMissingIndexesDMV]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_UtilFindMissingIndexesDMV]
GO

CREATE PROCEDURE usp_UtilFindMissingIndexesDMV
	@dbName		VARCHAR(2000) = NULL,
	@tableName	VARCHAR(2000) = NULL
AS

/*
	Name:			usp_UtilFindMissingIndexesDMV

	Description:	The sys.dm_db_missing_index_group_stats DMV notes the number of times
					SQL has attempted to use a particular missing index. The 
					sys.dm_db_missing_index_details DMV details the missing index 
					structure; columns required by the query, etc. Only available on 
					SQL Server 2005+
					
	Parms:			@dbName - Databasename or NULL for all databases
					@tableName - Tablename or NULL for all tables

	Programmer:		Paul Spoerry
	
*/

SET NOCOUNT ON

	
IF UPPER(@dbName) = 'HELP'
	BEGIN
	PRINT '---------------------------------------------------------------------'
	PRINT 'Description:	Information returned by sys.dm_db_missing_index_details is updated when a query is optimized by the query optimizer.'
	PRINT 'This information not persisted. DMVs store data since the SQL Server was last restarted, so if it has been a while since your server'
	PRINT 'was rebooted, this data may be out of date. This script identifies which columns are used in equality and inequality SQL statements.'
	PRINT 'Additionally, it reports which other columns should be used as included columns in a missing index. Included columns allow you to '
	PRINT 'satisfy more covered queries without obtaining the data from the underlying page, thus using fewer I/O operations and improving '
	PRINT 'performance. Information is ordered by estimated system impact.'
	PRINT 'Only available on SQL Server 2005+.'
	
	PRINT ''
						
	PRINT 'Parms: @dbName - NULL for current database, ALL for all databases, HELP for info'
	PRINT '       @tableName - Tablename or NULL for all tables'
	PRINT '---------------------------------------------------------------------'
	END
ELSE
BEGIN

    IF (UPPER(@dbName) = 'ALL')
	    SET @dbName = NULL
    ELSE
	    SET @dbName = DB_NAME()

    SELECT db_name(ddmid.database_id) dbName
        , t.name AS 'AffectedTable'
        , ddmigs.user_seeks AS 'UserSeeks'
        , ddmigs.user_scans AS 'UserScans'
        , CAST((ddmigs.user_seeks + ddmigs.user_scans) * ddmigs.avg_user_impact AS INT) AS 'EstImpact'
        --, ROUND(avg_total_user_cost * avg_user_impact * (user_seeks + user_scans),0) as 'TotalCost'
        , ddmigs.last_user_seek AS 'LastUserSeek'
        , 'Create NonClustered Index IX_' + t.name + '_missing_' 
            + CAST(ddmid.index_handle AS VARCHAR(10))
            + ' On ' + ddmid.STATEMENT 
            + ' (' + IsNull(ddmid.equality_columns,'') 
            + CASE WHEN ddmid.equality_columns IS Not Null 
                And ddmid.inequality_columns IS Not Null THEN ',' 
                    ELSE '' END 
            + IsNull(ddmid.inequality_columns, '')
            + ')' 
            + IsNull(' Include (' + ddmid.included_columns + ');', ';'
            ) AS 'SQLStatement'
            , ddmid.equality_columns AS 'EqualityColumns'
	        , ddmid.inequality_columns AS 'InequalityColumns'
	        , ddmid.included_columns AS 'IncludedColumns'
    FROM sys.dm_db_missing_index_groups AS ddmig
    INNER Join sys.dm_db_missing_index_group_stats AS ddmigs
        ON ddmigs.group_handle = ddmig.index_group_handle
    INNER Join sys.dm_db_missing_index_details AS ddmid 
        ON ddmig.index_handle = ddmid.index_handle
    INNER Join sys.tables AS t
        ON ddmid.OBJECT_ID = t.OBJECT_ID
    WHERE ((@dbName IS NULL) OR (db_name(ddmid.database_id) = @dbName))
        AND ((@tableName IS NULL) OR (object_name(ddmid.object_id) = @tableName))
        And CAST((ddmigs.user_seeks + ddmigs.user_scans) * ddmigs.avg_user_impact AS INT) > 100
    ORDER BY CAST((ddmigs.user_seeks + ddmigs.user_scans) * ddmigs.avg_user_impact AS INT) DESC;
END


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

