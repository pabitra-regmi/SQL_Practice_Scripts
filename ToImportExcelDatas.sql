USE [NexGenCoSysDBDev];
GO

-- Clean the table and reset identity
DELETE FROM dbo.MemMemberRegistration;
DBCC CHECKIDENT ('MemMemberRegistration', RESEED, 0);
GO

-- Import Excel sheet into a staging table
SELECT
    MemberId AS ExcelMemberId,
    MemberName,
    SycGenderId
INTO dbo.members_from_info
FROM info..[Sheet1$];
GO

-- Process names and gender
SELECT
    ExcelMemberId,
    LTRIM(RTRIM(LEFT(MemberName, CHARINDEX(' ', MemberName + ' ') - 1))) AS FirstName,
    CASE
        WHEN LEN(LTRIM(RTRIM(MemberName))) - LEN(REPLACE(LTRIM(RTRIM(MemberName)), ' ', '')) >= 2
        THEN LTRIM(RTRIM(SUBSTRING(
                MemberName,
                CHARINDEX(' ', MemberName) + 1,
                LEN(MemberName) - CHARINDEX(' ', MemberName) - CHARINDEX(' ', REVERSE(MemberName))
        )))
        ELSE NULL
    END AS MiddleName,
    CASE
        WHEN CHARINDEX(' ', LTRIM(RTRIM(MemberName))) = 0
        THEN NULL
        ELSE LTRIM(RTRIM(RIGHT(MemberName, CHARINDEX(' ', REVERSE(MemberName)) - 1)))
    END AS LastName,
    CASE
        WHEN UPPER(LTRIM(RTRIM(SycGenderId))) = 'MALE' THEN 1
        WHEN UPPER(LTRIM(RTRIM(SycGenderId))) = 'FEMALE' THEN 2
        ELSE 1
    END AS SycGenderId
INTO dbo.members_processed
FROM dbo.members_from_info;
GO

-- Insert into main table
INSERT INTO dbo.MemMemberRegistration
(
    MemberId,
    SycMemberTypeId,
    UsmOfficeId,
    SycSalutationId,
    FirstName,
    MiddleName,
    LastName,
    BirthOn,
    BirthOnBS,
    PermanentAddessDetail,
    TemporaryAddressDetail,
    PhoneNo,
    MobileNo,
    EmailAddress,
    SycNationalityId,
    CitizenshipNo,
    PassportNo,
    SycOccupationId,
    OtherOccupation,
    SycReligionId,
    SycMaritalStatusId,
    GrandFatherMotherName,
    FatherName,
    MotherName,
    SpouseName,
    SycCasteId,
    SycGenderId,
    SycVdcId,
    RegistrationOn,
    RegistrationOnBS,
    IntroducedBy,
    SycStatusId,
    SycMemberGroupId,
    Remarks,
    CreatedBy,
    CreatedOn,
    CreatedOnBs,
    LastModifiedBy,
    LastModifiedOn,
    LastModifiedOnBs,
    CitizenShipIssuedOn,
    CitizenShipIssuedOnBs,
    CitizenShipIssuedDistrict,
    ElectricityNo,
    WaterSupplyNo,
    IMEINo,
    SycIncomeRangeId,
    SycEducationId,
    DeviceId,
    GPSCoOrdinate,
    SycStateVDCId,
    MemberYearlyPaymentTillDateOn,
    MemberYearlyPaymentTillDateOnBs,
    NameInNepali,
    AddressInNepali
)
SELECT
    'MR-01-' + CAST(ExcelMemberId AS NVARCHAR(50)),  -- MemberId
    3,                                               -- SycMemberTypeId
    2,                                               -- UsmOfficeId
    30,                                              -- SycSalutationId
    FirstName,
    MiddleName,
    LastName,
    dbo.ConvertDateNepaliToEnglish('2045/01/01'),   -- BirthOn
    '2045/01/01',                                   -- BirthOnBS
    '-',                                             -- PermanentAddessDetail
    '-',                                             -- TemporaryAddressDetail
    NULL,                                            -- PhoneNo
    NULL,                                            -- MobileNo
    'name@gmail.com',                                -- EmailAddress
    5,                                               -- SycNationalityId
    NULL,                                            -- CitizenshipNo
    NULL,                                            -- PassportNo
    27,                                              -- SycOccupationId
    NULL,                                            -- OtherOccupation
    1,                                               -- SycReligionId
    3,                                               -- SycMaritalStatusId
    '',                                              -- GrandFatherMotherName
    '',                                              -- FatherName
    '',                                              -- MotherName
    '',                                              -- SpouseName
    3,                                               -- SycCasteId
    SycGenderId,                                    -- SycGenderId
    1,                                               -- SycVdcId
    GETDATE(),                                      -- RegistrationOn
    dbo.ConvertDateEnglishToNepali(GETDATE()),      -- RegistrationOnBS
    0,                                               -- IntroducedBy
    1,                                               -- SycStatusId
    11,                                              -- SycMemberGroupId
    NULL,                                            -- Remarks
    0,                                               -- CreatedBy
    GETDATE(),                                      -- CreatedOn
    dbo.ConvertDateEnglishToNepali(GETDATE()),      -- CreatedOnBs
    0,                                               -- LastModifiedBy
    NULL,                                            -- LastModifiedOn
    NULL,                                            -- LastModifiedOnBs
    dbo.ConvertDateNepaliToEnglish('2065/01/01'),   -- CitizenShipIssuedOn
    '2065/01/01',                                   -- CitizenShipIssuedOnBs
    '-',                                             -- CitizenShipIssuedDistrict
    NULL,                                            -- ElectricityNo
    NULL,                                            -- WaterSupplyNo
    NULL,                                            -- IMEINo
    (SELECT TOP 1 SycIncomeRangeId FROM SycIncomeRange),  -- SycIncomeRangeId
    (SELECT TOP 1 SycEducationId FROM SycEducation),      -- SycEducationId
    NULL,                                            -- DeviceId
    NULL,                                            -- GPSCoOrdinate
    2,                                               -- SycStateVDCId
    NULL,                                            -- MemberYearlyPaymentTillDateOn
    NULL,                                            -- MemberYearlyPaymentTillDateOnBs
    '',                                              -- NameInNepali
    ''                                               -- AddressInNepali
FROM dbo.members_processed;
GO

use NexGenCoSysDBDev;
select * from MemMemberRegistration; 