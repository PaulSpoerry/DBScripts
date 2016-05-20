SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_AdminGetSQLJobList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_AdminGetSQLJobList]
GO

CREATE PROCEDURE usp_AdminGetSQLJobList
	@bShowSteps	CHAR(3) = 'NO'
/******************************************************************************************************************\
	Description :	Used to obtain a list of all SQLAgent jobs created for this database. Since SQLAgent jobs do
					not have to be tied directly to a database this script relies on proper naming conventions.
					***All

	Parameter		Purpose
	---------		--------
	@bShowSteps		Indicates level of detail returned.
					If 'YES' job names and steps are returned.
					If 'NO' only job names are returned.

	Programmer :	Ken Sturgeon
\*******************************************************************************************************************/
AS
BEGIN

DECLARE @dbName SYSNAME
SET @dbName = db_name()

IF EXISTS (
	SELECT	j.name
	FROM	msdb..sysjobs j
	WHERE	j.name like (@dbName + '_%')
	)
	BEGIN
		IF UPPER(@bShowSteps) = 'YES'
			BEGIN
					SELECT		--j.job_id AS 'JobID',
								j.name AS 'JobName',
								js.step_id AS 'StepID',
								js.step_name AS 'StepName'
					FROM		msdb..sysjobs j
					JOIN		msdb..sysjobsteps js
						ON		js.job_id = j.job_id
					WHERE		CHARINDEX('_', j.name) > 0 
						AND		LEFT(j.name, CHARINDEX('_', j.name)) = @dbName + '_'
					ORDER BY 	j.name, js.step_id
				END
			ELSE
				BEGIN
					SELECT		j.name AS 'JobName'
					FROM		msdb..sysjobs j
					WHERE		CHARINDEX('_', j.name) > 0 
						AND		LEFT(j.name, CHARINDEX('_', j.name)) = @dbName + '_'
					ORDER BY 	j.name
				END
	END
--ELSE
--	SELECT '' AS 'JobName'
END