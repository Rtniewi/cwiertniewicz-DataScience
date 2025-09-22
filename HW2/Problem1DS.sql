/* **********************************************************************************************
Katrina Cwiertniewicz
9/7/2025
Introduction to Data Science: Project 2, Problem 1
************************************************************************************************ */
set SQL_SAFE_UPDATES=0;
set FOREIGN_KEY_CHECKS=0;


-- Create table of USArrests
CREATE TABLE usarrests(
   state    VARCHAR(14) NOT NULL
  ,murder   NUMERIC(4,1) NOT NULL
  ,assault  INTEGER 
  ,urbanPop INTEGER  NOT NULL
);

-- Update table to replace all missing values in a column by the average
update usarrests
set assault = (select avg_assault from (select avg(assault) as avg_assault
from usarrests where assault is not null) as temp) where assault is null;

SELECT * FROM project2.usarrests;

-- Find min, max, mean, and variance of all numeric attributes in SQL
select min(murder) as "Minimum Murder", max(murder) as "Maximum Murder", round(avg(murder), 2) "Mean Murder", round(variance(murder), 2) as "Variance Murder"
from usarrests;

select min(assault) as "Minimum Assault", max(assault) as "Maximum Assault", round(avg(assault), 2) "Mean Assault", round(variance(assault), 2) as "Variance Assault"
from usarrests;

select min(urbanPop) as "Minimum UrbanPop", max(urbanPop) as "Maximum UrbanPop", round(avg(urbanPop), 2) "Mean UrbanPop", round(variance(urbanPop), 2) as "UrbanPop"
from usarrests;

-- 1) Which state has the maximum murder rate?
select state as "State", max(murder) as "Maximum Murder Rate"
from usarrests
group by state
limit 1;

-- 2) List of states in ascending order of urban population percentages. 
select state as "State", urbanPop as "Urban Population"
from usarrests
order by urbanPop;


-- 3) How many states have higher murder rates than Arizona? List those states. 
select state, murder 
from usarrests as us
where murder > (
	select murder
    from usarrests 
    where state = 'Arizona'
);