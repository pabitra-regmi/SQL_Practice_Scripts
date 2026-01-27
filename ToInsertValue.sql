use info;

select * from migratation
where MemberId = 0;



USE [info];
GO
INSERT INTO [dbo].[migratation]
(
    [MemberID],
    [MemberName],
    [Gender],
    [PermanentAddressDetail],
    [TemporaryAddressDetail],
    [MobileNo],
    [FatherName],
    [BirthOnBS],
    [ABADHIK SAVING TYPES],
    [AccountOpenOnBs],
    [Account Maturity Date],
    [Interest rate],
    [ABADHIK SAVING],
    [DAINIK SAVING],
    [INT RATE],
    [AccountOpenOnBs1],
    [DAINIK SAVING BALANCE],
    [BAL  BACHAT SAVING ],
    [CHILD NAME],
    [Account Open Date],
    [Account Maturity Date1],
    [Interest rate1],
    [BAL BACHAT Saving Account Balance],
    [KHUTURKE SAVING ],
    [INT RATE1],
    [Account Open Date1],
    [khuturke saving balance],
    [BUSINESS LOAN LAST PRINCIPAL BALANCE ],
    [interest rate2],
    [loan issue date],
    [Maturity date],
    [ BAIDEKSHIK LOANprinciple last balance],
    [interest rate3],
    [Loan issue Date1],
    [Maturity date1],
    [Share Balance]
)
VALUES
(
    0,                              -- MemberID (numeric)
    'John Doe',                        -- MemberName
    'MALE',                             -- Gender
    'Kathmandu',                        -- PermanentAddressDetail
    'Bhaktapur',                        -- TemporaryAddressDetail
    '9800000000',                        -- MobileNo
    'Father Name',                       -- FatherName
    '2065.01.01',                        -- BirthOnBS
    'DAILY SAVING',                       -- ABADHIK SAVING TYPES
    '2082.01.01',                         -- AccountOpenOnBs
    '2083.01.01',                         -- Account Maturity Date
    5.0,                                   -- Interest rate (float)
    'ABADHIK SAVING',                      -- ABADHIK SAVING
    'DAINIK SAVING',                       -- DAINIK SAVING
    6.0,                                   -- INT RATE (float)
    '2082.01.01',                          -- AccountOpenOnBs1
    5000.0,                                -- DAINIK SAVING BALANCE (float)
    'BAL BACHAT SAVING',                   -- BAL BACHAT SAVING
    2,                                     -- CHILD NAME (float)
    '2082.01.01',                          -- Account Open Date
    '2083.01.01',                          -- Account Maturity Date1
    4.5,                                   -- Interest rate1 (float)
    2000.0,                                -- BAL BACHAT Saving Account Balance (float)
    'KHUTURKE SAVING',                     -- KHUTURKE SAVING
    3.0,                                   -- INT RATE1 (float)
    '2082.01.01',                          -- Account Open Date1
    '1500',                                -- khuturke saving balance
    10000.0,                               -- BUSINESS LOAN LAST PRINCIPAL BALANCE (float)
    7.5,                                   -- interest rate2 (float)
    '2082.01.01',                          -- loan issue date
    '2084.01.01',                          -- Maturity date
    'BAIDEKSHIK LOAN PRINCIPAL',           -- BAIDEKSHIK LOANprinciple last balance
    8.0,                                   -- interest rate3 (float)
    '2082.01.01',                          -- Loan issue Date1
    '2085.01.01',                          -- Maturity date1
    5000.0                                 -- Share Balance (float)
);



USE [NexGenCoSysDBDev];
GO

DELETE FROM dbo.MamAccountOpening;
-- Reset the identity to start from 1
DBCC CHECKIDENT ('dbo.MamAccountOpening', RESEED, 0);


INSERT INTO [dbo].[MamAccountOpening]
(
    [UsmOfficeId],
    [MemMemberRegistrationId],
    [HurCollectorId],
    [AccountNo],
    [SycDepositTypeId],
    [MamAccountHolderTypeId],
    [InterestRate],
    [SycInterestCalculationTypeId],
    [SycDepositMethodTypeId],
    [MamInterestTransferAccountOpeningId],
    [TaxRate],
    [AccountOpenOn],
    [AccountOpenOnBs],
    [Certificates],
    [Signature],
    [LedgerBalance],
    [FreezeAmount],
    [MaturityOn],
    [MaturityOnBs],
    [NextInterestDateOn],
    [NextInterestDateOnBs],
    [Withdrawal],
    [AccountClose],
    [MamAccountStatusId],
    [TermDepositInstallmentAmount],
    [TermDepositMaturityAmount],
    [TermDepositNoOfInstallment],
    [TermDepositNoOfInstallmentType],
    [SycSmsCategoryId],
    [Remarks],
    [BalanceCd],
    [LastInterestDateOn],
    [LastInterestDateOnBs],
    [IsInterestCalculationActive],
    [IsInterestCreditable],
    [IsInterestCustomized],
    [InterestPayable],
    [TaxReceivable],
    [PendingTransactionRemarks],
    [CreatedBy],
    [CreatedOn],
    [CreatedOnBs],
    [LastModifiedBy],
    [LastModifiedOn],
    [LastModifiedOnBs],
    [IsDeleted],
    [IsRenewed],
    [PreviousInterest],
    [PinCode],
    [PinCodeGeneratedOn],
    [PinCodeGeneratedBy],
    [PinCodeLastChangedOn],
    [MinimumAmount],
    [MaximumAmount],
    [IsFundTransferActive],
    [eSewaId],
    [AccountNamingOption],
    [MinorAccount],
    [AccountName],
    [EnableMobileAppNotification],
    [CompulsaryAmountLastChangedOn],
    [CompulsaryAmountLastChangedOnBS],
    [CompulsaryDueAmount],
    [CompulsaryDueAmountCount],
    [CompulsaryDueAmountInstallment],
    [PenaltyTillDateOn],
    [PenaltyTillDateOnBs],
    [PreviousPenaltyAmount],
    [RenewAutomatically],
    [MinorBirthDateOn],
    [MinorBirthDateOnBs],
    [MobileAppIssueDateOn],
    [MobileAppMaturityDateOn],
    [MobileAppIssueDateOnBs],
    [MobileAppMaturityDateOnBs],
    [MobileAppRenewDateOn],
    [MobileAppRenewDateOnBs],
    [IsRenewMobileApp]
)
SELECT
    ISNULL(mreg.MemMemberRegistrationId, 0),  -- MemMemberRegistrationId
    1, -- UsmOfficeId
    1, -- HurCollectorId
    CAST(mreg.MemMemberRegistrationId AS NVARCHAR(50)), -- AccountNo
    1, -- SycDepositTypeId
    1, -- MamAccountHolderTypeId
    0, -- InterestRate
    1, -- SycInterestCalculationTypeId
    1, -- SycDepositMethodTypeId
    NULL, -- MamInterestTransferAccountOpeningId
    0, -- TaxRate
    GETDATE(), -- AccountOpenOn
    '2082/01/01', -- AccountOpenOnBs
    '', -- Certificates
    '', -- Signature
    0, -- LedgerBalance
    0, -- FreezeAmount
    NULL, -- MaturityOn
    '', -- MaturityOnBs
    GETDATE(), -- NextInterestDateOn
    '2082/01/01', -- NextInterestDateOnBs
    0, -- Withdrawal
    0, -- AccountClose
    1, -- MamAccountStatusId
    0, -- TermDepositInstallmentAmount
    0, -- TermDepositMaturityAmount
    0, -- TermDepositNoOfInstallment
    '', -- TermDepositNoOfInstallmentType
    1, -- SycSmsCategoryId
    '', -- Remarks
    0, -- BalanceCd
    NULL, -- LastInterestDateOn
    '', -- LastInterestDateOnBs
    0, -- IsInterestCalculationActive
    0, -- IsInterestCreditable
    0, -- IsInterestCustomized
    0, -- InterestPayable
    0, -- TaxReceivable
    '', -- PendingTransactionRemarks
    0, -- CreatedBy
    GETDATE(), -- CreatedOn
    '2082/01/01', -- CreatedOnBs
    0, -- LastModifiedBy
    NULL, -- LastModifiedOn
    '', -- LastModifiedOnBs
    0, -- IsDeleted
    0, -- IsRenewed
    0, -- PreviousInterest
    '', -- PinCode
    NULL, -- PinCodeGeneratedOn
    0, -- PinCodeGeneratedBy
    NULL, -- PinCodeLastChangedOn
    0, -- MinimumAmount
    0, -- MaximumAmount
    0, -- IsFundTransferActive
    '', -- eSewaId
    0, -- AccountNamingOption
    0, -- MinorAccount
    '', -- AccountName
    0, -- EnableMobileAppNotification
    NULL, -- CompulsaryAmountLastChangedOn
    '', -- CompulsaryAmountLastChangedOnBS
    0, -- CompulsaryDueAmount
    0, -- CompulsaryDueAmountCount
    0, -- CompulsaryDueAmountInstallment
    NULL, -- PenaltyTillDateOn
    '', -- PenaltyTillDateOnBs
    0, -- PreviousPenaltyAmount
    0, -- RenewAutomatically
    NULL, -- MinorBirthDateOn
    '', -- MinorBirthDateOnBs
    NULL, -- MobileAppIssueDateOn
    NULL, -- MobileAppMaturityDateOn
    '', -- MobileAppIssueDateOnBs
    '', -- MobileAppMaturityDateOnBs
    NULL, -- MobileAppRenewDateOn
    '', -- MobileAppRenewDateOnBs
    0 -- IsRenewMobileApp
FROM info.dbo.migratation m
INNER JOIN NexGenCoSysDBDev.dbo.MemMemberRegistration mreg
    ON m.MemberName = mreg.MemberName;





