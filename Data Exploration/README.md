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
