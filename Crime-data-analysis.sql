CREATE DATABASE crime_analysis;
USE crime_analysis;

-- Step 2: Create the table
CREATE TABLE crime_data (
    Person_ID VARCHAR(20),
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    Criminal_History VARCHAR(10),
    Case_Number VARCHAR(20),
    Crime_Description TEXT,
    Crime_Type VARCHAR(50),
    IUCR INT,
    FBI_Code INT,
    Domestic VARCHAR(10),
    Arrested VARCHAR(10),
    Crime_Location VARCHAR(100),
    Block VARCHAR(100),
    Beat INT,
    District INT,
    Ward INT,
    Community_Area INT,
    Latitude FLOAT,
    Longitude FLOAT,
    X_Coordinate INT,
    Y_Coordinate INT,
    Date_of_Crime DATE,
    Year INT,
    Updated_On DATE,
    Social_Media_Activity VARCHAR(20),
    Facial_Recognition_Match FLOAT
);

-- Step 3: Data import (adjust for secure-file-priv path if needed)
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/synthetic_crime_dataset(1).csv'
INTO TABLE crime_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Step 4: Basic Queries

-- Crimes per Year
SELECT Year, COUNT(*) AS Total_Crimes
FROM crime_data
GROUP BY Year
ORDER BY Year;

-- Most Common Crime Types
SELECT Crime_Type, COUNT(*) AS Crime_Count
FROM crime_data
GROUP BY Crime_Type
ORDER BY Crime_Count DESC;

-- Arrest Rate by Crime Type
SELECT Crime_Type,
       SUM(CASE WHEN Arrested = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS Arrest_Percentage
FROM crime_data
GROUP BY Crime_Type
ORDER BY Arrest_Percentage DESC;

-- Top 5 Most Dangerous Locations
SELECT Crime_Location, COUNT(*) AS Crime_Count
FROM crime_data
GROUP BY Crime_Location
ORDER BY Crime_Count DESC
LIMIT 5;

-- Social Media Activity & Crime Correlation
SELECT Social_Media_Activity,
       AVG(Facial_Recognition_Match) AS Avg_Match_Percentage,
       COUNT(*) AS Total_Crimes
FROM crime_data
GROUP BY Social_Media_Activity;

-- Repeat Offenders
SELECT Name, COUNT(*) AS Number_of_Crimes
FROM crime_data
WHERE Criminal_History = 'Yes'
GROUP BY Name
HAVING Number_of_Crimes > 1
ORDER BY Number_of_Crimes DESC;

-- Monthly Crime Trend
SELECT MONTH(Date_of_Crime) AS Month, COUNT(*) AS Crime_Count
FROM crime_data
GROUP BY Month
ORDER BY Month;