# Population at Risk For Trachoma

## Table of Contents
- [Project Overview](#project-overview)
- [Tools](#tools)
- [Data Sources](#data-sources)
- [Data Cleaning/Preparation](#data-cleaningpreparation)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Data Analysis using SQL](#data-analysis-using-sql)
- [Results/Findings](#resultsfindings)
- [Recommendations](#recommendations)

### Project Overview

Neglected Tropical Diseases (NTDs) are a group of infectious diseases causing severe health problems like anemia, blindness, chronic pain, infertility, and disfigurement, predominantly affecting millions in tropical regions such as Africa, Asia, and South and North America. NTDs trap many victims in poverty due to their inability to work and the severe social stigma they face. Despite the existence of affordable interventions and promising new technologies, NTDs remain underfunded and insufficiently addressed in global research and development. Trachoma is one of all the NTDs.

Trachoma is a major contagious eye disease caused by the Bacterium Chlamydia trachomatis that can lead to blindness. It's a public health issue in more than 40 countries and is responsible for 1.9 million cases of blindness or visual impairment.

This SQL-based project aims to compile and analyze sample of global data on trachoma disease to understand population's risk, impact, and trends year-wise within a country.

### Tools

- MYSQL Server - Data manipulation and Analysis
  - [Download tool here](https://dev.mysql.com/downloads/installer/)
  
### Data Sources

I have collected a dataset from [Our World in Data](https://ourworldindata.org/grapher/number-treated-for-trachoma). 

Note: After downloading, open the file and change the column names into a short name according to the data and MYSQL naming convention to make SQL coding short to write and easy to understand. 

Population at Risk for Trachoma: The primary dataset used for this project is the [dataset_file](https://github.com/rajarapuraj/SQL_Project/blob/main/population-at-risk-of-trachoma-vs-receiving-treatment.csv), containing year wise population count within a specific country/continent that is collected by the World Health Organization - Global Health Observatory (2024). 

Then, I've created a schema or database on MYSQL server to perform EDA on the data. Now, let's do some manipulation on data to manage null values, and finally performing some basic analysis on the dataset to answer key questions about the trachoma population and to take necessary action further.

### Data Cleaning/Preparation

In the initial data prepation phase, I've performed the following tasks:

  A. Removing of duplicates
	B. Standardizing the data
	C. Managing Null values or blank values
	D. Removing empty or unwanted columns	

Please [click here](https://github.com/rajarapuraj/SQL_Project/blob/main/Trachoma_SQL_Project.sql) for detail SQL codes performed on the dataset.

### Exploratory Data Analysis

EDA involved exploring the trachoma population data to answer key questions, such as:

1. Number of population are at risk to trachoma year wise within a country?
2. Number of population are treated with antibiotics for trachoma year wise within a country?
3. Number of population are get operated for trachoma disease year wise within a country?
4. What is the average population at risk for trachoma?
5. What is the average population treated for trachoma?
6. What is the average population operated for trachoma?

### Data Analysis using SQL

Here I'm including one of all the interesting codes/features worked with

```sql
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

```

### Results/Findings

The analysis results are summarized as follows:

1. A total of 12 employee's working in the organization.
2. Female employee's are more than male employee's.
3. The employee's within *Department* are high salaried.
4. Within the organization, Steven Jhonson from *department* is high salaried employee.

### Recommendations

Based on the analysis, I recommend the following actions:
- Reaffirm the organization's commitment to fostering a diverse and inclusive workplace by promoting gender diversity in recruitment.
- Review and implement a fair pay structure to ensure equitable compensation across all departments.





  
  
   
