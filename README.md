# OCD-Patient-Cohort-Clinical-Topography
OCD Patient Cohort: Clinical Topography
🧠 OCD Patient Clinical Analytics Portfolio Project

📋 Executive Summary

This repository contains an end-to-end SQL healthcare analytics portfolio project analyzing a clinical dataset of 1,500 Obsessive-Compulsive Disorder (OCD) patients. Using MySQL, this project explores patient demographics, psychiatric symptom manifestations, Yale-Brown Obsessive Compulsive Scale (Y-BOCS) severity benchmarks, comorbid conditions (Depression & Anxiety), and pharmacological treatment landscapes.

🗂️ Repository Structure

├── README.md                                         # Project documentation & clinical insights
├── OCD Patient Clinical Analytics Portfolio Project.sql # Complete DDL, data hygiene & 15 analytical queries
├── OCD_Patient_Analytics_Framework_Infographic.png   # Visual analytics framework overview
└── OCD_Patient_Cohort_Dossier.pdf                    # Detailed clinical cohort topography dossier


🗄️ Database Schema (ocd_db.ocd_patients)

The ocd_patients table captures 17 clinical, demographic, and diagnostic attributes:

Column Name

Data Type

Description

patient_id

INT (PK)

Unique identifier for each clinical patient

age

INT

Patient age in years (Range: 18–75)

gender

VARCHAR(10)

Biological gender (Male, Female)

ethnicity

VARCHAR(50)

Patient ethnic background (Caucasian, African, Asian, Hispanic)

marital_status

VARCHAR(30)

Relationship status (Single, Married, Divorced)

education_level

VARCHAR(30)

Highest educational attainment

ocd_diagnosis_date

DATE

Date of formal clinical OCD diagnosis

duration_of_symptoms_months

INT

Symptom duration prior to formal diagnosis (in months)

previous_diagnoses

VARCHAR(50)

Prior psychiatric diagnoses (e.g., MDD, Tourette's; contains NULLs)

family_history_of_ocd

VARCHAR(10)

Hereditary history of OCD (Yes / No)

obsession_type

VARCHAR(50)

Primary obsession category (e.g., Harm-related, Contamination, Symmetry)

compulsion_type

VARCHAR(50)

Primary compulsion behavior (e.g., Washing, Checking, Counting)

ybocs_score_obsessions

INT

Y-BOCS Obsession severity sub-score (0–40)

ybocs_score_compulsions

INT

Y-BOCS Compulsion severity sub-score (0–40)

depression_diagnosis

VARCHAR(10)

Comorbid depression status (Yes / No)

anxiety_diagnosis

VARCHAR(10)

Comorbid anxiety status (Yes / No)

medications

VARCHAR(50)

Prescribed pharmaceutical treatment (SSRI, SNRI, Benzodiazepine; contains NULLs)

🔍 Analytical Scope & SQL Techniques

The SQL script (OCD Patient Clinical Analytics Portfolio Project.sql) is organized into three operational phases:

Phase 1: Database Setup & Schema Architecture

Provisioned the ocd_db relational database and structured the ocd_patients schema with appropriate data types and primary key constraints.

Phase 2: Data Hygiene & NULL Auditing

Audited missing clinical documentation using conditional aggregation (CASE WHEN ... IS NULL):

previous_diagnoses: 248 records identified without prior diagnostic history.

medications: 386 records identified as unmedicated or lacking prescription notes.

Phase 3: 15 Core Clinical Inquiries

Cohort Baseline: Total enrolled study sample size ($N = 1,500$).

Gender Distribution: Balanced cohort split (753 Male, 747 Female).

Age Demographics: Average patient age segmented by gender (46.75 yrs Male, 46.81 yrs Female).

Dominant Obsessions: Frequency ranking of cognitive burdens (Harm-related leading with 333 cases, followed by Contamination and Symmetry).

Dominant Compulsions: Frequency ranking of behavioral responses (Washing leading with 321 cases, followed by Checking and Counting).

Baseline Y-BOCS Metrics: Cohort-wide mean severity scores (20.05 Obsessions, 19.63 Compulsions).

Dual-Comorbidity Burden: Isolated 384 patients managing simultaneous OCD, Clinical Depression, and Clinical Anxiety.

Demographic Severity Variance: Evaluated combined Y-BOCS totals across ethnic groups.

Genetic Burden Impact: Compared patient volume and mean Y-BOCS severity between hereditary (Yes) and non-hereditary (No) cohorts.

Pharmacological Landscape: Ranked active prescriptions (Benzodiazepine: 386, SSRI: 372, SNRI: 356).

Symptom Latency by Marital Status: Calculated average pre-diagnosis symptom duration across relationship clusters.

Severity Ranking (DENSE_RANK()): Ranked all patients sequentially by combined Y-BOCS scores using window functions.

Above-Average Severity Benchmarking: Used a scalar subquery to isolate patients exceeding the cohort's mean total Y-BOCS score.

Longitudinal Diagnosis Trajectory: Built a Common Table Expression (CTE) paired with a window frame (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) to track cumulative annual patient intake.

Clinical Severity Stratification (CASE WHEN): Classified patients into clinical impairment tiers:

Severe: Total Y-BOCS $> 30$

Moderate: Total Y-BOCS $20 - 30$

Mild: Total Y-BOCS $< 20$

🛠️ How to Reproduce This Project

Clone the Repository:

git clone https://github.com/your-username/ocd-clinical-analytics-sql.git


Initialize the Database:
Open MySQL Workbench (or any MySQL 8.0+ client) and execute the CREATE DATABASE and CREATE TABLE statements in OCD Patient Clinical Analytics Portfolio Project.sql.

Import the Dataset:
Use the Table Data Import Wizard in MySQL Workbench to load ocd_patient.csv into the ocd_patients table.

Run Analytical Queries:
Execute the remaining queries in the .sql script to reproduce all clinical metrics and rankings.

📈 Key Clinical Takeaways

Phenotypic Alignment: Harm-related and contamination obsessions directly mirror the high prevalence of checking and washing compulsions across the cohort.

High-Risk Sub-Population: Over 25.6% of the cohort ($384 / 1,500$) presents with a triple-diagnosis profile (OCD + Depression + Anxiety), requiring targeted multi-modal clinical intervention.

Structured Data Hygiene: Separating unmedicated/undocumented patients (NULL medication entries) prevents skewing pharmacological efficacy baselines.
