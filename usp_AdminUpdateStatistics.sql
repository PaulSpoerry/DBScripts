SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_AdminUpdateStatistics]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_AdminUpdateStatistics]
GO


CREATE PROCEDURE usp_AdminUpdateStatistics
	@sCreateStats	VARCHAR(3) = 'NO',
	@sShowStats		VARCHAR(30) = 'NO',
	@iSamplePercent	INT = 50
/****************************************************************\
	Name:			usp_AdminUpdateStatistics

	Description:	This stored procedure will update statistics
					on all user tables.

	Parameter		Purpose
	---------		--------
	@sCreateStats	Indicates if sp_createstats should be executed.
					Doing so ensures than all columns in user tables
					have statistical info.
	@sShowStats		Indicates if sp_statistics should be executed
					to display resulting statistics.
	@iSamplePercent	What % of data should be sampled when determining
					if statistics should be updated.
\*****************************************************************/
AS
BEGIN

	SET NOCOUNT ON
	
	DECLARE @sDBName	SYSNAME
	DECLARE	@sTableName	SYSNAME
	
	IF UPPER(@sCreateStats) = 'YES'
		BEGIN
			SET @sDBName = db_name()
			EXECUTE sp_dboption @sDBName, 'AUTO_CREATE_STATISTICS', 'FALSE'
	
			--Drop the web claim template table as it chokes sp_createstats
			IF EXISTS (SELECT * FROM sysobjects WHERE name = 'ExportWebClaimEdiDataTemplate' and xtype = 'U')
				BEGIN
					DROP TABLE ExportWebClaimEdiDataTemplate
					PRINT 'ExportWebClaimEdiDataTemplate DROPPED'
				END
	
			--Assure that all column indexes exist
			EXECUTE sp_createstats
		END
	
	--Update stats on all indexes
	DECLARE curIndexes CURSOR
		FOR
			SELECT	o.name AS table_name
			FROM	sysobjects o
			WHERE	o.xtype = 'U'
			ORDER BY o.name
	
	OPEN	curIndexes
	
	FETCH NEXT FROM curIndexes
	INTO	@sTableName
	
	WHILE @@FETCH_STATUS = 0
		BEGIN
			EXECUTE('UPDATE STATISTICS ' + @sTableName + ' WITH SAMPLE ' + @iSamplePercent + ' PERCENT')
			PRINT 'Table ' + @sTableName + ': Statistics updated.'
	
			IF UPPER(@sShowStats) = 'YES'
				EXECUTE sp_statistics @sTableName
		
			FETCH NEXT FROM curIndexes
			INTO	@sTableName
		END
	
	CLOSE curIndexes
	DEALLOCATE curIndexes
	
	IF UPPER(@sCreateStats) = 'YES'
		BEGIN
			EXECUTE sp_dboption @sDBName, 'AUTO_CREATE_STATISTICS', 'TRUE'
	
			IF NOT EXISTS (SELECT * FROM sysobjects WHERE name = 'ExportWebClaimEdiDataTemplate' and xtype = 'U')
				BEGIN
					EXECUTE usp_UtilCreateExportWebClaimEdiDataTemplate
					PRINT 'ExportWebClaimEdiDataTemplate CREATED'
				END
		END
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

