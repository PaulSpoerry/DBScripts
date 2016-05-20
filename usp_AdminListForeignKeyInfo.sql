SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_AdminListForeignKeyInfo]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_AdminListForeignKeyInfo]
GO



CREATE PROCEDURE usp_AdminListForeignKeyInfo
	@Verbose CHAR(3) = 'YES'	
/******************************************************************************\

  Description : Gets listing of all foreign key info resident in database.

  Parameter		Purpose
  @Verbose		Determines if detailed or concise foreign key info is returned.
				Acceptable values = 'YES', 'NO'

--------------------------------------------------------------------------------

  Author : Ken Sturgeon			Date : 02 June 2004

\*******************************************************************************/
AS
BEGIN

DECLARE @ParentTable VARCHAR(64)

CREATE TABLE FKeys (
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
	)

DECLARE curTables SCROLL CURSOR FOR
	SELECT	DISTINCT name
	FROM	sysobjects
	WHERE	xtype = 'U'
	ORDER BY name
					
--Open the cursor
OPEN curTables
				
--Initialize the cursors
FETCH	curTables
INTO	@ParentTable

WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO FKeys
		EXEC sp_GroupWebfkeys @ParentTable
		FETCH NEXT FROM curTables INTO @ParentTable
	END

CLOSE curTables
DEALLOCATE curTables

IF UPPER(@Verbose) = 'YES'
	BEGIN
		SELECT	PKTABLE_NAME,
				PKCOLUMN_NAME,
				FKTABLE_NAME,
				FKCOLUMN_NAME,
				FK_NAME,
				PK_NAME,
				KEY_SEQ
		FROM	FKeys
		ORDER BY PKTABLE_NAME, FK_NAME
	END
ELSE
	BEGIN
		SELECT	DISTINCT FK_NAME
		FROM	FKeys
		ORDER BY FK_NAME
	END

DROP TABLE FKeys

END