USE BB1;
GO


-- Financial & Billing Dashboard


-- Total Billing Amount by Gender
SELECT [Sex], SUM([Billing Amount]) AS TotalBilling
FROM [dbo].['Copy of bb2$']
GROUP BY [Sex];
GO

-- Average Billing Amount by Admission Type
SELECT [Admission Type], AVG([Billing Amount]) AS AvgBilling
FROM [dbo].['Copy of bb2$']
GROUP BY [Admission Type];
GO

-- Overall Average Billing Amount
SELECT AVG([Billing Amount]) AS OverallAvgBilling
FROM [dbo].['Copy of bb2$']
GO

-- Total Billing Amount by Month
SELECT FORMAT([Date of Admission], 'yyyy-MM') AS MonthYear,
       SUM([Billing Amount]) AS TotalBilling
FROM [dbo].['Copy of bb2$']
GROUP BY FORMAT([Date of Admission], 'yyyy-MM')
ORDER BY MonthYear;
GO

-- Total Billing Amount by Hospital (Top 15)
SELECT TOP 15 [Hospital], SUM([Billing Amount]) AS TotalBilling
FROM [dbo].['Copy of bb2$']
GROUP BY [Hospital]
ORDER BY TotalBilling DESC;
GO

-- Total Billing Amount by State (Top 15)
SELECT TOP 15 [State], SUM([Billing Amount]) AS TotalBilling
FROM [dbo].['Copy of bb2$']
GROUP BY [State]
ORDER BY TotalBilling DESC;
GO

-- Billing Amount by Month & Admission Type
SELECT FORMAT([Date of Admission], 'yyyy-MM') AS MonthYear,
       [Admission Type],
       SUM([Billing Amount]) AS TotalBilling
FROM [dbo].['Copy of bb2$']
GROUP BY FORMAT([Date of Admission], 'yyyy-MM'), [Admission Type]
ORDER BY MonthYear, [Admission Type];
GO

-- Total Revenue (All-Time)
SELECT SUM([Billing Amount]) AS TotalRevenue
FROM [dbo].['Copy of bb2$']
GO

-- Number of Unique States in Operation
SELECT COUNT(DISTINCT [State]) AS NumStates
FROM [dbo].['Copy of bb2$']
GO

-- Rational & Efficiency Dashboard

-- Count of Patients by Year
SELECT YEAR([Date of Admission]) AS YearAdmitted,
       COUNT([PatientID]) AS NumPatients
FROM [dbo].['Copy of bb2$']
GROUP BY YEAR([Date of Admission])
ORDER BY YearAdmitted;
GO

-- Relation Between Length of Stay & Admission Type
SELECT [Admission Type], AVG([Length of Stay]) AS AvgLengthOfStay
FROM [dbo].['Copy of bb2$']
GROUP BY [Admission Type];
GO

-- Average Length of Stay by Age Category
SELECT [AgeCategory], AVG([Length of Stay]) AS AvgLengthOfStay
FROM [dbo].['Copy of bb2$']
GROUP BY [AgeCategory];
GO

-- High Risk Patients
SELECT COUNT([PatientID]) AS HighRiskPatients
FROM [dbo].['Copy of bb2$']
WHERE [HighRiskLastYear] = 1;
GO

-- Average Revenue per Day
SELECT AVG([Billing Amount]/[Length of Stay]) AS AvgRevenuePerDay
FROM [dbo].['Copy of bb2$']
WHERE [Length of Stay] > 0;
GO

-- Emergency Admission Rate
SELECT [Admission Type],
       COUNT([PatientID])*100.0 / (SELECT COUNT(*) FROM [dbo].[Copy of bb2$]) AS Percentage
FROM [dbo].['Copy of bb2$']
GROUP BY [Admission Type];
GO

-- Total Admissions
SELECT COUNT([PatientID]) AS TotalAdmissions
FROM [dbo].['Copy of bb2$']
GO

-- Emergency Admissions
SELECT COUNT([PatientID]) AS EmergencyAdmissions
FROM [dbo].['Copy of bb2$']
WHERE [Admission Type] = 'Emergency';
GO

-- AVG Length of Stay
SELECT AVG([Length of Stay]) AS AvgLengthOfStay
FROM [dbo].['Copy of bb2$']
GO

-- Count of Hospital by State
SELECT [State], COUNT(DISTINCT [Hospital]) AS NumHospitals
FROM [dbo].['Copy of bb2$']
GROUP BY [State];
GO

-- Length of Stay by BMI Category and Admission Type
SELECT [BMI_Category], [Admission Type], AVG([Length of Stay]) AS AvgLengthOfStay
FROM [dbo].['Copy of bb2$']
GROUP BY [BMI_Category], [Admission Type];
GO

-- Clinical & Population Health Dashboard

-- Number of Infected People for Each Disease
SELECT 
    SUM([HadArthritis]) AS Arthritis,
    SUM([HadDepressiveDisorder]) AS DepressiveDisorder,
    SUM([HadAsthma]) AS Asthma,
    SUM([HadSkinCancer]) AS SkinCancer,
    SUM([HadCOPD]) AS COPD,
    SUM([HadAngina]) AS Angina,
    SUM([HadHeartAttack]) AS HeartAttack,
    SUM([HadKidneyDisease]) AS KidneyDisease,
    SUM([HadStroke]) AS Stroke
FROM [dbo].['Copy of bb2$']
GO

-- Number of Disabled People
SELECT 
    SUM([DifficultyWalking]) AS DifficultyWalking,
    SUM([DifficultyConcentrating]) AS DifficultyConcentrating,
    SUM([DeafOrHardOfHearing]) AS DeafOrHardOfHearing,
    SUM([DifficultyErrands]) AS DifficultyErrands,
    SUM([BlindOrVisionDifficulty]) AS BlindOrVisionDifficulty,
    SUM([DifficultyDressingBathing]) AS DifficultyDressingBathing
FROM [dbo].['Copy of bb2$']
GO

-- Number of People Who Received Vaccines
SELECT 
    SUM([FluVaxLast12]) AS FluVaccine,
    SUM([PneumoVaxEver]) AS PneumoVaccine,
    SUM([HIVTesting]) AS HIVTested,
    SUM([CovidPos]) AS CovidPositive
FROM [dbo].['Copy of bb2$']
GO

-- General Health by ECigarette Usage
SELECT [ECigaretteUsage], [GeneralHealth], COUNT([PatientID]) AS NumPatients
FROM [dbo].['Copy of bb2$']
GROUP BY [ECigaretteUsage], [GeneralHealth]
ORDER BY [ECigaretteUsage], [GeneralHealth];
GO

-- General Health by Smoker Status
SELECT [SmokerStatus], [GeneralHealth], COUNT([PatientID]) AS NumPatients
FROM [dbo].['Copy of bb2$']
GROUP BY [SmokerStatus], [GeneralHealth]
ORDER BY [SmokerStatus], [GeneralHealth];
GO

-- Count of Patients by HadDiabetes
SELECT [HadDiabetes], COUNT([PatientID]) AS NumPatients
FROM [dbo].['Copy of bb2$']
GROUP BY [HadDiabetes];
GO

-- Average BMI by General Health
SELECT [GeneralHealth], AVG([BMI]) AS AvgBMI
FROM [dbo].['Copy of bb2$']
GROUP BY [GeneralHealth];
GO

-- Alcohol Drinkers by General Health
SELECT [GeneralHealth], [AlcoholDrinkers], COUNT([PatientID]) AS NumPatients
FROM [dbo].['Copy of bb2$']
GROUP BY [GeneralHealth], [AlcoholDrinkers]
ORDER BY [GeneralHealth], [AlcoholDrinkers];
GO

-- Count of Patients by Tetanus Vaccination
SELECT [TetanusLast10Tdap], COUNT([PatientID]) AS NumPatients
FROM [dbo].['Copy of bb2$']
GROUP BY [TetanusLast10Tdap];
GO

-- Advanced Queries

-- Top 10 Hospitals by Average Billing per Patient
SELECT TOP 10 [Hospital],
       COUNT([PatientID]) AS NumPatients,
       SUM([Billing Amount]) AS TotalBilling,
       AVG([Billing Amount]) AS AvgBillingPerPatient
FROM [dbo].['Copy of bb2$']
GROUP BY [Hospital]
ORDER BY AvgBillingPerPatient DESC;
GO

-- Monthly Revenue Growth Rate
WITH MonthlyRevenue AS (
    SELECT FORMAT([Date of Admission],'yyyy-MM') AS MonthYear,
           SUM([Billing Amount]) AS TotalBilling
    FROM [dbo].['Copy of bb2$']
    GROUP BY FORMAT([Date of Admission],'yyyy-MM')
)
SELECT MonthYear,
       TotalBilling,
       LAG(TotalBilling) OVER(ORDER BY MonthYear) AS PreviousMonthRevenue,
       CASE 
           WHEN LAG(TotalBilling) OVER(ORDER BY MonthYear) IS NULL THEN NULL
           ELSE (TotalBilling - LAG(TotalBilling) OVER(ORDER BY MonthYear)) 
                / LAG(TotalBilling) OVER(ORDER BY MonthYear) * 100
       END AS GrowthPercent
FROM MonthlyRevenue
ORDER BY MonthYear;
GO

-- Average Length of Stay by BMI Category and High Risk Status
SELECT [BMI_Category],
       [HighRiskLastYear],
       AVG([Length of Stay]) AS AvgLengthOfStay,
       COUNT([PatientID]) AS NumPatients
FROM [dbo].['Copy of bb2$']
GROUP BY [BMI_Category], [HighRiskLastYear]
ORDER BY [BMI_Category], [HighRiskLastYear];
GO

-- Top 5 States with Most Chronic Diseases
SELECT [State],
       SUM([Chronic_Count]) AS TotalChronicDiseases,
       AVG([Chronic_Count]) AS AvgChronicPerPatient
FROM [dbo].['Copy of bb2$']
GROUP BY [State]
ORDER BY TotalChronicDiseases DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;
GO

-- Patient Risk Score (Composite Index)
SELECT [PatientID],
       [State],
       [Hospital],
       [BMI],
       [Chronic_Count],
       [HighRiskLastYear],
       ([Chronic_Count] + [HighRiskLastYear] + CASE WHEN [BMI] >= 30 THEN 1 ELSE 0 END) AS RiskScore
FROM [dbo].['Copy of bb2$']
ORDER BY RiskScore DESC
OFFSET 0 ROWS FETCH NEXT 20 ROWS ONLY;
GO

-- Revenue Contribution by Age Category and Admission Type
SELECT [AgeCategory],
       [Admission Type],
       SUM([Billing Amount]) AS TotalRevenue,
       SUM([Billing Amount])*100.0 / SUM(SUM([Billing Amount])) OVER() AS RevenuePercent
FROM [dbo].['Copy of bb2$']
GROUP BY [AgeCategory], [Admission Type]
ORDER BY TotalRevenue DESC;
GO

-- Correlation Between BMI and Length of Stay
SELECT [BMI_Category],
       AVG([BMI]) AS AvgBMI,
       AVG([Length of Stay]) AS AvgLengthOfStay,
       COUNT([PatientID]) AS NumPatients
FROM [dbo].['Copy of bb2$']
GROUP BY [BMI_Category]
ORDER BY AvgBMI;
GO
