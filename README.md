# Analytics Engineer Case

This repository contains all the deliverables of the Analytics Engineer Case.

## Repository contents
* [Case Results Presentation](./analytics_engineer_case_presentation.pdf)
* Part 1 - Data ingestion, modeling and analysis
  * [Python script for data ingestion](./part1_deals_data_elt/data_analysis)
  * [Data modeling project using dbt](./part1_deals_data_elt/data_transformation)
  * [SQL queries for data analysis](./part1_deals_data_elt/data_ingestion.py)
* Part 2 - COVID-19 query implementation
  * [Weekly growth of confirmed COVID-19 cases per capita per country query](./part2_covid_analysis/covid_confirmed_cases_growth_per_country_per_week.sql)
  
## Database
All the data referrenced in this project is available in the **analytics-engineer-case-372415** project in **BigQuery**.

Datasets for Part 1:
* **raw_data**
  * Contains ingested data from source csv files
* **transformed_data_staging**
  * Contains the staging tables
* **transformed_data_final**: 
  * Contains the facts and dimensions tables

Datasets for Part 2:
* **covid_19_data_repository_by_csse_at_jhu**
  * [COVID-19 Data Repository by JHU](https://console.cloud.google.com/marketplace/product/johnshopkins/covid19_jhu_global_case)
* **international_census_data**
  * [International Census Data by US Census Bureau](https://console.cloud.google.com/marketplace/product/united-states-census-bureau/international-census-data)
