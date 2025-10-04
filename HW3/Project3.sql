/* **********************************************************************************************
Katrina Cwiertniewicz
10/1/2025
Introduction to Data Science: Project 3
************************************************************************************************ */
set SQL_SAFE_UPDATES=0;
set FOREIGN_KEY_CHECKS=0;

use project3;

select count(*) from life_expectancy_data;

-- Delete all rows with population = 0. Perform further data cleaning for other attributes, as necessary.
/* The original dataset included 1108 rows.*/
delete from life_expectancy_data
where Population = 0;


/* All values for Gross Domestic Product and Percentage Expenditure are left with all decimal values to keep values accurate but will be rounded to 2 decimal places for queries.
All values for Population will be rounded to a whole number.*/

 
-- Display total count of countries after data cleaning.
select count(*) from life_expectancy_data;


-- List of countries with the highest and lowest average mortality rates (years 2010-2015)
(select 'Highest' as category, Country, round(avg(Adult_Mortality),2) as avg_mortality
from life_expectancy_data
group by Country
having avg(Adult_Mortality) = (
	select max(avg_mortality) 
    from (select avg(Adult_Mortality) as avg_mortality
    from life_expectancy_data
    group by country 
    ) as temp
))

union

(select 'Lowest' as category, Country, round(avg(Adult_Mortality),2) as avg_mortality
from life_expectancy_data
group by Country
having avg(Adult_Mortality) = (
	select min(avg_mortality) 
    from (select avg(Adult_Mortality) as avg_mortality
    from life_expectancy_data
    group by country 
    ) as temp
));

-- List of countries with the highest and lowest average population (years 2010-2015)
(select 'Highest' as category, Country, round(avg(Population)) as avg_population
from life_expectancy_data
group by Country
having avg(Population) = (
	select max(avg_population) 
    from (select avg(Population) as avg_population
    from life_expectancy_data
    group by country 
    ) as temp
))

union

(select 'Lowest' as category, Country, round(avg(Population)) as avg_population
from life_expectancy_data
group by Country
having avg(Population) = (
	select min(avg_population) 
    from (select avg(Population) as avg_population
    from life_expectancy_data
    group by country 
    ) as temp
));

-- List of countries with the highest and lowest average GDP (years 2010-2015)
(select 'Highest' as category, Country, round(avg(GDP),2) as avg_GDP
from life_expectancy_data
group by Country
having avg(GDP) = (
	select max(avg_GDP) 
    from (select avg(GDP) as avg_GDP
    from life_expectancy_data
    group by country 
    ) as temp
))

union

(select 'Lowest' as Category, Country, round(avg(GDP),2) as avg_GDP
from life_expectancy_data
group by Country
having avg(GDP) = (
	select min(avg_GDP) 
    from (select avg(GDP) as avg_GDP
    from life_expectancy_data
    group by country 
    ) as temp
));

-- List of countries with the highest and lowest average Schooling (years 2010-2015)
(select 'Highest' as category, Country, round(avg(Schooling),2) as avg_Schooling
from life_expectancy_data
group by Country
having avg(Schooling) = (
	select max(avg_Schooling) 
    from (select avg(Schooling) as avg_Schooling
    from life_expectancy_data
    group by country 
    ) as temp
))

union

(select 'Lowest' as Category, Country, round(avg(Schooling),2) as avg_Schooling
from life_expectancy_data
group by Country
having avg(Schooling) = (
	select min(avg_Schooling) 
    from (select avg(Schooling) as avg_Schooling
    from life_expectancy_data
    group by country 
    ) as temp
));

-- Which countries have the highest and lowest average alcohol consumption (years 2010-2015)?
(select 'Highest' as category, Country, round(avg(Alcohol),2) as avg_Alcohol
from life_expectancy_data
group by Country
having avg(Alcohol) = (
	select max(avg_Alcohol) 
    from (select avg(Alcohol) as avg_Alcohol
    from life_expectancy_data
    group by country 
    ) as temp
))

union

(select 'Lowest' as Category, Country, round(avg(Alcohol),2) as avg_Alcohol
from life_expectancy_data
group by Country
having avg(Alcohol) = (
	select min(avg_Alcohol) 
    from (select avg(Alcohol) as avg_Alcohol
    from life_expectancy_data
    group by country 
    ) as temp
));

-- Do densely populated countries tend to have lower life expectancy?
(with highest_populated as (
	select Country, round(avg(Population), 1) as avg_population, life_expectancy 
	from life_expectancy_data
	group by Country, life_expectancy
	order by avg_population desc
	limit 20
)
select 'Most Populated Countries' as category, round(avg(life_expectancy), 2) as 'Average Life Expectancy of Most Populated Countries'
from highest_populated)

union

(with lowest_populated as (
	select Country, round(avg(Population), 1) as avg_population, life_expectancy 
	from life_expectancy_data
	group by Country, life_expectancy
	order by avg_population 
	limit 20
)
select 'Least Populated Countries' as category, round(avg(life_expectancy), 2) as 'Average Life Expectancy'
from lowest_populated);



