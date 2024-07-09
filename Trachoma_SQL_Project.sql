# Steps to follow...

1. Create a database with correct naming convention
2. Data Ingestion
3. Data Cleaning
4. Exploratory Data Analysis

Let's code...

1. CREATE A DATABASE WITH CORRECT NAMING CONVENTION
-- trachoma_population_risk is the database or schema that I've created as a first step.
-- Below is the code to make sure that we are connected to a correct database if we have multiple databases in the SQL. 

	USE trachoma_population_risk;

2. DATA INGESTION
-- Import a dataset to the SQL environment for data cleaning. Make sure all the columns are short named before ingestion to ease SQL queries.
-- trachoma_data is the table name that I've given while importing.

	SELECT *
	FROM   trachoma_data;
-- Now, I have all the data as a Table with all the columns of the dataset in the SQL environment.

3. DATA CLEANING

/* NOTE: Staging Area: Create a copy of our raw data where we can perform all SQL commands*/

	CREATE TABLE trachoma_data_staging
	LIKE         trachoma_data;
	
	SELECT *
	FROM   trachoma_data_staging;
	
	INSERT trachoma_data_staging
	SELECT *
	FROM   trachoma_data; 
	
	SELECT *
	FROM   trachoma_data_staging;

Now, it's time to clean the copy of our raw data that is ready as trachoma_data_staging table for the project.

	A. Remove duplicates
	B. Standardize the data
	C. Null values or blank values
	D. Remove any empty or unwanted columns	

A. Remove duplicates
-- Assign a row number and filter using Common Table Expressions (CTEs) to identify duplicates.
        
'''     SELECT * ,
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
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
B. Standardize the data
-- Removing of any leading and trailing whitespace.

	UPDATE trachoma_data_staging
	SET 
	     Country = TRIM(Country),
	    `Code` = TRIM(`Code`),
	    `Year` = TRIM(`Year`),
	    Trachoma_Risk = TRIM(Trachoma_Risk),
	    Antibiotics_Treatment = TRIM(Antibiotics_Treatment),
	    Operated = TRIM(Operated);
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
C. Null values or blank values
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
-------------------------------------------------------------------------------------------------------------------------------------------------------------------

D. Remove any empty or unwanted columns	
-- With all the above steps and codes, now I've the data to its fullest to perform analysis. The attributes that I've in the dataset are Country, Code, Year, Trachoma_Risk, Antibitics_Treatment, Operated.
-- So, except code, almost all the columns in the dataset are useful for the analysis, so no deletion required.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
4. EXPLORATORY DATA ANALYSIS

-- Number of population are at risk to trachoma year wise within a country?
	SELECT   `Year`, SUM(Trachoma_Risk) AS Total_Trachoma_Risk
	FROM     trachoma_data_staging
	GROUP BY `Year`
	ORDER BY `Year` ASC;
	
	SELECT   Country, `Year`, SUM(Trachoma_Risk) AS Total_Trachoma_Risk
	FROM     trachoma_data_staging
	GROUP BY Country, `Year`
	ORDER BY Country ASC, `Year` ASC;

-- Number of population are treated with antibiotics for trachoma year wise within a country?
	SELECT   `Year`, SUM(Antibiotics_Treatment) AS Total_Antibiotics_Treatment
	FROM     trachoma_data_staging
	GROUP BY `Year`
	ORDER BY `Year` ASC;
	
	SELECT   Country, `Year`, SUM(Antibiotics_Treatment) AS Total_Antibiotics_Treatment
	FROM     trachoma_data_staging
	GROUP BY Country, `Year`
	ORDER BY Country ASC, `Year` ASC;

-- Number of population are get operated for trachoma disease year wise within a country?
	SELECT   `Year`, SUM(Operated) AS Total_Operated
	FROM     trachoma_data_staging
	GROUP BY `Year`
	ORDER BY `Year` ASC;
	
	SELECT   Country, `Year`, SUM(Operated) AS Total_Operated
	FROM     trachoma_data_staging
	GROUP BY Country, `Year`
	ORDER BY Country ASC, `Year` ASC;

-- What is the avg, min, max, stddev of population at risk for trachoma?
	SELECT 
	  AVG(Trachoma_Risk) AS Avg_Trachoma_Risk,
	  MIN(Trachoma_Risk) AS Min_Trachoma_Risk,
	  MAX(Trachoma_Risk) AS Max_Trachoma_Risk,
	  STDDEV(Trachoma_Risk) AS Stddev_Trachoma_Risk
	FROM trachoma_data_staging;

-- What is the avg, min, max, stddev of population treated for trachoma?
	SELECT
	  AVG(Antibiotics_Treatment) AS Avg_Antibiotics_Treatment,
	  MIN(Antibiotics_Treatment) AS Min_Antibiotics_Treatment,
	  MAX(Antibiotics_Treatment) AS Max_Antibiotics_Treatment,
	  STDDEV(Antibiotics_Treatment) AS Stddev_Antibiotics_Treatment
	FROM trachoma_data_staging;

-- What is the avg, min, max, stddev of population operated for trachoma?
	SELECT
	  AVG(Operated) AS Avg_Operated,
	  MIN(Operated) AS Min_Operated,
	  MAX(Operated) AS Max_Operated,
	  STDDEV(Operated) AS Stddev_Operated
	FROM trachoma_data_staging;















