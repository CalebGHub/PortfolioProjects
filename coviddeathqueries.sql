/* looking at death percentage */

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from CovidDeaths1
where location like '%states'

/* what countries have highest infection rate */

select location, population, max(total_cases), max((total_cases/population))*100 as percentpopulationinfected
from CovidDeaths1
group by location, population
order by percentpopulationinfected desc

/*what countries have highest death count per population */

select location, max(cast(total_deaths as int)) as TotalDeathCount
from CovidDeaths1
where continent is not NULL
group by location
order by TotalDeathCount DESC

/* global numbers for death percentage*/

select date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From CovidDeaths1
where continent is not NULL
order by 1,2


/* global data that shows how new_cases affect death percentage*/

select date, sum(new_cases) as totalnewcases, sum(cast(new_deaths as int)) as totaldeaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as deathpercentage
from CovidDeaths1
where continent is not NULL
group by date
order by date

/* USA On what day did USA have the highest infection rate */

select date, new_cases, location
from CovidDeaths1
where location = "United States"
order by new_cases DESC
limit 1

/* what is the total population of vaccinated accrued over time*/
/* Using CTE */

With PopvsVac ( continent, location, date , population, new_vaccinations, AccumulationOFVaccination) as
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) OVER (partition by dea.location order by dea.location, dea.date) as AccumulationOFVaccination
from CovidDeaths1 dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not NULL
)
Select *, (AccumulationOFVaccination/population)*100
From PopvsVac 



Create View PercentPopulationVaccinated as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) OVER (partition by dea.location order by dea.location, dea.date) as AccumulationOFVaccination
from CovidDeaths1 dea
join CovidVaccinations vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not NULL