-- 1.Setup & Data Load 

-- a. Create Database nrsb_accidents and Use Database nrsb_accidents
CREATE DATABASE nrsb_accidents;

USE nrsb_accidents;

-- b. Create the table 'accidents'
CREATE TABLE accidents (
    State_Name VARCHAR(255),
    Year INT,
    Day_of_Week VARCHAR(50),
    Accident_Severity VARCHAR(100),
    Vehicle_Type_Involved VARCHAR(255),
    Number_of_Fatalities INT,
    Road_Type VARCHAR(100),
    Lighting_Conditions VARCHAR(100),
    Speed_Limit_kmh INT,
    Driver_Gender VARCHAR(20),
    Alcohol_Involvement VARCHAR(20),
    City_Name VARCHAR(255),
    Month VARCHAR(20), -- Will be standardized later
    Time_of_Day VARCHAR(50),
    Number_of_Vehicles_Involved INT,
    Number_of_Casualties INT,
    Weather_Conditions VARCHAR(100),
    Road_Condition VARCHAR(100),
    Traffic_Control_Presence VARCHAR(50),
    Driver_Age INT,
    Driver_License_Status VARCHAR(50),
    Accident_Location_Details TEXT
);

-- c. Verification
-- i. Check the total number of rows
SELECT COUNT(*) FROM accidents; -- 3000
-- ii. Check the first 10 rows to see if data looks correct.
SELECT * FROM accidents LIMIT 10;


-- 2.Data Quality & Cleaning 

-- a. Idenitifying null or  missing Values
SELECT 'Fatalities' AS Column_Name, COUNT(*) AS Missing_Count FROM accidents WHERE Number_of_Fatalities IS NULL
UNION ALL
SELECT 'Casualties' AS Column_Name, COUNT(*) AS Missing_Count FROM accidents WHERE Number_of_Casualties IS NULL
UNION ALL
SELECT 'Driver Age' AS Column_Name, COUNT(*) AS Missing_Count FROM accidents WHERE Driver_Age IS NULL
UNION ALL
SELECT 'License Status' AS Column_Name, COUNT(*) AS Missing_Count FROM accidents WHERE Driver_License_Status IS NULL
UNION ALL
SELECT 'Speed Limit' AS Column_Name, COUNT(*) AS Missing_Count FROM accidents WHERE Speed_Limit_kmh IS NULL;

-- SET SQL_SAFE_UPDATES = 0;

-- b. Convert all entries in key columns to title case (e.g., "MAHARASHTRA" to "Maharashtra")
UPDATE accidents SET State_Name = CONCAT(UPPER(SUBSTR(State_Name, 1, 1)), LOWER(SUBSTR(State_Name, 2)));

-- c. Update all city have having unknow to null
UPDATE accidents
SET City_Name = NULL
WHERE TRIM(UPPER(City_Name)) IN ('UNKNOWN', 'NA', 'N/A', '-', '');
-- Checking the updation result
SELECT 
    COALESCE(City_Name, 'NULL (missing)') AS City_Name,
    COUNT(*) AS Count
FROM accidents
GROUP BY City_Name
ORDER BY Count DESC;





    




