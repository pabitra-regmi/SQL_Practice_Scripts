USE [NexGenCoSysDBDev];
GO

DELETE FROM dbo.SycDepositType;
-- Reset the identity to start from 1
DBCC CHECKIDENT ('dbo.SycDepositType', RESEED, 0);
GO
USE NexGenCoSysDBDev;
GO

INSERT INTO dbo.SycDepositType
(
    DepositTypeCode,
    DepositTypeName,
    Duration,
    DurationType,
    SycDepositCategoryId,
    InterestRate,
    SycInterestTypeId,
    SycInterestCalculationPeriodId,
    TaxRate,
    MininumDepositAmount,
    MaximumDepositAmount,
    Widthdrawal,
    Mandatory,
    CollectorCommission,
    CodeValue,
    InterestCalculationType,
    IsCustomizable,
    IsActive,
    InterestActivationOn,
    InterestActivationOnBs,
    SycInterestProvisioningInterestCalculationPeriodId,
    CreatedBy,
    CreatedOn,
    DepositTypeInNepali,
    IsMobileApp
)
SELECT
    DeposittypeCode,                              -- DS, KS, BB, etc.
    DepositTypeName,                              -- Daily Saving etc.
    TRY_CAST(Duration AS INT),                    -- 1
    LEFT(DurationType,1),                         -- Y / M
    1,                                            -- default category
    TRY_CAST(InterestRate AS NUMERIC(18,2)),      -- 6, 9, 10
    1,                                            -- default interest type
    1,                                            -- calculation period
    0,                                            -- TaxRate
    0,                                            -- MininumDepositAmount
    0,                                            -- MaximumDepositAmount
    0,                                            -- Widthdrawal
    0,                                            -- Mandatory
    0,                                            -- CollectorCommission
    0,                                            -- CodeValue
    'M',                                          -- Monthly
    0,                                            -- IsCustomizable
    1,                                            -- IsActive
    GETDATE(),                                    -- InterestActivationOn
    '2082/01/01',                                 -- BS date
    1,                                            -- Provisioning period
    0,                                            -- CreatedBy
    GETDATE(),                                    -- CreatedOn
    DepositTypeName,                              -- Nepali name
    0                                             -- IsMobileApp
FROM info.dbo.datafile
WHERE DeposittypeCode IS NOT NULL
  AND DeposittypeCode <> '';
GO

select *  from SycDepositType
