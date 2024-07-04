# SQL_Project

### Project Overview

Creating a schema to maintain employee details department wise for an amusement park. I'll be creating tables within the schema, insert data, do some manipulation to manage null values, and finally performing some basic analysis on the dataset to answer key questions of the organization for their business growth.

### Data Sources

Employee Data: The primary dataset used for this project is the "Employee_Data.sql" file, containing detailed information about their demogrpahics and salary given by the company to each employee within the department.

### Tools

- MYSQL Server - Data manipulation and Analysis
  - [Download tool here](https://dev.mysql.com/downloads/installer/)

### Data Cleaning/Preparation

In the initial data prepation phase, I've performed the following tasks:

1. Data loading and inspection
2. Handling missing values
3. Data cleaning and formatting

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





  
  
   
