select * from [Covid deaths] order by 1,2
select location,date,population,total_cases,new_cases,total_deaths from [Covid deaths] order by 1,2

--Countries with highest infection rate
select location,population,max(total_cases) as highestInfection,max((total_cases/population))*100 as populationInfected from [Covid deaths] group by location,population order by populationInfected desc

--countries with highest death count
select location,population,max(cast(total_deaths as int)) as TotalDeathcount from [Covid deaths] where continent is not null group by location,population order by TotalDeathcount desc

--Continents with highest death count
select location,max(cast(total_deaths as int)) as TotalDeathcount from [Covid deaths] where continent is null group by location order by TotalDeathcount desc

--global numbers
select sum(new_cases) as totalcases,sum(cast(new_deaths as int)) as totaldeaths,sum(cast(new_deaths as int))/sum(new_cases) *100 as deathpercentage 
from [Covid deaths] where continent is not null order by 1,2


select * from [Covid vaccinations]

--joing 2 tables

select * from [Covid deaths] d join [Covid vaccinations] v on d.location = v.location and d.date=v.date
select d.continent,d.location,d.date,d.population,v.new_vaccinations from [Covid deaths] d join [Covid vaccinations] v on d.location = v.location and d.date=v.date where d.continent is not null order by 5 desc

--total population vs vaccinations
select d.continent,d.location,d.date,d.population,v.new_vaccinations, 
sum(cast(v.new_vaccinations as int)) over (partition by d.location order by d.location,d.date) as rollingpeoplevaccinated
from [Covid deaths] d join [Covid vaccinations] v on d.location = v.location and d.date=v.date where d.continent is not null order by 2,3