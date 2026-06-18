use hr_analytics;

-- Business Questions & SQL Solutions:
-- 1. Overall Attrition Rate
-- How many employees leave the company?

SELECT 
    Attrition, COUNT(*) AS employees
FROM
    employee_attrition_clean
GROUP BY Attrition;

-- Attrition Rate:
SELECT 
    ROUND(SUM(CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
            2) AS attrition_rate
FROM
    employee_attrition_clean;


-- 2. Which Departments have high Turnover?

SELECT 
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS employee_left,
    ROUND(SUM(CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
            2) AS turnover_rate
FROM
    employee_attrition_clean
GROUP BY Department
ORDER BY turnover_rate DESC;


-- 3. Why do Employees Leave?
-- Analyzing overtime Impact

SELECT 
    OverTime,
    COUNT(*) AS employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS left_company,
    ROUND(SUM(CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
            2) AS attrition_rate
FROM
    employee_attrition_clean
GROUP BY OverTime;


-- 4. Salary vs Attrition

SELECT 
    CASE
        WHEN MonthlyIncome < 3000 THEN 'Low Salary'
        WHEN MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium Salary'
        ELSE 'High Salary'
    END AS salary_band,
    COUNT(*) AS employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS left_company
FROM
    employee_attrition_clean
GROUP BY salary_band;


-- 5. Average Salary by Department

SELECT 
    Department, ROUND(AVG(MonthlyIncome), 2) AS avg_salary
FROM
    employee_attrition_clean
GROUP BY Department
ORDER BY avg_salary DESC;

-- 6. Promotion Trends

SELECT 
    YearsSinceLastPromotion,
    COUNT(*) AS employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS left_company
FROM
    employee_attrition_clean
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion;


-- 7. Attrition by Job Role

SELECT 
    JobRole,
    COUNT(*) AS employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS attrition_count
FROM
    employee_attrition_clean
GROUP BY JobRole
ORDER BY attrition_count DESC;


