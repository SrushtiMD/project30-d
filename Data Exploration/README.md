# Data Exploration using SQL

In this project, we explored COVID-19 data to gain insights into the impact of the pandemic on different countries, continents, and the world as a whole. We used SQL queries to extract data from two tables, CovidDeaths and CovidVaccination, stored in a SQL Server Management Studio (SSMS) database.

### Data Sources
* CovidDeaths: This table contains data related to COVID-19 cases and deaths, such as the total number of cases and deaths, new cases and deaths, location, and date.

* CovidVaccination: This table contains data related to COVID-19 vaccinations, such as the total number of vaccinations, new vaccinations, location, and date.

### Queries

The first query was used to retrieve all the records from the CovidDeaths table that had a valid continent value. The records were sorted by date and location:

```
Select *
From Project..CovidDeaths
WHERE continent is not null
order by 3, 4

```

The second query was used to retrieve all the records from the CovidVaccination table. The records were sorted by date and location:

```
Select *
From Project..CovidVaccination
order by 3, 4

```

The third query was used to select the data that we were going to be using. It retrieves the location, date, total_cases, new_cases, total_deaths, and population columns from the CovidDeaths table for all records that had a valid continent value. The records were sorted by location and date:

```
Select location, date, total_cases, new_cases, total_deaths, population
From Project..CovidDeaths
WHERE continent is not null
order by 1, 2

```


