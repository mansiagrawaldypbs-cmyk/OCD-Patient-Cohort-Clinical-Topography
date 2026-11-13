CREATE DATABASE IF NOT EXISTS ocd_db;

use ocd_db;
 
create table ocd_patients ( 
patient_id INT PRIMARY KEY, 
age INT, gender VARCHAR(10), 
ethnicity VARCHAR(50), 
marital_status VARCHAR(30), 
education_level VARCHAR(30), 
ocd_diagnosis_date DATE, 
duration_of_symptoms_months INT, 
previous_diagnoses VARCHAR(50), 
family_history_of_ocd VARCHAR(10), 
obsession_type VARCHAR(50), 
compulsion_type VARCHAR(50), 
ybocs_score_obsessions INT, 
ybocs_score_compulsions INT, 
depression_diagnosis VARCHAR(10), 
anxiety_diagnosis VARCHAR(10), 
medications VARCHAR(50) );

-- Count total patients in the clinical study.
select count(*)
from ocd_patients;

-- Find the gender breakdown of OCD patients.
select sum(CASE WHEN previous_diagnoses IS NULL THEN 1 ELSE 0 END) AS missing_prev_diag, 
SUM(CASE WHEN medications IS NULL THEN 1 ELSE 0 END) AS missing_meds FROM ocd_patients;

-- Find the gender breakdown of OCD patients.
select gender,
count(*) As patient_count
from ocd_patients
group by gender;

-- Calculate average age of patients across genders.
select gender,
round(avg(age),2) As Avg_age
from ocd_patients
group by gender;

-- Find the most common obsession type.
SELECT obsession_type, 
COUNT(*) AS total_cases 
FROM ocd_patients 
GROUP BY obsession_type 
ORDER BY total_cases DESC;

-- Find the most common compulsion type.
select compulsion_type,
count(*) AS total_cases
from ocd_patients
group by compulsion_type
order by total_cases desc;

-- Average Y-BOCS Obsession and Compulsion scores.
select
round(avg(ybocs_score_obsessions),2) AS avg_obsessions_score,
round(avg(ybocs_score_compulsions),2) as avg_compulsions_score
from ocd_patients;

-- Count patients with comorbid depression and anxiety.
select count(*) as dual_comorbid_count
from ocd_patients
where depression_diagnosis= 'yes' and anxiety_diagnosis='yes';

-- Find average Y-BOCS total score by ethnicity.
select ethnicity,round(avg(ybocs_score_obsessions+ybocs_score_compulsions),2) as avg_total_ybocs
from ocd_patients
group by ethnicity
order by avg_total_ybocs desc;

-- Patients with family history of OCD vs. without.
select family_history_of_ocd, 
count(*) as patient_count, 
round(avg(ybocs_score_obsessions + ybocs_score_compulsions), 2) as avg_ybocs 
from ocd_patients 
group by family_history_of_ocd;

-- Top prescribed medications across the patient cohort.
select medications, COUNT(*) as patient_count 
from ocd_patients 
where medications is not null
group by medications 
order by patient_count desc;

-- Average duration of symptoms (months) by marital status.
select marital_status, round(avg(duration_of_symptoms_months), 1) as avg_duration_months 
from ocd_patients 
group by marital_status;

-- Rank patients by total Y-BOCS score using DENSE_RANK().
select patient_id, age, gender, (ybocs_score_obsessions + ybocs_score_compulsions) as total_ybocs, 
dense_rank() over (order by (ybocs_score_obsessions + ybocs_score_compulsions) desc) as severity_rank 
from ocd_patients;

-- Find patients whose Y-BOCS total score exceeds the cohort average.
select patient_id, age, gender, (ybocs_score_obsessions + ybocs_score_compulsions) as total_score 
from ocd_patients 
where (ybocs_score_obsessions + ybocs_score_compulsions) > ( select avg(ybocs_score_obsessions + ybocs_score_compulsions) 
from ocd_patients );

-- Calculate cumulative patient counts by OCD diagnosis year
with yearly_diag as ( select year(ocd_diagnosis_date) as diag_year, 
count(*) as new_patients 
from ocd_patients 
group by year(ocd_diagnosis_date) ) 
select diag_year, new_patients, sum(new_patients) 
over ( order by diag_year ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) as cumulative_patients 
from yearly_diag;

-- Categorize patient severity ('Severe' if total Y-BOCS > 30, 'Moderate' > 20, else 'Mild').
select patient_id, (ybocs_score_obsessions + ybocs_score_compulsions) as total_ybocs, 
case when (ybocs_score_obsessions + ybocs_score_compulsions) > 30 then 'Severe' when (ybocs_score_obsessions + ybocs_score_compulsions) >= 20 then 'Moderate' else 'Mild' end as clinical_severity 
from ocd_patients;