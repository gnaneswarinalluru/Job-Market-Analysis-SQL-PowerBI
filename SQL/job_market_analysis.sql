SHOW databases;

USE project_job_market_analysis;

SHOW tables;

DESCRIBE Market;

SELECT * FROM Market;

-- TASK-1 states with most number of jobs--

SELECT LOCATION AS State,
COUNT(*) AS Job_Count 
From Market
GROUP BY Location
order by Job_Count DESC;

-- TASK-2 avg minimal and maximal salaries in different states--

Select location AS state,
round(AVG(lower_salary),2) AS Avg_Min_Salary, 
round(AVG(upper_salary),2) AS Avg_Max_Salary
FROM Market
WHERE lower_salary is not NULL and upper_salary is not NULL
group by location
order by Avg_Max_Salary DESC; 

-- TASK-3 avg salary in different states--

SELECT location AS state,
ROUND(AVG((lower_salary + upper_salary)/2),2) AS Avg_Salary_k
FROM Market
WHERE lower_salary is not NULL and upper_salary is not NULL
group by location
order by Avg_Salary_k DESC; 

-- TASK-4 Top 2 industries with max number of data science job--

SELECT
    Industry,
    COUNT(*) AS Job_Count
FROM Market
WHERE Job_title_sim LIKE '%Data%'
GROUP BY Industry
ORDER BY Job_Count DESC
LIMIT 5;

-- TASK-5 company with max number job openeings --

SELECT company_txt AS company,
count(*) AS openings
FROM Market
group by company_txt
order by openings DESC;

-- TASK-6 job titles with most number of jobs--

SELECT Job_title_sim AS Job_title,
count(*) AS count
FROM Market 
group by Job_title_sim
order by count DESC;

-- TASK-7 salary of job titles with most number of jobs --

SELECT Job_title_sim AS Job_title,
count(*) AS Job_count,
ROUND(AVG((lower_salary + upper_salary)/2),2) AS Avg_Salary_k
FROM Market
WHERE lower_salary is not NULL and upper_salary is not NULL
group by Job_title_sim
order by Job_count DESC;

-- TASK-8 skills require by companies for each job title --

SELECT
    Job_title_sim,
    ROUND(AVG(CAST(python AS DECIMAL(3,2)))*100,1) AS Python_pct,
    ROUND(AVG(CAST(aws AS DECIMAL(3,2)))*100,1) AS AWS_pct,
    ROUND(AVG(CAST(excel AS DECIMAL(3,2)))*100,1) AS Excel_pct,
    ROUND(AVG(NULLIF(CAST('sql' AS DECIMAL(3,2)),-1))*100,1) AS SQL_pct,
    ROUND(AVG(CAST(spark AS DECIMAL(3,2)))*100,1) AS Spark_pct
    FROM Market
    GROUP BY Job_title_sim
    ORDER BY Python_pct DESC;

-- task-9 relation b/w avg salary and education--

SELECT
    Degree,
    COUNT(*) AS Job_Count,
    ROUND(AVG((lower_salary + upper_salary)/2),2) AS Avg_Salary_k
FROM Market
WHERE Degree IS NOT NULL
GROUP BY Degree
ORDER BY Avg_Salary_K DESC;

-- task-10 analyze all features and derive multiple insights--

SELECT 
    COUNT(*) AS Total_Jobs,
    ROUND(AVG(Rating),2) AS Avg_Company_Rating,
    ROUND(AVG((lower_salary + upper_salary)/2),2) AS Avg_Salary_k,
    ROUND(MIN((lower_salary + upper_salary)/2),2) AS Min_Salary_k,
    ROUND(MAX((lower_salary + upper_salary)/2),2) AS Max_Salary_k
FROM Market;


