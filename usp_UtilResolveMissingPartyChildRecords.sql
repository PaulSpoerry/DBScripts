SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_UtilResolveMissingPartyChildRecords]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_UtilResolveMissingPartyChildRecords]
GO

CREATE PROCEDURE usp_UtilResolveMissingPartyChildRecords
	@AreYouSure	VARCHAR(3) = NULL
/******************************************************************************************************************\
	Description :	Used to create blank records for GroupPartyMiscellaneous, Phone, Address, and PaymentMethod
			tables where a party records exists but a child record does not. Utilized to create "dummy"
			records that are empty so that when updates come across from the iSeries they do not fail 
			because an insert record was never received.

	Parameter		Purpose
	---------		--------
	@AreYouSure		Ensure you wish to run the procedure

	Programmer :	Paul Spoerry
\*******************************************************************************************************************/
AS
BEGIN

Declare @Id int
Declare @OriginalKey char(25)
Declare @TypeCode varchar(3)

IF UPPER(@AreYouSure) = 'YES'
	Begin
	-- Group Party Misc 
		Declare GroupPartyMiscellaneous Cursor For
		Select p.Party_Id, p.Original_Key, (select c.Code_Id as TypeCode
							from Code c
							Join Party p2
								on c.code = p2.Type_Code
							Where c.RefType_Id = 106
								AND p2.Party_Id = p.Party_id)
		From Party p
		Left Outer Join GroupPartyMiscellaneous gpm
			on p.Party_Id = gpm.PartyId
		Where p.Type_Code = 'P'
			AND gpm.PartyID IS NULL
		
		Open GroupPartyMiscellaneous
		
		Fetch GroupPartyMiscellaneous Into @Id, @OriginalKey, @TypeCode
		While @@Fetch_Status = 0
		Begin	
	
			Insert Into GroupPartyMiscellaneous (PartyId, SourceSystemId, OriginalKey, GroupPartyTypeCode)
			Values (@Id,1, @OriginalKey, @TypeCode)
			
			
			Fetch GroupPartyMiscellaneous Into @Id, @OriginalKey, @TypeCode
		End
		
		Close GroupPartyMiscellaneous
		Deallocate GroupPartyMiscellaneous
	
	-- Address
	
		Declare Address Cursor For
		Select p.Party_Id, p.Original_Key, (select c.Code_Id as TypeCode
							from Code c
							Join Party p2
								on c.code = p2.Type_Code
							Where c.RefType_Id = 106
								AND p2.Party_Id = p.Party_id)
		From Party p
		Left Outer Join Address a
			on p.Party_Id = a.Party_Id
		Where p.Type_Code = 'P'
			AND a.Party_ID IS NULL
		
		Open Address
		
		Fetch Address Into @Id, @OriginalKey, @TypeCode
		While @@Fetch_Status = 0
		Begin	
	
			Insert Into Address (Party_Id, SOURCE_SYSTEM_ID, ORIGINAL_KEY, TYPE_CODE)
			Values (@Id,1, @OriginalKey, @TypeCode)
			
			
			Fetch Address Into @Id, @OriginalKey, @TypeCode
		End
		
		Close Address
		Deallocate Address
	
	-- Phone
		Declare Phone Cursor For
		Select p.Party_Id, p.Original_Key, (select c.Code_Id as TypeCode
							from Code c
							Join Party p2
								on c.code = p2.Type_Code
							Where c.RefType_Id = 106
								AND p2.Party_Id = p.Party_id)
		From Party p
		Left Outer Join Phone ph
			on p.Party_Id = ph.Party_Id
		Where p.Type_Code = 'P'
			AND ph.Party_ID IS NULL
		
		Open Phone
		
		Fetch Phone Into @Id, @OriginalKey, @TypeCode
		While @@Fetch_Status = 0
		Begin	
	
			Insert Into Phone (Party_Id, SOURCE_SYSTEM_ID, ORIGINAL_KEY, TYPE_CODE)
			Values (@Id,1, @OriginalKey, @TypeCode)
			
			Fetch Phone Into @Id, @OriginalKey, @TypeCode
		End
		
		Close Phone
		Deallocate Phone
	
	-- Payment Method
		Declare PaymentMethodCursor Cursor For
		Select p.Party_Id, p.Original_Key, (select c.Code_Id as PaymentTypeCode
							from Code c
							Where c.RefType_Id = 121
								AND c.Code = 'P')
		From Party p
		Left Outer Join PaymentMethod pm
			on p.Party_Id = pm.PartyId
		Where p.Type_Code = 'P'
			AND pm.PartyID IS NULL
		
		Open PaymentMethodCursor
		
		Fetch PaymentMethodCursor Into @Id, @OriginalKey, @TypeCode
		While @@Fetch_Status = 0
		Begin	
	
			Insert Into PaymentMethod (PartyId, SourceSystemId, OriginalKey, PaymentTypeCode)
			Values (@Id,1, @OriginalKey, @TypeCode)
			
			Fetch PaymentMethodCursor Into @Id, @OriginalKey, @TypeCode
		End
		
		Close PaymentMethodCursor
		Deallocate PaymentMethodCursor
	END
ELSE
	BEGIN
		PRINT '|-----------------------------------|'
		PRINT ''
		PRINT ' Available Parameters: @AreYouSure'
		PRINT ' Acceptable Values = YES'
		PRINT '|-----------------------------------|'
	END

END

