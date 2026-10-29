USE job_market_analysis;
SELECT * FROM job_postings
LIMIT 20;

DESCRIBE job_postings;
UPDATE job_postings
SET posted_date = STR_TO_DATE(posted_date, '%d-%m-%Y');

ALTER TABLE job_postings
MODIFY posted_date DATE;
DESCRIBE job_postings;

#ADD NEW COLUMN
ALTER TABLE job_postings
ADD COLUMN average_salary FLOAT
AFTER salary_maximum;

#ADDING Values INTO New Column

UPDATE job_postings
SET average_salary = (salary_minimum + salary_maximum) / 2;


####Business Analysis
-- 1. Which job categories offer the highest average salary?
SELECT
	job_category,
    ROUND(AVG(average_salary),2) Highest_avg_salary,
    COUNT(*) AS total_job
FROM job_postings
GROUP BY job_category
ORDER BY Highest_avg_salary DESC;


-- 2. Which cities offer the best combination of salary and job opportunities?
SELECT
	location_city,
	ROUND(AVG(average_salary),2) AS avg_salary,
	COUNT(*) as job_opportunities
FROM job_postings
GROUP BY 1
ORDER BY 2 DESC,3 DESC;

-- 3. Which companies are hiring the most, and what types of jobs are they offering?
SELECT 
	company_name,
    job_title,
    COUNT(*) numb_of_hiring
FROM job_postings
GROUP BY 1,2
ORDER BY numb_of_hiring DESC;

-- 4. Which technical skills are most in demand, and which skills are associated with higher salaries?
SELECT 
	skills_extracted,
	COUNT(*) AS demand,
	ROUND(AVG(average_salary),2) Higher_salary
FROM job_postings
GROUP BY 1
ORDER BY 2 DESC , 3 DESC;

-- 5. How does salary vary across experience levels, education requirements, and employment types?
SELECT
	experience_level,
    education_required,
    employment_type,
    COUNT(*) AS total_jobs,
	ROUND(AVG(average_salary),2) average_salary_vary
FROM job_postings
GROUP BY 1,2,3
ORDER BY experience_level ASC, average_salary_vary DESC;

-- 6. Which job postings have high applicant competition?
SELECT
	job_title,
    company_name,
    location_state,
    experience_level,
    source_platform,
    applicant_count,
    RANK() OVER (ORDER BY applicant_count DESC) AS competition_rank
FROM job_postings
ORDER BY applicant_count DESC
LIMIT 20;

-- 7. Which companies offer better career growth opportunities?
SELECT 
	company_type,
    company_name,
    COUNT(*) AS total_job_posting,
    ROUND(AVG(career_growth_index),2) AS perc_growth_opportunity
FROM job_postings
GROUP BY company_type, company_name
ORDER BY perc_growth_opportunity DESC;
	
-- 8. Which jobs are at risk of missing their application deadlines, and which opportunities are still active?
SELECT
job_title,
job_category,
is_active,
application_deadline,
CASE
	WHEN application_deadline IS NULL THEN 'Unknown deadline'
    WHEN application_deadline < CURDATE() AND
    is_active = 1
    THEN 'Active but deadline expired'
    WHEN application_deadline < CURDATE() THEN 'Deadline expired'
    WHEN application_deadline <= DATE_ADD(CURDATE(), INTERVAL 7 DAY)
    AND is_active = 1
    THEN 'Deadline approching'
    WHEN is_active = 1
    THEN 'Active- Deadline not near'
    ELSE 'Inactive'
END as deadline_status
FROM job_postings
ORDER BY application_deadline ASC;

-- 9. Which job postings offer competitive salaries but have relatively low applicant counts?
WITH category_details AS
(SELECT
	job_category,
    ROUND(AVG(average_salary),2) AS category_avg_salary,
    ROUND(AVG(applicant_count),2) category_avg_applicant
    FROM job_postings
    GROUP BY job_category)
    
SELECT
	j.job_title,
    j.job_category,
    j.company_name,
    j.average_salary,
    cd.category_avg_salary,
    cd.category_avg_applicant
FROM job_postings AS j
JOIN category_details AS cd
ON j.job_category = cd.job_category
WHERE j.average_salary > cd.category_avg_salary AND
j.applicant_count < cd.category_avg_applicant
ORDER BY j.average_salary DESC;

-- 10. How has the job market changed over time, and which skills and job categories are growing?
WITH monthly_jobs AS
		(SELECT
			DATE_FORMAT(posted_date, '%Y-%m') AS posting_month,
			job_category,
			COUNT(*) AS total_jobs
		FROM job_postings
		GROUP BY posting_month, job_category
		ORDER BY posting_month ASC),
        
 monthly_trends AS
		(SELECT
			posting_month,
			job_category,
			total_jobs,
			COALESCE(LAG(total_jobs) OVER(PARTITION BY job_category ORDER BY posting_month ASC),0) AS prev_month_jobs
			FROM monthly_jobs)
            
SELECT *,
    total_jobs - prev_month_jobs AS job_changes
FROM monthly_trends
ORDER BY posting_month,job_category;

#The job market showed fluctuations during the first five months of 2026. Job postings declined in February but recovered in March, particularly in Web Development and DevOps. However, the recovery was not consistent across all categories in April and May.
	