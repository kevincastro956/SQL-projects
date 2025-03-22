/*
Question : What skills are required for the top paying data analyst jobs?
-Use the top 10 highest paying Data Analust jobs from the first query
-Add the specific skills required for these roles
-Why? It provides a detailed look at which high paying jobs demands certain skills,
    helping job seekers understand which skills to develop that align with top salaries
*/

With top_paying_jobs AS (




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

