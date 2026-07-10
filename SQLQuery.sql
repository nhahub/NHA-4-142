-- 1. Create Dimension Tables with SCD & Metadata (No Surrogate Keys)

CREATE TABLE DimGender (
    GenderID INT NOT NULL,                     -- Business Key acting as Primary Key
    Gender VARCHAR(50) NOT NULL,
    -- Metadata
    Source_System_Code TINYINT NOT NULL DEFAULT (1),
    -- SCD
    Start_Date DATETIME NOT NULL DEFAULT (GETDATE()),
    End_Date DATETIME,
    Is_Current TINYINT NOT NULL DEFAULT (1),
    CONSTRAINT pk_dim_gender PRIMARY KEY CLUSTERED (GenderID)
);

CREATE TABLE DimLocation (
    CountryId INT NOT NULL,                    -- Business Key acting as Primary Key
    Country VARCHAR(100) NOT NULL,
    -- Metadata
    Source_System_Code TINYINT NOT NULL DEFAULT (1),
    -- SCD
    Start_Date DATETIME NOT NULL DEFAULT (GETDATE()),
    End_Date DATETIME,
    Is_Current TINYINT NOT NULL DEFAULT (1),
    CONSTRAINT pk_dim_location PRIMARY KEY CLUSTERED (CountryId)
);

CREATE TABLE DimOccupation (
    OccupationId INT NOT NULL,                  -- Business Key acting as Primary Key
    Occupation VARCHAR(100) NOT NULL,
    -- Metadata
    Source_System_Code TINYINT NOT NULL DEFAULT (1),
    -- SCD
    Start_Date DATETIME NOT NULL DEFAULT (GETDATE()),
    End_Date DATETIME,
    Is_Current TINYINT NOT NULL DEFAULT (1),
    CONSTRAINT pk_dim_occupation PRIMARY KEY CLUSTERED (OccupationId)
);

CREATE TABLE DimSmoking (
    Smoking_HabitID INT NOT NULL,               -- Business Key acting as Primary Key
    Smoking_Habit VARCHAR(100) NOT NULL,
    -- Metadata
    Source_System_Code TINYINT NOT NULL DEFAULT (1),
    -- SCD
    Start_Date DATETIME NOT NULL DEFAULT (GETDATE()),
    End_Date DATETIME,
    Is_Current TINYINT NOT NULL DEFAULT (1),
    CONSTRAINT pk_dim_smoking PRIMARY KEY CLUSTERED (Smoking_HabitID)
);

CREATE TABLE DimAlcohol (
    Alcohol_ConsumptionID INT NOT NULL,         -- Business Key acting as Primary Key
    Alcohol_Consumption VARCHAR(100) NOT NULL,
    -- Metadata
    Source_System_Code TINYINT NOT NULL DEFAULT (1),
    -- SCD
    Start_Date DATETIME NOT NULL DEFAULT (GETDATE()),
    End_Date DATETIME,
    Is_Current TINYINT NOT NULL DEFAULT (1),
    CONSTRAINT pk_dim_alcohol PRIMARY KEY CLUSTERED (Alcohol_ConsumptionID)
);

CREATE TABLE DimDietQuality (
    DietQualityID INT NOT NULL,                 -- Business Key acting as Primary Key
    Diet_Quality VARCHAR(100) NOT NULL,
    -- Metadata
    Source_System_Code TINYINT NOT NULL DEFAULT (1),
    -- SCD
    Start_Date DATETIME NOT NULL DEFAULT (GETDATE()),
    End_Date DATETIME,
    Is_Current TINYINT NOT NULL DEFAULT (1),
    CONSTRAINT pk_dim_dietquality PRIMARY KEY CLUSTERED (DietQualityID)
);

CREATE TABLE DimStress (
    StressLevelID INT NOT NULL,                 -- Business Key acting as Primary Key
    Stress_Level VARCHAR(50) NOT NULL,
    -- Metadata
    Source_System_Code TINYINT NOT NULL DEFAULT (1),
    -- SCD
    Start_Date DATETIME NOT NULL DEFAULT (GETDATE()),
    End_Date DATETIME,
    Is_Current TINYINT NOT NULL DEFAULT (1),
    CONSTRAINT pk_dim_stress PRIMARY KEY CLUSTERED (StressLevelID)
);

CREATE TABLE DimSeverity (
    SeverityId INT NOT NULL,                    -- Business Key acting as Primary Key
    Severity VARCHAR(50) NOT NULL,
    -- Metadata
    Source_System_Code TINYINT NOT NULL DEFAULT (1),
    -- SCD
    Start_Date DATETIME NOT NULL DEFAULT (GETDATE()),
    End_Date DATETIME,
    Is_Current TINYINT NOT NULL DEFAULT (1),
    CONSTRAINT pk_dim_severity PRIMARY KEY CLUSTERED (SeverityId)
);

CREATE TABLE DimMedicalStatus (
    MedicalStatusId INT NOT NULL,               -- Business Key acting as Primary Key
    Mental_Health_Condition VARCHAR(10) NOT NULL,
    Consultation_History VARCHAR(10) NOT NULL,
    Medication_Usage VARCHAR(10) NOT NULL,
    -- Metadata
    Source_System_Code TINYINT NOT NULL DEFAULT (1),
    -- SCD
    Start_Date DATETIME NOT NULL DEFAULT (GETDATE()),
    End_Date DATETIME,
    Is_Current TINYINT NOT NULL DEFAULT (1),
    CONSTRAINT pk_dim_medicalstatus PRIMARY KEY CLUSTERED (MedicalStatusId)
);

---
-- 2. Create Fact Table (FactMental) linked directly to Business Keys

CREATE TABLE FactMental (
    Fact_ID INT IDENTITY(1, 1) NOT NULL,
    User_ID INT NOT NULL, 
    
    -- Foreign Keys pointing directly to Business IDs
    GenderId INT NOT NULL,
    CountryId INT NOT NULL,
    OccupationId INT NOT NULL,
    Smoking_HabitID INT NOT NULL,
    Alcohol_ConsumptionID INT NOT NULL,
    DietQualityID INT NOT NULL,
    StressLevelID INT NOT NULL,
    SeverityId INT NOT NULL,
    MedicalStatusId INT NOT NULL,
    
    -- Measures (Numerical Data)
    Age INT,
    Sleep_Hours DECIMAL(4,2),
    Work_Hours INT,
    Physical_Activity_Hours INT,
    Social_Media_Usage DECIMAL(4,2),
    
    CONSTRAINT pk_fact_mental PRIMARY KEY CLUSTERED (Fact_ID),
    
    -- Setting up Foreign Key Relationships
    FOREIGN KEY (GenderId) REFERENCES DimGender(GenderID),
    FOREIGN KEY (CountryId) REFERENCES DimLocation(CountryId),
    FOREIGN KEY (OccupationId) REFERENCES DimOccupation(OccupationId),
    FOREIGN KEY (Smoking_HabitID) REFERENCES DimSmoking(Smoking_HabitID),
    FOREIGN KEY (Alcohol_ConsumptionID) REFERENCES DimAlcohol(Alcohol_ConsumptionID),
    FOREIGN KEY (DietQualityID) REFERENCES DimDietQuality(DietQualityID),
    FOREIGN KEY (StressLevelID) REFERENCES DimStress(StressLevelID),
    FOREIGN KEY (SeverityId) REFERENCES DimSeverity(SeverityId),
    FOREIGN KEY (MedicalStatusId) REFERENCES DimMedicalStatus(MedicalStatusId)
);