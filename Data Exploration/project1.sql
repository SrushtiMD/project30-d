Select *
From Project..CovidDeaths
WHERE continent is not null
order by 3, 4

Select *
From Project..CovidVaccination
order by 3, 4

-- Select Data that we are going to be using
Select location, date, total_cases, new_cases, total_deaths, population
From Project..CovidDeaths
WHERE continent is not null
order by 1, 2

-- Total Cases vs Total Deaths

Select location, date, total_cases, total_deaths, (CAST(total_deaths AS float)/CAST(total_cases AS float))*100 AS death_percentage
From Project..CovidDeaths
WHERE location like '%India%' AND continent is not null
order by 1, 2

-- Total Cases vs Population
-- Shows What percentage of population got Covid

Select location, date, total_cases, population, (total_cases/CAST(population  AS float))*100 AS CovidInfectionPercentage
From Project..CovidDeaths
-- WHERE location like '%India%'
WHERE continent is not null
order by 1, 2

-- Countries with Highest Infection Rate compared to Population
Select location, MAX(total_cases) as HighestInfectionCount, population, (MAX(total_cases)/CAST(population  AS float))*100 AS CovidInfectionPercentage
From Project..CovidDeaths
-- WHERE location like '%India%'
WHERE continent is not null
GROUP BY location, population
ORDER BY CovidInfectionPercentage DESC


-- Countries with Highest Death Count per Population

Select continent, MAX(total_deaths) as TotalDeathCount
From Project..CovidDeaths
-- WHERE location like '%India%'
WHERE continent is not null
GROUP BY continent, population
ORDER BY TotalDeathCount DESC


-- Let's break things down by continent

Select continent, MAX(total_deaths) as TotalDeathCount
From Project..CovidDeaths
-- WHERE location like '%India%'
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC


-- Showing Continents with the highest death count per population

Select continent, MAX(total_deaths) as TotalDeathCount
From Project..CovidDeaths
-- WHERE location like '%India%'
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC


-- Global Numbers 

Select date, SUM(CAST(total_cases AS float)) AS total_cases--, total_deaths, (CAST(total_deaths AS float)/CAST(total_cases AS float))*100 AS death_percentage
From Project..CovidDeaths
-- WHERE location like '%India%'
WHERE continent is not null
GROUP BY date
ORDER BY 1, 2

Select date, SUM(CAST(new_cases AS float)) AS new_cases--, total_deaths, (CAST(total_deaths AS float)/CAST(total_cases AS float))*100 AS death_percentage
From Project..CovidDeaths
-- WHERE location like '%India%'
WHERE continent is not null
GROUP BY date
ORDER BY 1, 2

Select date, SUM(CAST(new_cases AS float)) AS total_cases, SUM(CAST(new_deaths AS int)) as total_deaths, SUM(CAST(new_deaths as int))/NULLIF(SUM(new_cases), 0)*100 as DeathPercentage
From Project..CovidDeaths
-- WHERE location like '%India%'
WHERE continent is not null
GROUP BY date
ORDER BY 1, 2


Select *
From Project..CovidDeaths dea
JOIN Project..CovidVaccination vac
	ON dea.location = vac.location
	and dea.date = vac.date

-- Looking at Total Population vs Vaccination

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
From Project..CovidDeaths dea
JOIN Project..CovidVaccination vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2, 3


Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Project..CovidDeaths dea
JOIN Project..CovidVaccination vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2, 3

-- Use CTE

WITH cte AS (
    SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
        SUM(CONVERT(BIGINT, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.date) AS RollingPeopleVaccinated
    FROM Project..CovidDeaths dea
    JOIN Project..CovidVaccination vac
        ON dea.location = vac.location
        AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)
SELECT continent, location, date, population, new_vaccinations, RollingPeopleVaccinated
FROM cte
ORDER BY location, date


-- TEMP Table

DROP Table if exists #PercentPopulationVaccinated
CREATE Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccination numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Project..CovidDeaths dea
JOIN Project..CovidVaccination vac
	ON dea.location = vac.location
	and dea.date = vac.date
-- WHERE dea.continent is not null
-- ORDER BY 2, 3

SELECT * FROM #PercentPopulationVaccinated


-- Creating View to store data for later visualization

CREATE View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Project..CovidDeaths dea
JOIN Project..CovidVaccination vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
-- ORDER BY 2, 3

SELECT * FROM sys.views WHERE name = 'PercentPopulationVaccinated'

SELECT TOP 1000 *
FROM [PercentPopulationVaccinated]

 