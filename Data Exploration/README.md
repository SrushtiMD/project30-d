# Data Exploration using SQL

This project involved exploring and analyzing data related to the Covid-19 pandemic. We used SQL queries on Microsoft SQL Server Management Studio (SSMS) to explore the data and gain insights into how the virus has spread across the world. The queries used in this project are provided below.

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


