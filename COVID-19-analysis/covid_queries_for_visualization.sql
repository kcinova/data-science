/* Queries used for Tableau viz */

/* 1. Global Numbers */
SELECT
	SUM(new_cases) AS total_cases,
	SUM(cast(new_deaths AS int)) AS total_deaths,
	SUM(cast(new_deaths AS int)) / SUM(New_Cases) * 100 AS DeathPercentage
FROM
	"Covid_Deaths"
WHERE
	continent <> ''
ORDER BY
	1,
	2;

/* 2. Total Deaths */
SELECT
	LOCATION,
	SUM(cast(new_deaths AS int)) AS TotalDeathCount
FROM
	"Covid_Deaths"
WHERE
	LOCATION IN('Europe', 'North America', 'South America', 'Asia', 'Africa', 'Oceania')
GROUP BY
	LOCATION
ORDER BY
	TotalDeathCount DESC;


/* 3. Infection Rate by Country */
SELECT
	LOCATION,
	Population,
	MAX(total_cases) AS HighestInfectionCount,
	Max((total_cases / population)) * 100 AS PercentPopulationInfected
FROM
	"Covid_Deaths"
GROUP BY
	LOCATION,
	Population
ORDER BY
	PercentPopulationInfected DESC;

/* 4. Infection Rate Over Time */
SELECT
	LOCATION,
	COALESCE(Population, 0) AS Population,
	date,
	COALESCE(MAX(total_cases), 0) AS HighestInfectionCount,
	(COALESCE(MAX(total_cases), 0) / NULLIF(COALESCE(Population, 0), 0)) * 100 AS PercentPopulationInfected
FROM
	"Covid_Deaths"
WHERE
	Population IS NOT NULL
	AND total_cases IS NOT NULL
	AND Population > 0
	AND LOCATION NOT IN('World', 'European Union', 'International')
GROUP BY
	LOCATION,
	Population,
	date
ORDER BY
	PercentPopulationInfected DESC;