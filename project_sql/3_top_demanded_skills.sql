/*
Question: What are the most in demand skills for data analysts?

-Identify the top 5 in demand skills for data analyst
-Focus on all job postings.
-Why? Retrieve the top 5 skills with the highest demand in the job market, 
providing insights into the most valuable skills for job seekers
*/


Select 
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