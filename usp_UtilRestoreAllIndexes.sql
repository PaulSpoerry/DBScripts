SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[usp_UtilRestoreAllIndexes]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[usp_UtilRestoreAllIndexes]
GO





Create Procedure usp_UtilRestoreAllIndexes
/******************************************************************************\
Description :  Return the record for a passed in form type
--------------------------------------------------------------------------------
Author : Ken Sturgeon		Date : 05/30/2001

--------------------------------------------------------------------------------
Modification History
	<ini>		<date>		<description>

\*******************************************************************************/
As
	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('XREF')
			and   name  = 'XRef_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index XRef_1_idx on XREF (REFTYPE_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('XREF')
			and   name  = 'XRef_3_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index XRef_3_idx on XREF (TO_CODE_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('WebClaimServiceAddress')
			and   name  = 'XIF102WebClaimServiceAddress'
			and   indid > 0
			and   indid < 255)
		begin
			create index XIF102WebClaimServiceAddress on WebClaimServiceAddress (WebClaimServiceProviderId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('WebClaimProcessLog')
			and   name  = 'XIF107WebClaimProcessLog'
			and   indid > 0
			and   indid < 255)
		begin
			create index XIF107WebClaimProcessLog on WebClaimProcessLog (DatasetId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('WebClaimProcessLog')
			and   name  = 'WebClaimProcessLog_idx_1'
			and   indid > 0
			and   indid < 255)
		begin
			create index WebClaimProcessLog_idx_1 on WebClaimProcessLog (LoginId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('WebClaimHCFA1500Lines')
			and   name  = 'XIF115WebClaimHCFA1500Lines'
			and   indid > 0
			and   indid < 255)
		begin
			create index XIF115WebClaimHCFA1500Lines on WebClaimHCFA1500Lines (WebClaimHcfa1500Id)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('WebClaimEnrollment')
			and   name  = 'XIF112WebClaimEnrollment'
			and   indid > 0
			and   indid < 255)
		begin
			create index XIF112WebClaimEnrollment on WebClaimEnrollment (ProfileId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('WebClaimEnrollment')
			and   name  = 'XIF113WebClaimEnrollment'
			and   indid > 0
			and   indid < 255)
		begin
			create index XIF113WebClaimEnrollment on WebClaimEnrollment (WebClaimProfileId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('WebClaimDentalUSLines')
			and   name  = 'XIF116WebClaimDentalUSLines'
			and   indid > 0
			and   indid < 255)
		begin
			create index XIF116WebClaimDentalUSLines on WebClaimDentalUSLines (WebClaimDentalUSId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('URL_LINK')
			and   name  = 'URLLink_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index URLLink_1_idx on URL_LINK (Profile_Id)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('URL_LINK')
			and   name  = 'URLLink_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index URLLink_2_idx on URL_LINK (DatasetId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('SYSTEM_ENROLLMENT')
			and   name  = 'SystemEnrollment_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index SystemEnrollment_2_idx on SYSTEM_ENROLLMENT (AGENT_CODE, SYSTEM_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('Process_Log')
			and   name  = 'ProcessLog_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index ProcessLog_1_idx on Process_Log (Process_Id)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('Process_Log')
			and   name  = 'ProcessLog_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index ProcessLog_2_idx on Process_Log (Parent_Process_Id)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PaymentMethod')
			and   name  = 'PaymentMethod_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index PaymentMethod_1_udx on PaymentMethod (OriginalKey, PaymentTypeCode, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PaymentMethod')
			and   name  = 'PaymentMethod_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index PaymentMethod_cdx on PaymentMethod (PartyId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PartyAccountCoverage')
			and   name  = 'PartyAccountCoverage_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index PartyAccountCoverage_1_udx on PartyAccountCoverage (OriginalKey, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PartyAccountCoverage')
			and   name  = 'PartyAccountCoverage_3_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index PartyAccountCoverage_3_idx on PartyAccountCoverage (PartyPolicyAccountId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PartyAccountCoverage')
			and   name  = 'PartyAccountCoverage_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index PartyAccountCoverage_2_idx on PartyAccountCoverage (GroupAccountCoverageId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PartyAccountCoverage')
			and   name  = 'PartyAccountCoverage_4_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index PartyAccountCoverage_4_idx on PartyAccountCoverage (PrimaryPartyId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PartyAccountCoverage')
			and   name  = 'PartyAccountCoverage_5_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index PartyAccountCoverage_5_idx on PartyAccountCoverage (CoveredPartyId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PROVIDER_ENROLLMENT')
			and   name  = 'ProviderEnrollment_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index ProviderEnrollment_cdx on PROVIDER_ENROLLMENT (Profile_Id)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PROVIDER_ENROLLMENT')
			and   name  = 'ProviderEnrollment_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index ProviderEnrollment_2_idx on PROVIDER_ENROLLMENT (SYSTEM_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PREFERENCE')
			and   name  = 'Preference_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index Preference_1_idx on PREFERENCE (Profile_Id)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PHONE')
			and   name  = 'Phone_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index Phone_1_udx on PHONE (ORIGINAL_KEY, TYPE_CODE, SOURCE_SYSTEM_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PHONE')
			and   name  = 'Phone_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index Phone_cdx on PHONE (PARTY_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PARTICIPANT_ENROLLMENT')
			and   name  = 'ParticipantEnrollment_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index ParticipantEnrollment_cdx on PARTICIPANT_ENROLLMENT (Profile_Id)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PARTICIPANT_ENROLLMENT')
			and   name  = 'ParticipantEnrollment_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index ParticipantEnrollment_2_idx on PARTICIPANT_ENROLLMENT (SYSTEM_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PARTICIPANT_ENROLLMENT')
			and   name  = 'ParticipantEnrollment_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index ParticipantEnrollment_1_idx on PARTICIPANT_ENROLLMENT (PARTICIPANT_CODE, POLICY_GROUP)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPaymentTaxHistory')
			and   name  = 'GroupPaymentTaxHistory_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index GroupPaymentTaxHistory_1_udx on GroupPaymentTaxHistory (OriginalKey, SystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPaymentTaxHistory')
			and   name  = 'GroupPaymentTaxHistory_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupPaymentTaxHistory_1_idx on GroupPaymentTaxHistory (GroupPaymentHistoryId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPartyMiscellaneous')
			and   name  = 'GroupPartyMiscellaneous_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index GroupPartyMiscellaneous_1_udx on GroupPartyMiscellaneous (OriginalKey, GroupPartyTypeCode, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPartyMiscellaneous')
			and   name  = 'GroupPartyMiscellaneous_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupPartyMiscellaneous_cdx on GroupPartyMiscellaneous (PartyId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupBillingTaxHistory')
			and   name  = 'GroupBillingTaxHistory_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index GroupBillingTaxHistory_1_udx on GroupBillingTaxHistory (OriginalKey, SystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupBillingTaxHistory')
			and   name  = 'GroupBillingTaxHistory_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupBillingTaxHistory_1_idx on GroupBillingTaxHistory (GroupBillingHistoryId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupBillingAgent')
			and   name  = 'GroupBillingAgent_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index GroupBillingAgent_1_udx on GroupBillingAgent (OriginalKey, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupBillingAgent')
			and   name  = 'GroupBillingAgent_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupBillingAgent_1_idx on GroupBillingAgent (GroupPolicyBillingId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupBillingAgent')
			and   name  = 'GroupBillingAgent_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupBillingAgent_2_idx on GroupBillingAgent (AgentPartyId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GRP_ACCT_ENROLLMENT')
			and   name  = 'GroupAccountEnrollment_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index GroupAccountEnrollment_cdx on GRP_ACCT_ENROLLMENT (Profile_Id)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GRP_ACCT_ENROLLMENT')
			and   name  = 'GroupAccountEnrollment_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupAccountEnrollment_2_idx on GRP_ACCT_ENROLLMENT (SYSTEM_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GRP_ACCT_ENROLLMENT')
			and   name  = 'GroupAccountEnrollment_3_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupAccountEnrollment_3_idx on GRP_ACCT_ENROLLMENT (POLICY_ACCOUNT)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GRP_ACCT_ENROLLMENT')
			and   name  = 'GroupAccountEnrollment_4_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupAccountEnrollment_4_idx on GRP_ACCT_ENROLLMENT (POLICY_GROUP)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FormGroupAccount')
			and   name  = 'FormGroupAccount_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FormGroupAccount_1_idx on FormGroupAccount (FORM_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FormGroupAccount')
			and   name  = 'FormGroupAccount_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FormGroupAccount_2_idx on FormGroupAccount (PolicyAccount, PolicyGroup, Systemid)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FORM_STATE')
			and   name  = 'FormState_1_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FormState_1_cdx on FORM_STATE (FORM_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FAQ')
			and   name  = 'FAQ_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FAQ_1_idx on FAQ (DatasetId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('EMAIL')
			and   name  = 'EMail_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index EMail_1_udx on EMAIL (Original_Key, TYPE_CODE, SOURCE_SYSTEM_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('EMAIL')
			and   name  = 'EMail_1_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index EMail_1_cdx on EMAIL (PARTY_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('DatasetRefType')
			and   name  = 'DatasetRefType_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index DatasetRefType_2_idx on DatasetRefType (REFTYPE_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('DataValidationScheme')
			and   name  = 'DataValidationScheme_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index DataValidationScheme_1_idx on DataValidationScheme (DatasetId, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('DataValidationScheme')
			and   name  = 'DataValidationScheme_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index DataValidationScheme_2_idx on DataValidationScheme (ErrorCode)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('Content_Text')
			and   name  = 'ContentText_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index ContentText_1_idx on Content_Text (DatasetId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('Contact')
			and   name  = 'Contact_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index Contact_1_idx on Contact (Contact_Group_Id)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ColumnTag')
			and   name  = 'ColumnTag_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique clustered index ColumnTag_cdx on ColumnTag (MajorTagId, StartPosition)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ColumnTag')
			and   name  = 'ColumnTag_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index ColumnTag_1_idx on ColumnTag (MajorTagId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ClaimPayment')
			and   name  = 'ClaimPayment_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index ClaimPayment_1_udx on ClaimPayment (OriginalKey, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ClaimPayment')
			and   name  = 'ClaimPayment_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index ClaimPayment_1_idx on ClaimPayment (ClaimStatusId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ClaimBenefits')
			and   name  = 'ClaimBenefits_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index ClaimBenefits_1_udx on ClaimBenefits (OriginalKey, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ClaimBenefits')
			and   name  = 'ClaimBenefits_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index ClaimBenefits_1_idx on ClaimBenefits (ClaimProviderId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ClaimAccumulator')
			and   name  = 'ClaimAccumulator_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index ClaimAccumulator_1_udx on ClaimAccumulator (OriginalKey, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ClaimAccumulator')
			and   name  = 'ClaimAccumulator_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index ClaimAccumulator_cdx on ClaimAccumulator (PartyId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('CALENDAR_EVENT')
			and   name  = 'CalendarEvent_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index CalendarEvent_1_idx on CALENDAR_EVENT (DatasetId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('AUTH_LOG')
			and   name  = 'fk_AuthLog_1'
			and   indid > 0
			and   indid < 255)
		begin
			create index fk_AuthLog_1 on AUTH_LOG (DatasetId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ADDRESS')
			and   name  = 'Address_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index Address_1_udx on ADDRESS (ORIGINAL_KEY, TYPE_CODE, START_DATE, SOURCE_SYSTEM_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ADDRESS')
			and   name  = 'Address_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index Address_cdx on ADDRESS (PARTY_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('WebClaimHCFA1500')
			and   name  = 'XIF114WebClaimHCFA1500'
			and   indid > 0
			and   indid < 255)
		begin
			create index XIF114WebClaimHCFA1500 on WebClaimHCFA1500 (WebClaimClaimsId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('WebClaimDentalUs')
			and   name  = 'XIF117WebClaimDentalUs'
			and   indid > 0
			and   indid < 255)
		begin
			create index XIF117WebClaimDentalUs on WebClaimDentalUs (WebClaimClaimsId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('WebClaimClaims')
			and   name  = 'WebClaimClaims_idx_2'
			and   indid > 0
			and   indid < 255)
		begin
			create index WebClaimClaims_idx_2 on WebClaimClaims (WebClaimInputFormId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('WebClaimClaims')
			and   name  = 'WebClaimClaims_idx_1'
			and   indid > 0
			and   indid < 255)
		begin
			create index WebClaimClaims_idx_1 on WebClaimClaims (ProfileId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('WebClaimClaims')
			and   name  = 'WebClaimClaims_idx_3'
			and   indid > 0
			and   indid < 255)
		begin
			create index WebClaimClaims_idx_3 on WebClaimClaims (WebClaimServiceProviderId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('WebClaimClaims')
			and   name  = 'WebClaimClaims_idx_4'
			and   indid > 0
			and   indid < 255)
		begin
			create index WebClaimClaims_idx_4 on WebClaimClaims (WebClaimServiceAddressId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('MajorTag')
			and   name  = 'MajorTag_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index MajorTag_1_udx on MajorTag (TagName, SystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('MajorTag')
			and   name  = 'MajorTag_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index MajorTag_1_idx on MajorTag (SystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('DatasetExternalSystem')
			and   name  = 'DatasetExternalSystem_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index DatasetExternalSystem_2_idx on DatasetExternalSystem (SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('CODE')
			and   name  = 'Code_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index Code_1_udx on CODE (CODE, REFTYPE_ID, SYSTEM_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('CODE')
			and   name  = 'Code_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index Code_2_idx on CODE (REFTYPE_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('CODE')
			and   name  = 'Code_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index Code_1_idx on CODE (SYSTEM_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('EXTERNAL_SYSTEM')
			and   name  = 'ExternalSystem_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index ExternalSystem_1_udx on EXTERNAL_SYSTEM (SYSTEM_CODE)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('EXTERNAL_SYSTEM')
			and   name  = 'ExternalSystem_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index ExternalSystem_1_idx on EXTERNAL_SYSTEM (REFTYPE_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPaymentHistory')
			and   name  = 'GroupPaymentHistory_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index GroupPaymentHistory_1_udx on GroupPaymentHistory (OriginalKey, SystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPaymentHistory')
			and   name  = 'GroupPaymentHistory_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupPaymentHistory_2_idx on GroupPaymentHistory (GroupPolicyBillingKey, BillingDueDate)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupBillingHistory')
			and   name  = 'GroupBillingHistory_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index GroupBillingHistory_1_udx on GroupBillingHistory (OriginalKey, SystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupBillingHistory')
			and   name  = 'GroupBillingHistory_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupBillingHistory_2_idx on GroupBillingHistory (GroupPolicyBillingKey, BillingDueDate)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PartyPolicyAccount')
			and   name  = 'PartyPolicyAccount_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index PartyPolicyAccount_1_udx on PartyPolicyAccount (OriginalKey, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PartyPolicyAccount')
			and   name  = 'PartyPolicyAccount_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index PartyPolicyAccount_2_idx on PartyPolicyAccount (PrimaryInsuredPartyId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PartyPolicyAccount')
			and   name  = 'PartyPolicyAccount_3_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index PartyPolicyAccount_3_idx on PartyPolicyAccount (PolicyAccount, PolicyGroup)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPolicyBilling')
			and   name  = 'GroupPolicyBilling_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index GroupPolicyBilling_1_udx on GroupPolicyBilling (OriginalKey, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPolicyBilling')
			and   name  = 'GroupPolicyBilling_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupPolicyBilling_1_idx on GroupPolicyBilling (GroupPolicyAccountId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPolicyBilling')
			and   name  = 'GroupPolicyBilling_3_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupPolicyBilling_3_idx on GroupPolicyBilling (BillingPartyId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupAccountCoverage')
			and   name  = 'GroupAccountCoverage_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index GroupAccountCoverage_1_udx on GroupAccountCoverage (OriginalKey, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupAccountCoverage')
			and   name  = 'GroupAccountCoverage_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupAccountCoverage_1_idx on GroupAccountCoverage (GroupCoverageId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupAccountCoverage')
			and   name  = 'GroupAccountCoverage_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupAccountCoverage_2_idx on GroupAccountCoverage (PolicyPartyId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPolicyAccount')
			and   name  = 'GroupPolicyAccount_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index GroupPolicyAccount_1_udx on GroupPolicyAccount (OriginalKey, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPolicyAccount')
			and   name  = 'GroupPolicyAccount_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupPolicyAccount_1_idx on GroupPolicyAccount (GroupPolicyId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPolicyAccount')
			and   name  = 'GroupPolicyAccount_4_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupPolicyAccount_4_idx on GroupPolicyAccount (PolicyPartyId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPolicyAccount')
			and   name  = 'GroupPolicyAccount_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupPolicyAccount_2_idx on GroupPolicyAccount (PolicyAccount, PolicyGroup, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupCoverage')
			and   name  = 'GroupCoverage_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index GroupCoverage_1_udx on GroupCoverage (OriginalKey, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupCoverage')
			and   name  = 'GroupCoverage_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupCoverage_1_idx on GroupCoverage (GroupPolicyId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FORM')
			and   name  = 'Form_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index Form_1_idx on FORM (FORM_TYPE_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FORM')
			and   name  = 'Form_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index Form_2_idx on FORM (KEYWORD)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('WebClaimServiceProvider')
			and   name  = 'XIF100WebClaimServiceProvider'
			and   indid > 0
			and   indid < 255)
		begin
			create index XIF100WebClaimServiceProvider on WebClaimServiceProvider (ProfileId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PROFILES')
			and   name  = 'Profiles_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index Profiles_1_idx on PROFILES (DatasetId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ClaimProvider')
			and   name  = 'ClaimProvider_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index ClaimProvider_1_udx on ClaimProvider (OriginalKey, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ClaimProvider')
			and   name  = 'ClaimProvider_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index ClaimProvider_1_idx on ClaimProvider (ClaimStatusId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('REF_TYPE')
			and   name  = 'RefType_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index RefType_1_udx on REF_TYPE (DESCRIPTION)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PARTY')
			and   name  = 'Party_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index Party_1_udx on PARTY (ORIGINAL_KEY, SOURCE_SYSTEM_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PARTY')

			and   name  = 'Party_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index Party_2_idx on PARTY (TYPE_CODE)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PARTY')
			and   name  = 'Party_3_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index Party_3_idx on PARTY (ParticipantCode)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PARTY')
			and   name  = 'Party_4_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index Party_4_idx on PARTY (IdentificationCode)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PARTY')
			and   name  = 'Party_5_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index Party_5_idx on PARTY (SOURCE_SYSTEM_ID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PARTY')
			and   name  = 'Party_6_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index Party_6_idx on PARTY (PolicyGroup)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PARTY')
			and   name  = 'Party_7_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index Party_7_idx on PARTY (LAST_NAME, FIRST_NAME)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('PARTY')
			and   name  = 'Party_8_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index Party_8_idx on PARTY (CertificateCode)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPolicy')
			and   name  = 'GroupPolicy_2_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index GroupPolicy_2_udx on GroupPolicy (PolicyGroup, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPolicy')
			and   name  = 'GroupPolicy_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index GroupPolicy_1_udx on GroupPolicy (OriginalKey, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ClaimStatus')
			and   name  = 'ClaimStatus_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index ClaimStatus_1_udx on ClaimStatus (OriginalKey, SourceSystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ClaimStatus')
			and   name  = 'ClaimStatus_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index ClaimStatus_1_idx on ClaimStatus (ClaimantPartyId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ClaimStatus')
			and   name  = 'ClaimStatus_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index ClaimStatus_2_idx on ClaimStatus (PrimaryInsuredPartyId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('ClaimStatus')
			and   name  = 'ClaimStatus_3_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index ClaimStatus_3_idx on ClaimStatus (ClaimNumber)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('spLog')
			and   name  = 'spLog_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index spLog_cdx on spLog (TimeStamp)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('IdReference')
			and   name  = 'IdReference_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index IdReference_1_idx on IdReference (Instance)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPaymentsReceived')
			and   name  = 'GroupPaymentsReceived_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index GroupPaymentsReceived_1_udx on GroupPaymentsReceived (OriginalKey, SystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPaymentsReceived')
			and   name  = 'GroupPaymentsReceived_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupPaymentsReceived_2_idx on GroupPaymentsReceived (GroupPolicyBillingKey)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPaymentsIssued')
			and   name  = 'GroupPaymentsIssued_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index GroupPaymentsIssued_1_udx on GroupPaymentsIssued (OriginalKey, SystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPaymentsIssued')
			and   name  = 'GroupPaymentsIssued_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupPaymentsIssued_2_idx on GroupPaymentsIssued (GroupPolicyBillingKey, TransactionDate)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupPaymentSummary')
			and   name  = 'GroupPaymentSummary_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupPaymentSummary_1_idx on GroupPaymentSummary (GroupPolicyBillingKey, BillingDueDate)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupBillingVariance')
			and   name  = 'GroupBillingVariance_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupBillingVariance_1_idx on GroupBillingVariance (GroupPolicyBillingKey, BillingDueDate)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupBillingSummary')
			and   name  = 'GroupBillingSummary_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupBillingSummary_1_idx on GroupBillingSummary (GroupPolicyBillingKey, BillingDueDate)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupBillingPaymentTransactions')
			and   name  = 'GroupBillingPaymentTransactions_1_udx'
			and   indid > 0
			and   indid < 255)
		begin
			create unique index GroupBillingPaymentTransactions_1_udx on GroupBillingPaymentTransactions (OriginalKey, SystemId)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupBillingPaymentTransactions')
			and   name  = 'GroupBillingPaymentTransactions_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupBillingPaymentTransactions_2_idx on GroupBillingPaymentTransactions (GroupPolicyBillingKey)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('GroupBillingPaymentTransactions')
			and   name  = 'GroupBillingPaymentTransactions_3_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index GroupBillingPaymentTransactions_3_idx on GroupBillingPaymentTransactions (TransactionDate)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FormChangeLog')
			and   name  = 'FormChangeLog_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FormChangeLog_1_idx on FormChangeLog (LoginID)
			on "PRIMARY"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPhoneHistory')
			and   name  = 'FeedPhoneHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedPhoneHistory_cdx on FeedPhoneHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPhoneHistory')
			and   name  = 'FeedPhoneHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedPhoneHistory_EC_idx on FeedPhoneHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPhone')
			and   name  = 'FeedPhone_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedPhone_1_idx on FeedPhone (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPhone')
			and   name  = 'FeedPhone_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedPhone_2_idx on FeedPhone (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPaymentMethodHistory')
			and   name  = 'FeedPaymentMethodHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedPaymentMethodHistory_cdx on FeedPaymentMethodHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPaymentMethodHistory')
			and   name  = 'FeedPaymentMethodHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedPaymentMethodHistory_EC_idx on FeedPaymentMethodHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPaymentMethod')
			and   name  = 'FeedPaymentMethod_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedPaymentMethod_1_idx on FeedPaymentMethod (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPaymentMethod')
			and   name  = 'FeedPaymentMethod_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedPaymentMethod_2_idx on FeedPaymentMethod (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPartyPolicyAccountHistory')
			and   name  = 'FeedPartyPolicyAccountHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedPartyPolicyAccountHistory_cdx on FeedPartyPolicyAccountHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPartyPolicyAccountHistory')
			and   name  = 'FeedPartyPolicyAccountHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedPartyPolicyAccountHistory_EC_idx on FeedPartyPolicyAccountHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPartyPolicyAccount')
			and   name  = 'FeedPartyPolicyAccount_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedPartyPolicyAccount_1_idx on FeedPartyPolicyAccount (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPartyPolicyAccount')
			and   name  = 'FeedPartyPolicyAccount_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedPartyPolicyAccount_2_idx on FeedPartyPolicyAccount (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPartyHistory')
			and   name  = 'FeedPartyHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedPartyHistory_cdx on FeedPartyHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPartyHistory')
			and   name  = 'FeedPartyHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedPartyHistory_EC_idx on FeedPartyHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPartyAccountCoverageHistory')
			and   name  = 'FeedPartyAccountCoverageHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedPartyAccountCoverageHistory_cdx on FeedPartyAccountCoverageHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPartyAccountCoverageHistory')
			and   name  = 'FeedPartyAccountCoverageHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedPartyAccountCoverageHistory_EC_idx on FeedPartyAccountCoverageHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPartyAccountCoverage')
			and   name  = 'FeedPartyAccountCoverage_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedPartyAccountCoverage_1_idx on FeedPartyAccountCoverage (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedPartyAccountCoverage')
			and   name  = 'FeedPartyAccountCoverage_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedPartyAccountCoverage_2_idx on FeedPartyAccountCoverage (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedParty')
			and   name  = 'FeedParty_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedParty_1_idx on FeedParty (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedParty')
			and   name  = 'FeedParty_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedParty_2_idx on FeedParty (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPolicyHistory')
			and   name  = 'FeedGroupPolicyHistory_1_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedGroupPolicyHistory_1_cdx on FeedGroupPolicyHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPolicyHistory')
			and   name  = 'FeedGroupPolicyHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPolicyHistory_EC_idx on FeedGroupPolicyHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPolicyBillingHistory')
			and   name  = 'FeedGroupPolicyBillingHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedGroupPolicyBillingHistory_cdx on FeedGroupPolicyBillingHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPolicyBillingHistory')
			and   name  = 'FeedGroupPolicyBillingHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPolicyBillingHistory_EC_idx on FeedGroupPolicyBillingHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPolicyBilling')
			and   name  = 'FeedGroupPolicyBilling_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPolicyBilling_1_idx on FeedGroupPolicyBilling (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPolicyBilling')
			and   name  = 'FeedGroupPolicyBilling_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPolicyBilling_2_idx on FeedGroupPolicyBilling (GroupPolicyAccountKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPolicyBilling')
			and   name  = 'FeedGroupPolicyBilling_3_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPolicyBilling_3_idx on FeedGroupPolicyBilling (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPolicyAccountHistory')
			and   name  = 'FeedGroupPolicyAccountHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedGroupPolicyAccountHistory_cdx on FeedGroupPolicyAccountHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPolicyAccountHistory')
			and   name  = 'FeedGroupPolicyAccountHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPolicyAccountHistory_EC_idx on FeedGroupPolicyAccountHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPolicyAccount')
			and   name  = 'FeedGroupPolicyAccount_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPolicyAccount_2_idx on FeedGroupPolicyAccount (PartyKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPolicyAccount')
			and   name  = 'FeedGroupPolicyAccount_3_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPolicyAccount_3_idx on FeedGroupPolicyAccount (PolicyGroup)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPolicyAccount')
			and   name  = 'FeedGroupPolicyAccount_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPolicyAccount_1_idx on FeedGroupPolicyAccount (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPolicyAccount')
			and   name  = 'FeedGroupPolicyAccount_4_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPolicyAccount_4_idx on FeedGroupPolicyAccount (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPolicy')
			and   name  = 'FeedGroupPolicy_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPolicy_1_idx on FeedGroupPolicy (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPolicy')
			and   name  = 'FeedGroupPolicy_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPolicy_2_idx on FeedGroupPolicy (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentsReceivedHistory')
			and   name  = 'FeedGroupPaymentsReceivedHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedGroupPaymentsReceivedHistory_cdx on FeedGroupPaymentsReceivedHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentsReceivedHistory')
			and   name  = 'FeedGroupPaymentsReceivedHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPaymentsReceivedHistory_EC_idx on FeedGroupPaymentsReceivedHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentsReceived')
			and   name  = 'FeedGroupPaymentsReceived_idx_1'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPaymentsReceived_idx_1 on FeedGroupPaymentsReceived (SystemTime)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentsReceived')
			and   name  = 'FeedGroupPaymentsReceived_idx_2'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPaymentsReceived_idx_2 on FeedGroupPaymentsReceived (OriginalKey, SystemTime)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentsIssuedHistory')
			and   name  = 'FeedGroupPaymentsIssuedHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedGroupPaymentsIssuedHistory_cdx on FeedGroupPaymentsIssuedHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentsIssuedHistory')
			and   name  = 'FeedGroupPaymentsIssuedHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPaymentsIssuedHistory_EC_idx on FeedGroupPaymentsIssuedHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentsIssued')
			and   name  = 'FeedGroupPaymentsIssued_idx_1'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPaymentsIssued_idx_1 on FeedGroupPaymentsIssued (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentsIssued')
			and   name  = 'FeedGroupPaymentsIssued_idx_2'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPaymentsIssued_idx_2 on FeedGroupPaymentsIssued (OriginalKey, SystemTime)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentTaxHistoryHistory')
			and   name  = 'FeedGroupPaymentTaxHistoryHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedGroupPaymentTaxHistoryHistory_cdx on FeedGroupPaymentTaxHistoryHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentTaxHistoryHistory')
			and   name  = 'FeedGroupPaymentTaxHistoryHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPaymentTaxHistoryHistory_EC_idx on FeedGroupPaymentTaxHistoryHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentTaxHistory')
			and   name  = 'FeedGroupPaymentTaxHistory_idx_1'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPaymentTaxHistory_idx_1 on FeedGroupPaymentTaxHistory (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentTaxHistory')
			and   name  = 'FeedGroupPaymentTaxHistory_idx_2'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPaymentTaxHistory_idx_2 on FeedGroupPaymentTaxHistory (OriginalKey, SystemTime)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentHistoryHistory')
			and   name  = 'FeedGroupPaymentHistoryHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedGroupPaymentHistoryHistory_cdx on FeedGroupPaymentHistoryHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentHistoryHistory')
			and   name  = 'FeedGroupPaymentHistoryHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPaymentHistoryHistory_EC_idx on FeedGroupPaymentHistoryHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentHistory')
			and   name  = 'FeedGroupPaymentHistory_idx_2'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPaymentHistory_idx_2 on FeedGroupPaymentHistory (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPaymentHistory')
			and   name  = 'FeedGroupPaymentHistory_idx_3'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPaymentHistory_idx_3 on FeedGroupPaymentHistory (OriginalKey, SystemTime)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPartyMiscellaneousHistory')
			and   name  = 'FeedGroupPartyMiscellaneousHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedGroupPartyMiscellaneousHistory_cdx on FeedGroupPartyMiscellaneousHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPartyMiscellaneousHistory')
			and   name  = 'FeedGroupPartyMiscellaneousHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPartyMiscellaneousHistory_EC_idx on FeedGroupPartyMiscellaneousHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPartyMiscellaneous')
			and   name  = 'FeedGroupPartyMiscellaneous_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPartyMiscellaneous_1_idx on FeedGroupPartyMiscellaneous (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupPartyMiscellaneous')
			and   name  = 'FeedGroupPartyMiscellaneous_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupPartyMiscellaneous_2_idx on FeedGroupPartyMiscellaneous (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupCoverageHistory')
			and   name  = 'FeedGroupCoverageHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedGroupCoverageHistory_cdx on FeedGroupCoverageHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupCoverageHistory')
			and   name  = 'FeedGroupCoverageHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupCoverageHistory_EC_idx on FeedGroupCoverageHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupCoverage')
			and   name  = 'FeedGroupCoverage_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupCoverage_1_idx on FeedGroupCoverage (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupCoverage')
			and   name  = 'FeedGroupCoverage_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupCoverage_2_idx on FeedGroupCoverage (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingTaxHistoryHistory')
			and   name  = 'FeedGroupBillingTaxHistoryHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedGroupBillingTaxHistoryHistory_cdx on FeedGroupBillingTaxHistoryHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingTaxHistoryHistory')
			and   name  = 'FeedGroupBillingTaxHistoryHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupBillingTaxHistoryHistory_EC_idx on FeedGroupBillingTaxHistoryHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingTaxHistory')
			and   name  = 'FeedGroupBillingTaxHistory_idx_2'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupBillingTaxHistory_idx_2 on FeedGroupBillingTaxHistory (OriginalKey, SystemTime)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingTaxHistory')
			and   name  = 'FeedGroupBillingTaxHistory_idx_1'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupBillingTaxHistory_idx_1 on FeedGroupBillingTaxHistory (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingPaymentTransactionsHistory')
			and   name  = 'FeedGroupBillingPaymentTransactionsHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedGroupBillingPaymentTransactionsHistory_cdx on FeedGroupBillingPaymentTransactionsHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingPaymentTransactionsHistory')
			and   name  = 'FeedGroupBillingPaymentTransactionsHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupBillingPaymentTransactionsHistory_EC_idx on FeedGroupBillingPaymentTransactionsHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingPaymentTransactions')
			and   name  = 'FeedGroupBillingPaymentTransactions_idx_1'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupBillingPaymentTransactions_idx_1 on FeedGroupBillingPaymentTransactions (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingPaymentTransactions')
			and   name  = 'FeedGroupBillingPaymentTransactions_idx_2'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupBillingPaymentTransactions_idx_2 on FeedGroupBillingPaymentTransactions (OriginalKey, SystemTime)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingHistoryHistory')
			and   name  = 'FeedGroupBillingHistoryHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedGroupBillingHistoryHistory_cdx on FeedGroupBillingHistoryHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingHistoryHistory')
			and   name  = 'FeedGroupBillingHistoryHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupBillingHistoryHistory_EC_idx on FeedGroupBillingHistoryHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingHistory')
			and   name  = 'FeedGroupBillingHistory_idx_2'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupBillingHistory_idx_2 on FeedGroupBillingHistory (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingHistory')
			and   name  = 'FeedGroupBillingHistory_idx_3'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupBillingHistory_idx_3 on FeedGroupBillingHistory (OriginalKey, SystemTime)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingHistory')
			and   name  = 'FeedGroupBillingHistory_idx_1'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupBillingHistory_idx_1 on FeedGroupBillingHistory (GroupBillingSummaryKey, BillingChargeType)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingAgentHistory')
			and   name  = 'FeedGroupBillingAgentHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedGroupBillingAgentHistory_cdx on FeedGroupBillingAgentHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingAgentHistory')
			and   name  = 'FeedGroupBillingAgentHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupBillingAgentHistory_EC_idx on FeedGroupBillingAgentHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingAgent')
			and   name  = 'FeedGroupBillingAgent_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupBillingAgent_1_idx on FeedGroupBillingAgent (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupBillingAgent')
			and   name  = 'FeedGroupBillingAgent_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupBillingAgent_2_idx on FeedGroupBillingAgent (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupAccountCoverageHistory')
			and   name  = 'FeedGroupAccountCoverageHistory_1_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedGroupAccountCoverageHistory_1_cdx on FeedGroupAccountCoverageHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupAccountCoverageHistory')
			and   name  = 'FeedGroupAccountCoverageHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupAccountCoverageHistory_EC_idx on FeedGroupAccountCoverageHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupAccountCoverage')
			and   name  = 'FeedGroupAccountCoverage_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupAccountCoverage_1_idx on FeedGroupAccountCoverage (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedGroupAccountCoverage')
			and   name  = 'FeedGroupAccountCoverage_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedGroupAccountCoverage_2_idx on FeedGroupAccountCoverage (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimStatusHistory')
			and   name  = 'FeedClaimStatusHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedClaimStatusHistory_cdx on FeedClaimStatusHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimStatusHistory')
			and   name  = 'FeedClaimStatusHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedClaimStatusHistory_EC_idx on FeedClaimStatusHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimStatus')
			and   name  = 'FeedClaimStatus_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedClaimStatus_1_idx on FeedClaimStatus (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimStatus')
			and   name  = 'FeedClaimStatus_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedClaimStatus_2_idx on FeedClaimStatus (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimProviderHistory')
			and   name  = 'FeedClaimProviderHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedClaimProviderHistory_cdx on FeedClaimProviderHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimProviderHistory')
			and   name  = 'FeedClaimProviderHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedClaimProviderHistory_EC_idx on FeedClaimProviderHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimProvider')
			and   name  = 'FeedClaimProvider_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedClaimProvider_1_idx on FeedClaimProvider (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimProvider')
			and   name  = 'FeedClaimProvider_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedClaimProvider_2_idx on FeedClaimProvider (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimPaymentHistory')
			and   name  = 'FeedClaimPaymentHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedClaimPaymentHistory_cdx on FeedClaimPaymentHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimPaymentHistory')
			and   name  = 'FeedClaimPaymentHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedClaimPaymentHistory_EC_idx on FeedClaimPaymentHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimPayment')
			and   name  = 'FeedClaimPayment_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedClaimPayment_1_idx on FeedClaimPayment (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimPayment')
			and   name  = 'FeedClaimPayment_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedClaimPayment_2_idx on FeedClaimPayment (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimBenefitsHistory')
			and   name  = 'FeedClaimBenefitsHistory_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedClaimBenefitsHistory_cdx on FeedClaimBenefitsHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimBenefitsHistory')
			and   name  = 'FeedClaimBenefitsHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedClaimBenefitsHistory_EC_idx on FeedClaimBenefitsHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimBenefits')
			and   name  = 'FeedClaimBenefits_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			Create index FeedClaimBenefits_2_idx on FeedClaimBenefits (OriginalKey)
			on "FileGroup_FeedAndCheck"

		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimBenefits')
			and   name  = 'FeedClaimBenefits_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedClaimBenefits_1_idx on FeedClaimBenefits (ClaimNumber, ClaimSubNumber)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimBenefits')
			and   name  = 'FeedClaimBenefits_3_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedClaimBenefits_3_idx on FeedClaimBenefits (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimAccumulatorHistory')
			and   name  = 'FeedClaimAccululator_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedClaimAccululator_cdx on FeedClaimAccumulatorHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimAccumulatorHistory')
			and   name  = 'FeedClaimAccumulatorHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedClaimAccumulatorHistory_EC_idx on FeedClaimAccumulatorHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimAccumulator')
			and   name  = 'FeedClaimAccumulator_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedClaimAccumulator_1_idx on FeedClaimAccumulator (OriginalKey)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedClaimAccumulator')
			and   name  = 'FeedClaimAccumulator_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedClaimAccumulator_2_idx on FeedClaimAccumulator (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedAddressHistory')
			and   name  = 'FeedAddress_cdx'
			and   indid > 0
			and   indid < 255)
		begin
			create clustered index FeedAddress_cdx on FeedAddressHistory (LoadTime)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedAddressHistory')
			and   name  = 'FeedAddressHistory_EC_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedAddressHistory_EC_idx on FeedAddressHistory (ErrorCode)
			on "FileGroup_FeedHistory"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedAddress')
			and   name  = 'FeedAddress_1_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedAddress_1_idx on FeedAddress (OriginalKey, AddressTypeCode, StartDate)
			on "FileGroup_FeedAndCheck"
		end

	if not exists
		(select 1
		from  sysindexes
		where  id    = object_id('FeedAddress')
			and   name  = 'FeedAddress_2_idx'
			and   indid > 0
			and   indid < 255)
		begin
			create index FeedAddress_2_idx on FeedAddress (TriggerEvent)
			on "FileGroup_FeedAndCheck"
		end





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

