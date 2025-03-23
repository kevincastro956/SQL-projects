/*
Answer: What are the most optimal skills to learn (A skills both high in demand and with high pay)
-Identify skills in high demand and associated with high average salaries for Data Analyst roles
-Concentrates on remote positions with specified salaries
-Why? Targets skills that offer job security (High demand) and financial benefits (high salaries),
 offering strategic insights for career development in data analysis
 */


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