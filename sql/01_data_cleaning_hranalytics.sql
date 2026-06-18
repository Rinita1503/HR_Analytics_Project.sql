use hr_analytics;
SELECT 
    *
FROM
    employee_attrition;


-- count total rows
SELECT 
    COUNT(*) AS total_records
FROM
    employee_attrition;
SELECT 
    *
FROM
    employee_attrition
LIMIT 10;


describe employee_attrition;
set sql_safe_updates = 0;


-- text formatting
-- skipping double blank spaces or leading or trailing
UPDATE employee_attrition 
SET 
    department = TRIM(department),
    JobRole = TRIM(JobRole),
    Gender = TRIM(Gender),
    Attrition = TRIM(Attrition);


-- check missing values
SELECT 
    SUM(CASE
        WHEN Age IS NULL THEN 1
        ELSE 0
    END) AS missing_age,
    SUM(CASE
        WHEN Department IS NULL THEN 1
        ELSE 0
    END) AS missing_department,
    SUM(CASE
        WHEN JobRole IS NULL THEN 1
        ELSE 0
    END) AS missing_jobrole,
    SUM(CASE
        WHEN MonthlyIncome IS NULL THEN 1
        ELSE 0
    END) AS missing_income,
    SUM(CASE
        WHEN Attrition IS NULL THEN 1
        ELSE 0
    END) AS missing_attrition
FROM
    employee_attrition;


-- remove duplicates
CREATE TABLE employee_attrition_clean AS
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Age, Department, JobRole, MonthlyIncome, Attrition, Gender
               ORDER BY Age
           ) AS rn
    FROM employee_attrition
) t
WHERE rn = 1;

-- fix case consistency
UPDATE employee_attrition_clean 
SET 
    Department = UPPER(Department),
    JobRole = UPPER(JobRole);
    
  
UPDATE employee_attrition_clean 
SET 
    Attrition = UPPER(Attrition);
    
    
-- validate data ranges
SELECT 
    *
FROM
    employee_attrition_clean
WHERE
    age < 18 OR age > 65;
    
    
