/*
Answer: What are the top skills based on salary?
-Look at the average salary associated with each skill for Data Analyst positions
-Focuses on roles with specified salarys, regardless of location
-Why> It reveals how diffrent skills immpact
*/





Select 
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