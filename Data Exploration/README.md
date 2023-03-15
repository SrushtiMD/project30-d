# Data Exploration on Covid-19 data using SQL

This repository contains two excel files - CovidDeaths.xlsx and CovidVaccination.xlsx created from the Covid-19 dataset available at https://ourworldindata.org/covid-deaths.

## Excel Files

### CovidDeaths.xlsx

This file contains data related to COVID-19 cases and deaths, such as the total number of cases and deaths, new cases and deaths, location, and date.

### CovidVaccination.xlsx

This file contains data related to COVID-19 vaccinations, such as the total number of vaccinations, new vaccinations, location, and date.

## SQL Queries

To perform data exploration, we have used SQL Server Management Studio (SSMS). The following SQL queries have been used to explore the data:

1. To create tables for CovidDeaths and CovidVaccination:

```
CREATE TABLE CovidDeaths (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date DATE,
    total_cases BIGINT,
    new_cases BIGINT,
    total_deaths BIGINT,
    new_deaths BIGINT,
    population BIGINT
);

CREATE TABLE CovidVaccination (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date DATE,
    total_vaccinations BIGINT,
    new_vaccinations BIGINT,
    total_vaccinations_per_hundred FLOAT,
    new_vaccinations_per_million BIGINT,
    population BIGINT
);
```
You can use above query as well as you can do this task manually.

2. To load data from the downloaded CSV file into the tables:

```
BULK INSERT CovidDeaths FROM 'C:\CovidData\covid-deaths.csv' 
    WITH (FORMAT = 'CSV', FIRSTROW = 2);

BULK INSERT CovidVaccination FROM 'C:\CovidData\covid-vaccinations.csv' 
    WITH (FORMAT = 'CSV', FIRSTROW = 2);
```

3. To view the data in the tables:

```
SELECT * FROM CovidDeaths;

SELECT * FROM CovidVaccination;
```

4. To get the total number of deaths and cases by country:

```
SELECT location, SUM(total_cases) AS TotalCases, SUM(total_deaths) AS TotalDeaths
FROM CovidDeaths
GROUP BY location;

```

5. To get the total number of vaccinations by country:

```
SELECT location, MAX(total_vaccinations) AS TotalVaccinations
FROM CovidVaccination
GROUP BY location;
```

6. To get the top 10 countries with the highest number of deaths:

```
SELECT TOP 10 location, MAX(total_deaths) AS TotalDeaths
FROM CovidDeaths
GROUP BY location
ORDER BY TotalDeaths DESC;
```

7. To get the top 10 countries with the highest vaccination rate:

```
SELECT TOP 10 location, MAX(total_vaccinations_per_hundred) AS VaccinationRate
FROM CovidVaccination
GROUP BY location
ORDER BY VaccinationRate DESC;
```

## Conclusion:

In conclusion, this project has explored the Covid-19 dataset using SQL queries and created two excel files containing data related to CovidDeaths and CovidVaccination. The SQL queries used in this project can be used to extract more insights from the dataset.


