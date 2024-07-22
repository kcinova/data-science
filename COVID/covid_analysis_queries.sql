/* 
 This SQL script provides various analyses on COVID-19 data.
 It includes queries to analyze infection rates, death rates, 
 vaccination rates, and the overall impact of COVID-19 across different regions.
 */
 
-- Initial data retrieval from Covid_Deaths table
SELECT
	LOCATION,
	date,
	total_cases,
	new_cases,
	total_deaths,
	population
FROM
	"Covid_Deaths"
ORDER BY
	1, 2; 

-- Shows likelihood of dying if you contract COVID-19 in the United States
SELECT
	LOCATION,
	date,
	total_cases,
	new_cases,
	total_deaths,
	(total_deaths / total_cases) * 100 AS death_rate
FROM
	"Covid_Deaths"
WHERE
	LOCATION ILIKE '%states%'
ORDER BY
	1, 2; 
	
-- Calculates the percentage of the population that contracted COVID-19 in the United States
SELECT
	LOCATION,
	date,
	population,
	total_cases,
	(total_cases / population) * 100 AS infection_rate
FROM
	"Covid_Deaths"
WHERE
	LOCATION ILIKE '%states%'
ORDER BY
	1, 2;
	
-- Displays highest infection rates by country
SELECT
	LOCATION,
	population,
	MAX(total_cases) AS highest_total_cases,
	(MAX(total_cases)::numeric / population) * 100 AS percent_population_infected
FROM
	"Covid_Deaths"
GROUP BY
	LOCATION,
	population
ORDER BY
	percent_population_infected DESC; 
	
-- Countries with highest death count
SELECT
	LOCATION,
	MAX(total_deaths)::integer AS total_death_count
FROM
	"Covid_Deaths"
WHERE
	total_deaths IS NOT NULL
	AND continent <> ''
GROUP BY
	LOCATION
ORDER BY
	total_death_count DESC;  
	
-- Countries with highest death count per population
SELECT
    location,
    MAX(total_deaths)::integer AS total_death_count,
    population,
    (MAX(total_deaths)::numeric / population) * 100 AS death_rate_per_population
FROM
    "Covid_Deaths"
WHERE
    total_deaths IS NOT NULL
    AND continent <> ''
    AND population IS NOT NULL
GROUP BY
    location,
    population
ORDER BY
    death_rate_per_population DESC;
	
-- Breaks down the total death count by continent
SELECT
	LOCATION,
	MAX(total_deaths)::INTEGER AS total_death_count
FROM
	"Covid_Deaths"
WHERE (continent IS NULL
	OR continent = '')
GROUP BY
	LOCATION
ORDER BY
	total_death_count DESC;


/* Global numbers */

-- Looking at total population vs. vaccinations
SELECT
	dea.continent,
	dea.location,
	dea.date,
	dea.population,
	vac.new_vaccinations,
	SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location,
		dea.date) AS rolling_vaccinations
FROM
	"Covid_Deaths" dea
	JOIN "Covid_Vaccinations" vac ON dea.location = vac.location
		AND dea.date = vac.date
WHERE
	dea.continent <> ''
ORDER BY
	2, 3;

/*Common Table Expression (CTE) for population vs. vaccinations*/
WITH pop_vs_vaccin (
	continent,
	LOCATION,
	date,
	population,
	new_vaccinations,
	rolling_vaccinations
) AS (
	SELECT
		dea.continent,
		dea.location,
		dea.date,
		dea.population,
		vac.new_vaccinations,
		SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location,
			dea.date) AS rolling_vaccinations
	FROM
		"Covid_Deaths" dea
		JOIN "Covid_Vaccinations" vac ON dea.location = vac.location
			AND dea.date = vac.date
	WHERE
		dea.continent <> ''
)
SELECT
	*, (rolling_vaccinations / population) * 100 AS percent_population_vaccinated
FROM
	pop_vs_vaccin;

/* Creates a table for population vs. vaccination analysis */
CREATE TABLE percent_population_vaccinated (
	continent VARCHAR(255),
	LOCATION VARCHAR(255),
	date DATE,
	population NUMERIC,
	new_vaccinations NUMERIC,
	rolling_vaccinations NUMERIC
);

/* Inserts data into the table */
INSERT INTO percent_population_vaccinated
SELECT
	dea.continent,
	dea.location,
	dea.date,
	dea.population,
	vac.new_vaccinations,
	SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location,
		dea.date) AS rolling_vaccinations
FROM
	"Covid_Deaths" dea
	JOIN "Covid_Vaccinations" vac ON dea.location = vac.location
		AND dea.date = vac.date
WHERE
	dea.continent <> '';

/* Selects data from the percent_population_vaccinated table */
SELECT
	*,
	(rolling_vaccinations / population) * 100 AS percent_population_vaccinated
FROM
	percent_population_vaccinated;

/* Creates a view for storing data for later visualizations */
CREATE VIEW percent_population_vaccinated_view AS
SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_vaccinations
FROM
    "Covid_Deaths" dea
    JOIN "Covid_Vaccinations" vac ON dea.location = vac.location AND dea.date = vac.date
WHERE
    dea.continent <> '';
	
/*Selects data from the new view*/
SELECT
	*,
	(rolling_vaccinations / population) * 100 AS percent_population_vaccinated
FROM
	percentpopulationvaccinated_view;
