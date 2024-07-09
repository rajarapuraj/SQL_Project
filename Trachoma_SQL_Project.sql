# Create a database to complete the project with correct naming convention.
USE trachoma_population_risk;

# DATA INGESTION
-- Import a dataset to the SQL environment for data cleaning. Make sure all the columns are short named to ease SQL queries.

SELECT *
FROM   trachoma_data;

# DATA CLEANING
-- 1. Remove duplicates
-- 2. Standardize the data
-- 3. Null values or blank values
-- 4. Remove any empty or unwanted columns

/* NOTE: Staging Area: Create a copy of our raw data where we can perform all SQL commands*/

CREATE TABLE trachoma_data_staging
LIKE trachoma_data;

SELECT *
FROM   trachoma_data_staging;

INSERT trachoma_data_staging
SELECT *
FROM   trachoma_data; 

SELECT *
FROM   trachoma_data_staging;

-- Now a copy of our raw data is ready as trachoma_data_staging table for our project.

# 1. Remove duplicates
-- Assign a row number and filter using Common Table Expressions (CTEs) to identify duplicates.
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY Country, `Code`, `Year`, Trachoma_Risk, Antibiotics_Treatment, Operated) AS Row_Num
FROM   trachoma_data_staging;

WITH Duplicates_CTE AS
(
SELECT * ,
ROW_NUMBER() OVER(
PARTITION BY Country, `Code`, `Year`, Trachoma_Risk, Antibiotics_Treatment, Operated) AS Row_Num
FROM   trachoma_data_staging
)
SELECT *
FROM   Duplicates_CTE
WHERE  Row_Num > 1;

-- No duplicates found in the data.

SELECT *
FROM   trachoma_data_staging;

# 2. Standardizing data
-- Removing of any leading and trailing whitespace.

UPDATE trachoma_data_staging
SET 
	Country = TRIM(Country),
    `Code` = TRIM(`Code`),
    `Year` = TRIM(`Year`),
    Trachoma_Risk = TRIM(Trachoma_Risk),
    Antibiotics_Treatment = TRIM(Antibiotics_Treatment),
    Operated = TRIM(Operated);

-- Identifying and handling missing values column wise.
SELECT *
FROM   trachoma_data_staging
WHERE  Country = '';

SELECT *
FROM   trachoma_data_staging
WHERE  `Code` = '';

UPDATE trachoma_data_staging
SET `Code` = CASE 
    WHEN Country = 'Africa' THEN 'AF'
    WHEN Country = 'Asia' THEN 'AS'
    WHEN Country = 'Oceania' THEN 'OC'
    WHEN Country = 'North America' THEN 'NA'
    WHEN Country = 'South America' THEN 'SA'
    ELSE `Code`
END
WHERE Country IN ('Africa', 'Asia', 'Oceania', 'North America', 'South America');

SELECT *
FROM   trachoma_data_staging
WHERE  `Year` = '';

SELECT *
FROM   trachoma_data_staging
WHERE  Trachoma_Risk = '';

SELECT *
FROM   trachoma_data_staging
WHERE  Antibiotics_Treatment = '';

UPDATE trachoma_data_staging
SET    Antibiotics_Treatment = 0
WHERE  Antibiotics_Treatment = '';

SELECT *
FROM   trachoma_data_staging
WHERE  Operated = '';

UPDATE trachoma_data_staging
SET    Operated = 0
WHERE  Operated = '';

SELECT *
FROM   trachoma_data_staging;

# Exploratory Data Analysis

-- Number of population are at risk to trachoma within year wise and within country wise.
SELECT   `Year`, SUM(Trachoma_Risk) AS Total_Trachoma_Risk
FROM     trachoma_data_staging
GROUP BY `Year`
ORDER BY `Year` ASC;

SELECT   Country, `Year`, SUM(Trachoma_Risk) AS Total_Trachoma_Risk
FROM     trachoma_data_staging
GROUP BY Country, `Year`
ORDER BY Country ASC, `Year` ASC;

-- Number of population are treated with antibiotics for trachoma within country and year wise.
SELECT   `Year`, SUM(Antibiotics_Treatment) AS Total_Antibiotics_Treatment
FROM     trachoma_data_staging
GROUP BY `Year`
ORDER BY `Year` ASC;

SELECT   Country, `Year`, SUM(Antibiotics_Treatment) AS Total_Antibiotics_Treatment
FROM     trachoma_data_staging
GROUP BY Country, `Year`
ORDER BY Country ASC, `Year` ASC;

-- Number of population are get operated for trachoma disease within country and year wise.
SELECT   `Year`, SUM(Operated) AS Total_Operated
FROM     trachoma_data_staging
GROUP BY `Year`
ORDER BY `Year` ASC;

SELECT   Country, `Year`, SUM(Operated) AS Total_Operated
FROM     trachoma_data_staging
GROUP BY Country, `Year`
ORDER BY Country ASC, `Year` ASC;

SELECT 
  AVG(Trachoma_Risk) AS Avg_Trachoma_Risk,
  MIN(Trachoma_Risk) AS Min_Trachoma_Risk,
  MAX(Trachoma_Risk) AS Max_Trachoma_Risk,
  STDDEV(Trachoma_Risk) AS Stddev_Trachoma_Risk
FROM trachoma_data_staging;

SELECT
  AVG(Antibiotics_Treatment) AS Avg_Antibiotics_Treatment,
  MIN(Antibiotics_Treatment) AS Min_Antibiotics_Treatment,
  MAX(Antibiotics_Treatment) AS Max_Antibiotics_Treatment,
  STDDEV(Antibiotics_Treatment) AS Stddev_Antibiotics_Treatment
FROM trachoma_data_staging;
  
SELECT
  AVG(Operated) AS Avg_Operated,
  MIN(Operated) AS Min_Operated,
  MAX(Operated) AS Max_Operated,
  STDDEV(Operated) AS Stddev_Operated
FROM trachoma_data_staging;















