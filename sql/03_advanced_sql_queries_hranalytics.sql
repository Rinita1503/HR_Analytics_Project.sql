-- Advanced SQL queries:
-- 1. Top Risk Departments

with dept_attrition as (
select Department,
count(*) as total_emp,
sum(case when Attrition = 'Yes' then 1 else 0 end) as left_emp
from employee_attrition_clean
group by Department
)

SELECT
    Department,
    total_emp,
    left_emp,
    ROUND(left_emp*100.0/total_emp,2) AS turnover_rate
FROM dept_attrition
ORDER BY turnover_rate DESC;


-- 2. Salary Ranking Within Department

SELECT
    EmployeeNumber,
    Department,
    MonthlyIncome,
    RANK() OVER(
        PARTITION BY Department
        ORDER BY MonthlyIncome DESC
    ) AS salary_rank
FROM employee_attrition_clean;


-- 3. Department Salary Comparison

SELECT
    EmployeeNumber,
    Department,
    MonthlyIncome,
    AVG(MonthlyIncome) OVER(
        PARTITION BY Department
    ) AS dept_avg_salary
FROM employee_attrition_clean;


-- 4. Employees Earning above Department Average

SELECT 
    *
FROM
    employee_attrition_clean e
WHERE
    MonthlyIncome > (SELECT 
            AVG(MonthlyIncome)
        FROM
            employee_attrition_clean
        WHERE
            Department = e.Department);
