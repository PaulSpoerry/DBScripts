SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_UtilForeignKeyManager]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_UtilForeignKeyManager]
GO

CREATE PROCEDURE usp_UtilForeignKeyManager
	@ParentTable	VARCHAR(50),
	@Action			CHAR(4) = NULL
/******************************************************************************************************************\
	Description :	Used to drop and recreate foreign keys that reference the table that's passed in @ParentTable.
					Before dropping foreign keys, key info is saved to a "temp" table (FKInfoTable). Foreign keys
					are rebuilt based on the data that was saved prior to dropping the key(s). Special precautions
					must be taken to assure that the key info table is not dropped or cleared before the keys are
					rebuilt.

	Parameter		Purpose
	---------		--------
	@ParentTable	The table to which all referencing foreign keys are to be dropped from.
	@Action			Acceptable values = ADD, DROP

	Programmer :	Ken Sturgeon
\*******************************************************************************************************************/
AS
BEGIN
--Declare variables that will be used in cursor processing
DECLARE @pkTable		SYSNAME
DECLARE @pkColumn		SYSNAME
DECLARE @fkTable		SYSNAME
DECLARE @fkColumn		SYSNAME
DECLARE @fkName			SYSNAME
DECLARE @KeySeq			SYSNAME
DECLARE @prevPKTable	VARCHAR(50)
DECLARE @prevFKTable	VARCHAR(50)
DECLARE @sSQL			NVARCHAR(4000)
DECLARE @FKInfoTable	VARCHAR(128)

SET @FKInfoTable = 'FKInfo_' + @ParentTable

IF @Action IS NOT NULL AND (UPPER(@Action) = 'ADD' OR UPPER(@Action) = 'DROP')
BEGIN
	--When dropping foreign keys a table is built to house the foreign key info
	IF	UPPER(@Action) = 'DROP'
		BEGIN
			--If a key table already exists, there's a good chance that keys were previously dropped and never rebuilt
			--Take no action if a key table exists... force manual intervention
			IF	EXISTS (SELECT 1 FROM sysobjects WHERE name = @FKInfoTable AND xtype = 'U')
				BEGIN
					PRINT '|------------------------------|'
					PRINT '	Foreign Key Manager'
					PRINT ''
					PRINT '	' + @FKInfoTable + ' already exists'
					PRINT '	Cannot drop foreign keys'
					PRINT '|------------------------------|'
				END
			ELSE	--Build the foreign key table
				BEGIN
					--Fetch the data for all foreign keys that reference the table.
					SET @sSQL = 'CREATE TABLE ' + @FKInfoTable + '(
							PKTABLE_QUALIFIER 	SYSNAME COLLATE	database_default NULL,
							PKTABLE_OWNER		SYSNAME COLLATE database_default NULL,
							PKTABLE_NAME		SYSNAME COLLATE database_default NOT NULL,
							PKCOLUMN_NAME		SYSNAME COLLATE database_default NOT NULL,
							FKTABLE_QUALIFIER	SYSNAME COLLATE database_default NULL,
							FKTABLE_OWNER		SYSNAME COLLATE database_default NULL,
							FKTABLE_NAME		SYSNAME COLLATE database_default NOT NULL,
							FKCOLUMN_NAME		SYSNAME COLLATE database_default NOT NULL,
							KEY_SEQ				SMALLINT NOT NULL,
							UPDATE_RULE			SMALLINT NULL,
							DELETE_RULE			SMALLINT NULL,
							FK_NAME				SYSNAME COLLATE database_default NULL,
							PK_NAME				SYSNAME COLLATE database_default NULL,
							DEFERRABILITY		SMALLINT null
							)'
					EXECUTE sp_executesql @sSQL
					
					SET @sSQL = 'INSERT INTO ' + @FKInfoTable
								+ ' EXEC sp_GroupWebfkeys ' + @ParentTable
					EXECUTE sp_executesql @sSQL


					--Now that the key data is saved it is safe to drop the constraints
					--Declare a cursor that will house all of the referencing tables
					SET @sSQL = 'DECLARE curFKeys SCROLL CURSOR FOR
								SELECT	DISTINCT FKTABLE_NAME, FK_NAME
								FROM	' + @FKInfoTable
					EXECUTE sp_executesql @sSQL

					--Open the cursor
					OPEN curFKeys
					
					--Initialize the cursors
					FETCH	curFKeys
					INTO	@fkTable, @fkName
					
					SET @sSQL = ''
					
					WHILE @@FETCH_STATUS = 0
						BEGIN
							WHILE @@FETCH_STATUS = 0
								BEGIN
									SET @sSQL = @sSQL + ' AND EXISTS (SELECT 1 FROM ' + @FKInfoTable  + ' WHERE FKTABLE_NAME = ''' + @fkTable + ''' AND FK_NAME = ''' + @fkName + ''')'
									SET @sSQL = @sSQL + CHAR(10) + CHAR(9)
									FETCH	NEXT FROM curFKeys
									INTO	@fkTable, @fkName
								END
							SET @sSQL = 'IF' + SUBSTRING(@sSQL, 5, LEN(@sSQL) - 5) + CHAR(10) + CHAR(9) + 'BEGIN'
						
							FETCH	FIRST FROM curFKeys
							INTO	@fkTable, @fkName
						
							WHILE @@FETCH_STATUS = 0
								BEGIN
									SET @sSQL = @sSQL + CHAR(10) + CHAR(9) + CHAR(9)
									SET @sSQL = @sSQL + 'ALTER TABLE ' + @fkTable
									SET @sSQL = @sSQL + CHAR(10) + CHAR(9) + CHAR(9) + CHAR(9)
									SET @sSQL = @sSQL + 'DROP CONSTRAINT ' + @fkName
									FETCH	NEXT FROM curFKeys
									INTO	@fkTable, @fkName
									SET @sSQL = @sSQL + CHAR(10)
								END
						
							SET @sSQL = @sSQL + CHAR(10) + CHAR(9) + 'END'
							--print @sSQL
							EXECUTE sp_executesql @sSQL
						END
					
					CLOSE curFKeys
					DEALLOCATE curFKeys
			END
		END
	IF	UPPER(@Action) = 'ADD'
		--Once the foreign keys have been rebuilt, the key info table can be dropped.
		BEGIN
			SET @prevPKTable = ''
			SET @prevFKTable = ''
			SET @sSQL = ''

			--Make sure the FKInfo table exists
			IF NOT EXISTS (SELECT 1 FROM sysobjects WHERE name = @FKInfoTable AND xtype = 'U')
				RETURN

			--Declare a cursor that will house all foreign key info
			SET @sSQL = 'DECLARE curFKeys SCROLL CURSOR FOR
						SELECT	PKTABLE_NAME, PKCOLUMN_NAME,
								FKTABLE_NAME, FKCOLUMN_NAME,
								FK_NAME, KEY_SEQ
						FROM	' + @FKInfoTable
			EXECUTE sp_executesql @sSQL

			OPEN curFKeys

			FETCH	FIRST FROM curFKeys
			INTO	@pkTable, @pkColumn, @fkTable, @fkColumn, @fkName, @KeySeq

			WHILE @@FETCH_STATUS = 0
				BEGIN
					IF	(@prevFKTable <> @fkTable) AND LEN(@prevFKTable) > 0
						BEGIN
							SET @sSQL = @sSQL + ')' + CHAR(10)+ CHAR(9) + 'REFERENCES ' + @prevPKTable + ''
							--print @sSQL
							EXECUTE sp_executesql @sSQL
						END
					IF	(@prevFKTable <> @fkTable) AND @KeySeq = 1
						BEGIN
							SET @sSQL = 'IF NOT EXISTS (SELECT 1 FROM sysobjects WHERE name = ''' + @fkName + ''' AND xtype = ''F'')'
							SET @sSQL = @sSQL + CHAR(10) + CHAR(9) + 'ALTER TABLE ' + @fkTable
							SET @sSQL = @sSQL + CHAR(10) + CHAR(9) + 'ADD CONSTRAINT ' + @fkName
							SET @sSQL = @sSQL + CHAR(10) + CHAR(9) + 'FOREIGN KEY (' + @fkColumn
						END
					IF	@KeySeq > 1
						BEGIN
								SET @sSQL = @sSQL + ', ' + @fkColumn
						END

					SET @prevPKTable = @pkTable
					SET @prevFKTable = @fkTable

					FETCH	NEXT FROM curFKeys
					INTO	@pkTable, @pkColumn, @fkTable, @fkColumn, @fkName, @KeySeq
				END
			IF	LEN(@sSQL) > 0
			BEGIN
				SET @sSQL = @sSQL + ')' + CHAR(10)+ CHAR(9) + 'REFERENCES ' + @prevPKTable + ''
			END
			--print @sSQL
			EXECUTE sp_executesql @sSQL
			CLOSE curFKeys
			DEALLOCATE curFKeys

			--Before dropping the key table, make sure the keys have been recreated successfully
			--Declare a cursor that will house all of the referencing tables
			SET @sSQL = 'DECLARE curFKeys SCROLL CURSOR FOR
						SELECT	DISTINCT FKTABLE_NAME, FK_NAME
						FROM	' + @FKInfoTable
			EXECUTE sp_executesql @sSQL
					
			--Open the cursor
			OPEN curFKeys
				
			--Initialize the cursors
			FETCH	curFKeys
			INTO	@fkTable, @fkName
					
			SET @sSQL = ''
					
			WHILE @@FETCH_STATUS = 0
				BEGIN
					SET @sSQL = 'IF EXISTS (SELECT 1 FROM sysobjects WHERE name = ''' + @fkName + ''' AND xtype = ''F'')'
					SET @sSQL = @sSQL + CHAR(10) + CHAR(9)
					SET @sSQL = @sSQL + 'DELETE FROM ' + @FKInfoTable + ' WHERE FKTABLE_NAME = ''' + @fkTable + ''''
					--print @sSQL
					EXECUTE sp_executesql @sSQL
					SET @sSQL = ''
					FETCH	NEXT FROM curFKeys
					INTO	@fkTable, @fkName			
				END
			CLOSE curFKeys
			DEALLOCATE curFKeys

			SET @sSQL = 'IF (SELECT COUNT(*) FROM ' + @FKInfoTable + ') = 0
							DROP TABLE ' + @FKInfoTable
			EXECUTE sp_executesql @sSQL
		END
END
ELSE
	BEGIN
		PRINT '|------------------------------|'
		PRINT '	Foreign Key Manager'
		PRINT ''
		PRINT '	Available Parameters: @Action'
		PRINT '	Acceptable Values = ADD, DROP'
		PRINT '|------------------------------|'
	END

END