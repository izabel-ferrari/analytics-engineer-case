WITH covid_jhu AS (
  SELECT * FROM `analytics-engineer-case-372415.covid_19_data_repository_by_csse_at_jhu.summary`
), census AS (
  SELECT * FROM `analytics-engineer-case-372415.international_census_data.midyear_population`
), daily_covid AS (
  -- Aggregate confirmed covid cases by country and day
  SELECT
    -- Leverage covid report country names with the names that appear in the census data
    CASE TRIM(country_region)
      WHEN "Bahamas" THEN "Bahamas, The"
      WHEN "The Bahamas" THEN "Bahamas, The"
      WHEN "Cape Verde" THEN "Cabo Verde"
      WHEN "Czech Republic" THEN "Czechia"
      WHEN "East Timor" THEN "Timor-Leste"
      WHEN "Gambia" THEN "Gambia, The"
      WHEN "The Gambia" THEN "Gambia, The"
      WHEN "Hong Kong SAR" THEN "Hong Kong"
      WHEN "Iran (Islamic Republic of)" THEN "Iran"
      WHEN "Ivory Coast" THEN "Cote d'Ivoire"
      WHEN "Macao SAR" THEN "Macau"
      WHEN "Mainland China" THEN "China"
      WHEN "Micronesia" THEN "Micronesia, Federated States of"
      WHEN "Republic of Ireland" THEN "Ireland"
      WHEN "North Ireland" THEN "Ireland"
      WHEN "North Macedonia" THEN "Macedonia"
      WHEN "Republic of Korea" THEN "Korea, South"
      WHEN "South Korea" THEN "Korea, South"
      WHEN "Republic of Moldova" THEN "Moldova"
      WHEN "Republic of the Congo" THEN "Congo (Brazzaville)"
      WHEN "Russian Federation" THEN "Russia"
      WHEN "St. Martin" THEN "Saint Martin"
      WHEN "Taipei and environs" THEN "Taiwan"
      WHEN "Taiwan*" THEN "Taiwan"
      WHEN "UK" THEN "United Kingdom"
      WHEN "US" THEN "United States"
      WHEN "Viet Nam" THEN "Vietnam"
      ELSE TRIM(country_region)
    END AS country,
    date,
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(WEEK FROM date) AS week,
    SUM(confirmed) AS confirmed
  FROM covid_jhu
  WHERE confirmed IS NOT NULL
  GROUP BY 1, 2, 3, 4
), weekly_covid AS (
  -- Aggregate confirmed cases by country and week
  SELECT DISTINCT
    country,
    year,
    week,
    MAX(confirmed) OVER (PARTITION BY country, year, week) AS confirmed_cases
  FROM daily_covid
), weekly_covid_census AS (
  -- Join covid data with census data
  SELECT
    weekly_covid.country AS country,
    weekly_covid.year AS year,
    weekly_covid.week AS week,
    census.midyear_population AS curr_population,
    weekly_covid.confirmed_cases AS curr_confirmed_cases,
    LAG(weekly_covid.confirmed_cases) OVER (PARTITION BY country ORDER BY weekly_covid.year, week) AS prev_confirmed_cases,
    LAG(census.midyear_population) OVER (PARTITION BY country ORDER BY weekly_covid.year, week) AS prev_population
  FROM weekly_covid
  INNER JOIN census
    ON TRIM(weekly_covid.country) = TRIM(census.country_name) AND weekly_covid.year = census.year
), covid_growth AS (
  -- Calculate weekly growth of covid cases per country per capita
  SELECT
    country,
    year,
    week,
    SAFE_DIVIDE(prev_population, curr_population)*SAFE_DIVIDE(curr_confirmed_cases, prev_confirmed_cases) - 1 AS confirmed_cases_growth_rate
  FROM weekly_covid_census
)

SELECT *
FROM covid_growth
ORDER BY country, year, week
