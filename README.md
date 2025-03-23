# Introduction
This is a project where I analyze both skills needed and salarys of Data Analyst postions.

Queries used to conduct analysis : [project_sql](/project_sql/)

# Background
I was personally interested in the field of Data Analyst, so while I learned SQL I learned so by analyzing the role itself.

### Questions I wanted to answer
1. What are the top paying data analyst jobs?
2. What skills are required for the top paying data analyst jobs?
3. What are the most in demand skills for data analysts?
4. What are the top skills based on salary?
5. What are the most optimal skills to learn to become a Data Analyst(A skills both high in demand and with high pay)

# Tools I used 
- **SQL** : All analysis was done through SQL, which let me query my database in order to come to my conclusion.
- **PostgreSQL** :This program was my choosen database system.
- **Visual Studio Code** : I used VS Code to both manage database and execute my SQL queries.

- **Git & Github**: How I shared my SQL scripts and analysis

# The Analysis 

### 1. Top paying Data Analyst jobs
In my first query I looked for the top paying Data Analyst jobs, but only those that were remote. This query highlights the high paying oportunity in this field.

``` sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
From 
    job_postings_fact
LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
Order BY
    salary_year_avg desc

Limit 10
```
With this query I was able to see that when it comes to Data Analyst jobs the sky is the limit, having job opportunitys with salarys all the way up to 650,000$

### 2. Top paying job skills
In this query I looked more in depth into my preivous query, analyzing the skills these higher paying jobs required.
```With top_paying_jobs AS (
SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
From 
    job_postings_fact
LEFT JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
Order BY
    salary_year_avg desc

Limit 10 ) 

SELECT 
    top_paying_jobs.*,
    skills

From top_paying_jobs
inner join skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

ORDER BY 
salary_year_avg DESC

With this query I was able to see that there are a wide variety of skills that are needed to get a high paying Data Analyst jobs, such as SQL,Python, and R.
```
### 3. Top Demanded skills
In this third query I looked for the top demanded skills in order to see what skills I should focus on learning first in order to become a Data Analyst.
```Select 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count

from job_postings_fact

inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

Where 
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE 

GROUP BY    
    skills

Order BY
demand_count DESC

Limit 5
```
This query showed me that most job postings are looking for someone who knows SQL,Excel,Python,Tableau, and power bi.

### 4. Top paying skills
This query was to analyze specific skills that are connected towards high paying jobs.
```Select 
    skills,
    ROUND(AVG(salary_year_avg),0 ) AS avg_salary

from job_postings_fact

inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

Where 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    -- AND job_work_from_home = TRUE 

GROUP BY    
    skills

Order BY
    avg_salary DESC

Limit 25 
```
This query let me see unique skills that lead to high paying jobs, such as SVN, Solidity, and CouchBase.

### 5. Optimal skills
In this last query I combined both my 3rd and 4th query using a Common Table Expression (CTE) in order to find jobs with both skills in high demand and high average salaries.
```
WITH skills_demand AS(

    Select 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count

    from job_postings_fact

    inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

    Where 
        job_title_short = 'Data Analyst' 
        AND job_work_from_home = TRUE
        AND salary_year_avg IS NOT NULL

    GROUP BY    
         skills_dim.skill_id
),

 average_salary AS (

   Select 
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg),0 ) AS avg_salary

from job_postings_fact

inner join skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

Where 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
     AND job_work_from_home = TRUE 

GROUP BY    
    skills_job_dim.skill_id
 )

Select
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
from
    skills_demand
inner join average_salary on skills_demand.skill_id = average_salary.skill_id
Where
    demand_count > 10
ORDER BY   
       avg_salary DESC,
    demand_count DESC
    
LIMIT 25
```
This Query let me understand that skills such as Go,Confluence, and Hadoop are both common and high paying skills.

# Conclusion
This project has led me to understand that a career in Data Analysis is finnacially rewarding. I also now understand the skills I need to acquire in order become a Data Analysis such as SQL,Python,R,Confluence and Tableau.

# Closing Thoughts 
This project was my is my first SQL project, so not only did I learn about Data Analysis as a career I also learned how to use SQL in order to get Data needed to answer questions.With this project I now also know the next skills I need to learn in order to pursue a career in Data Analytics.
