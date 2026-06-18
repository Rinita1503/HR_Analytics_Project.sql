# HR Analytics SQL Project

## Project Overview

This project analyzes employee attrition and workforce trends using the IBM HR Analytics dataset. The objective is to identify factors influencing employee turnover and provide actionable business insights through SQL analysis.

## Dataset

Dataset: IBM HR Analytics Employee Attrition Dataset

Key attributes include:

* Employee demographics
* Department information
* Monthly income
* Overtime status
* Job roles
* Promotion history
* Attrition status

## Tools Used

* MySQL
* MySQL Workbench
* SQL

## SQL Concepts Applied

* SELECT Statements
* Aggregate Functions
* GROUP BY
* CASE WHEN
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions
* Ranking Functions

## Business Questions

### 1. Why do employees leave?

Analyzed employee attrition patterns using overtime, salary levels, and promotion history.

### 2. Which departments have high turnover?

Calculated department-level attrition rates to identify areas requiring retention initiatives.

### 3. Does overtime increase attrition?

Compared attrition rates between employees working overtime and those who do not.

### 4. Does salary influence retention?

Grouped employees into salary bands and analyzed turnover patterns.

### 5. Are promotions reducing turnover?

Evaluated the relationship between years since last promotion and employee attrition.

## Key Findings

* Employees working overtime showed higher attrition rates.
* Lower salary groups experienced higher turnover.
* Certain departments demonstrated significantly higher attrition rates.
* Employees with long periods without promotion were more likely to leave.

## Example SQL Techniques

### Correlated Subquery

```sql
SELECT *
FROM employee_attrition_clean e
WHERE MonthlyIncome >
(
    SELECT AVG(MonthlyIncome)
    FROM employee_attrition_clean
    WHERE Department = e.Department
);
```

### Window Function

```sql
SELECT
    EmployeeNumber,
    Department,
    MonthlyIncome,
    RANK() OVER(
        PARTITION BY Department
        ORDER BY MonthlyIncome DESC
    ) AS Salary_Rank
FROM employee_attrition_clean;
```

## Repository Structure

```text
Dataset/
SQL/
README.md
```

Data Analytics Portfolio Project focusing on HR Analytics and SQL-based business insights.
