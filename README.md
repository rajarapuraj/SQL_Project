# Population at Risk For Trachoma_SQL Project

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

Population at Risk for Trachoma: The primary dataset used for this project is the [dataset_file](https://github.com/rajarapuraj/SQL_Project/blob/main/population-at-risk-of-trachoma-vs-receiving-treatment.csv), containing year wise population count within a specific country/continent that is collected by the World Health Organization - Global Health Observatory (2024). 

I have collected a dataset from [Our World in Data](https://ourworldindata.org/grapher/number-treated-for-trachoma). 

Note: After downloading, open the file and change the column names into a short name according to the data and MYSQL naming convention to make SQL coding short to write and easy to understand. 

Then, I've created a schema or database on MYSQL server to perform EDA on the data. Now, let's do some manipulation on data to manage null values, and finally performing some basic analysis on the dataset to answer key questions about the trachoma population and to take necessary action further.

### Data Cleaning/Preparation

In the initial data prepation phase, I've performed the following tasks:

1. Data ingestion
2. Handling missing values
3. Data cleaning and formatting

Please [click here](https://github.com/rajarapuraj/SQL_Project/blob/main/Trachoma_SQL_Project.sql) for detail SQL codes performed on the dataset.

### Exploratory Data Analysis

EDA involved exploring the employee's salary data to answer key questions, such as:

- How many employee's are there in each department?
- How many male and female employee's are there in the organization?
- What is the total amount given as a salary within each department?
- Which department employee's are high salaried?
- Which department employee is high salaried? 

### Data Analysis using SQL

Here I'm including some interesting codes/features worked with

```sql
SELECT     Department_ID, SUM(Salary) as Total_Amount
FROM       Employee_Salary
GROUP BY   Dept_ID;
```

### Results/Findings

The analysis results are summarized as follows:

1. A total of 12 employee's working in the organization.
2. Female employee's are more than male employee's.
3. The employee's within *Department* are high salaried.
4. Within the organization, Steven Jhonson from *department* is high salaried employee.

### Recommendations

Based on the analysis, we recommend the following actions:
- Reaffirm the organization's commitment to fostering a diverse and inclusive workplace by promoting gender diversity in recruitment.
- Review and implement a fair pay structure to ensure equitable compensation across all departments.





  
  
   
