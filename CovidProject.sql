/*
Covid 19 Data Exploration

*/



SELECT *
FROM CovidProject..CovidDeaths$

SELECT *
FROM CovidProject..CovidVaccinations$

--Select  data that we are going to work with

SELECT location,date,population,total_cases,new_cases,total_deaths
FROM CovidProject..CovidDeaths$
WHERE continent is not null
ORDER BY location, date

--Greece
SELECT location,date,population,total_cases,new_cases,total_deaths
FROM CovidProject..CovidDeaths$
WHERE continent is not null
AND location like '%Greece%'
ORDER BY location,date

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in  Greece

SELECT Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM CovidProject..CovidDeaths$
WHERE location like '%Greece'
and continent is not null 
ORDER BY location,date

-- Total Cases vs Population in Greece
-- Shows what percentage of population infected with Covid

SELECT Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
FROM CovidProject..CovidDeaths$
WHERE location like'%Greece%' 
AND continent is not null
ORDER BY location,date

--Weekly hospital admissions in Greece

SELECT location ,date, population,weekly_hosp_admissions 
FROM CovidProject..CovidDeaths$
WHERE location like '%Greece%'
AND continent  is not null
ORDER BY date

-- Continents with Highest Death Count per Population

SELECT continent, MAX(cast(Total_deaths as int)) as CountDeaths
FROM CovidProject..CovidDeaths$
WHERE continent is not null 
GROUP BY continent
ORDER BY CountDeaths desc


--Countries with Highest Death Count per Population

SELECT location, MAX(cast(Total_deaths as int)) as CountDeaths
FROM CovidProject..CovidDeaths$
WHERE continent is not null 
GROUP BY location
ORDER BY CountDeaths desc

--Total Deaths in Greece

SELECT location, MAX(cast(Total_deaths as int)) as CountDeaths
FROM CovidProject..CovidDeaths$
WHERE continent is not null 
AND location like '%Greece%'
GROUP BY location
ORDER BY CountDeaths desc

--JOIN

SELECT *
FROM CovidProject..CovidDeaths$ dea
JOIN CovidProject..CovidVaccinations$ vac
   on dea.location = vac.location
   AND dea.date = vac.date



--Total amount of people in World who have been vaccinated

SELECT dea.continent, dea.location,dea.date,dea.population, vac.people_fully_vaccinated
FROM CovidProject..CovidDeaths$ dea
JOIN CovidProject..CovidVaccinations$ vac
   on dea.location = vac.location
   AND dea.date = vac.date
WHERE dea.continent is not null
ORDER BY dea.location, dea.date


--Total amount of people in Greece who have been fully_vacinated

SELECT dea.continent, dea.location,dea.date,dea.population, vac.people_fully_vaccinated
FROM CovidProject..CovidDeaths$ dea
JOIN CovidProject..CovidVaccinations$ vac
   on dea.location = vac.location
   AND dea.date = vac.date
WHERE dea.continent is not null
AND dea.location like '%Greece%'
ORDER BY dea.location,dea.date












