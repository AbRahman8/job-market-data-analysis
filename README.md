# Job Market Analysis | Python, SQL & Power BI

## About the Project

I worked on this project to understand the job market using data. The main goal was to explore salary trends, in-demand job categories, hiring patterns, career growth opportunities, and job competition.

I used Python for data cleaning, SQL to analyse the data, and Power BI to build an interactive dashboard.

## Tools Used

- **Python (Pandas):** Data cleaning and handling missing values
- **MySQL:** Data preparation and business analysis
- **Power BI:** Dashboard creation and data visualisation

## Data Cleaning

I cleaned the dataset using Python and prepared it for analysis in MySQL.

Some of the tasks I performed:
- Checked the dataset structure and missing values.
- Filled missing values in `probation_period` using the mode.
- Cleaned `career_growth_index` by removing the percentage sign and converting it to a numeric column.
- Converted `posted_date` into the correct date format in MySQL.
- Created an `average_salary` column using minimum and maximum salary.

## SQL Analysis

I wrote SQL queries to answer the following business questions:

1. Which job categories have the highest average salaries?
2. Which cities offer better salaries and more job opportunities?
3. Which companies have the highest number of job postings?
4. Which skill groups appear most frequently in job postings?
5. How do salaries vary by experience, education, and employment type?
6. Which job postings have the highest applicant counts?
7. Which companies have higher career growth index values?
8. Which jobs are active, and which have expired deadlines?
9. Which jobs offer above-average salaries with below-average applicant counts within their categories?
10. How do job postings change month by month?

## Key Findings

- **100,000 job postings** were analysed.
- AI / ML Engineering had the highest average salary among the job categories analysed.
- Gurgaon and Hyderabad ranked highest in average salary among the cities in my analysis.
- Chennai had the highest number of postings among the cities compared.
- Cloud-related roles appeared frequently among the highest-count company and job-title combinations.
- Tech Mahindra had the highest average career growth index among the companies shown in my results.
- Job postings declined in February 2026, recovered in March, and showed mixed movement from April to May.

## Power BI Dashboard

The dashboard includes:

- Total job postings, average salary, and average career growth index
- Active vs. inactive jobs
- Jobs by experience level and company type
- Monthly job posting trends
- Job source platform distribution
- Shift distribution
- Filters for company name, experience level, employment type, and city

![Job Market Analysis Dashboard](dashboard.png)

*Add your Power BI dashboard screenshot to the repository and name it `dashboard.png` to display it here.*

## What I Learned

While working on this project, I got practical experience in cleaning real-world-style data, writing SQL queries, analysing business questions, and presenting findings through a Power BI dashboard.

I also learned the importance of checking data quality before drawing conclusions from analysis.

## Conclusion

This project helped me practise the complete data analysis workflow, from cleaning the data to extracting insights and presenting them in a dashboard.

**Project focus:** Python | SQL | Power BI | Data Cleaning | Exploratory Data Analysis | Business Insights
