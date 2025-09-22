/* **********************************************************************************************
Katrina Cwiertniewicz
9/9/2025
Introduction to Data Science: Project 2, Problem 2
************************************************************************************************ */
set SQL_SAFE_UPDATES=0;
set FOREIGN_KEY_CHECKS=0;


-- Create table of child_mortality
CREATE TABLE child_mortality(
   year      INTEGER  NOT NULL
  ,underfive NUMERIC(5,1)
  ,infant    NUMERIC(5,1)
  ,neonatal  NUMERIC(5,1)
);


-- Update table to replace all missing values in a column by the medians: underfive
set @row_index := -1;

select avg(t.underfive) into @median_value
from (
	select @row_index:=@row_index + 1 as row_index, 
    child_mortality.underfive as underfive
    from child_mortality
    where child_mortality.underfive is not null
    order by child_mortality.underfive) as t
where t.row_index
in (floor(@row_index / 2), ceil(@row_index / 2));

select @median_value;

update child_mortality 
set underfive = @median_value
where underfive is null;

-- Update table to replace all missing values in a column by the medians: infant
set @row_index := -1;

select avg(t.infant) into @median_value2
from (
	select @row_index:=@row_index + 1 as row_index, 
    child_mortality.infant as infant
    from child_mortality
    where child_mortality.infant is not null
    order by child_mortality.infant) as t
where t.row_index
in (floor(@row_index / 2), ceil(@row_index / 2));

select @median_value2;

update child_mortality 
set infant = @median_value2
where infant is null;

-- Update table to replace all missing values in a column by the medians: neonatal
set @row_index := -1;

select avg(t.neonatal) into @median_value3
from (
	select @row_index:=@row_index + 1 as row_index, 
    child_mortality.neonatal as neonatal
    from child_mortality
    where child_mortality.neonatal is not null
    order by child_mortality.neonatal) as t
where t.row_index
in (floor(@row_index / 2), ceil(@row_index / 2));

select @median_value3;

update child_mortality 
set neonatal = @median_value3
where neonatal is null;


-- Display the entire table 
SELECT * FROM child_mortality;


-- Which years have the lowest and highest infant mortality years, respectively?
(select "Lowest" as category, year, infant
from child_mortality
order by infant 
limit 1)
union all
(select "Highest" as category, year, infant
from child_mortality
order by infant desc
limit 1);


-- In what years were the neonatal mortality rates above average?
select year, neonatal as "Above Average Neonatal Mortality Rates"
from child_mortality 
where neonatal > (select avg(neonatal) from child_mortality);


-- Display the sorted infant mortality rates in descending order.
select infant as "Infant Mortality Rates in Descending Order"
from child_mortality 
order by infant desc;

-- Display min, max, mean, variance, and standard deviation for each mortality rate. 
select min(underfive) as "Minimum Underfive", max(underfive) as "Maximum Underfive", 
round(avg(underfive), 2) "Mean Underfive", round(variance(underfive), 2) as "Variance Underfive", round(stddev(underfive), 2) as "Standard Deviation Underfive"
from child_mortality;

select min(infant) as "Minimum Infant", max(infant) as "Maximum Infant", 
round(avg(infant), 2) "Mean Infant", round(variance(infant), 2) as "Variance Infant", round(stddev(infant), 2) as "Standard Deviation Infant"
from child_mortality;

select min(neonatal) as "Minimum Neonatal", max(neonatal) as "Maximum Neonatal", 
round(avg(neonatal), 2) "Mean Neonatal", round(variance(neonatal), 2) as "Variance Neonatal", round(stddev(neonatal), 2) as "Standard Deviation Neonatal"
from child_mortality;

-- Add a new column called Above-Five Mortality Rate and populate it with appropriate values. Hint: Use Alter Table Add Column.
alter table child_mortality
add abovefive numeric(5,1);

update child_mortality
set abovefive = case year
	when 1990 then 122.6
	when 1991 then 120.9
	when 1992 then 119.3
	when 1993 then 117.6
	when 1994 then 116.8
	when 1995 then 114.8
    when 1996 then 112.3
    when 1997 then 110.2
    when 1998 then 107.9
    when 1999 then 105.0
    when 2000 then 101.5
    when 2001 then 97.9
    when 2002 then 93.7
    when 2003 then 89.8
    when 2004 then 86.5
    when 2005 then 82.5
    when 2006 then 78.4
    when 2007 then 74.2
    when 2008 then 71.3
    when 2009 then 67.6 
    when 2010 then 64.5
    when 2011 then 61.4
    when 2012 then 58.6
    when 2013 then 55.9
    when 2014 then 53.2
    when 2015 then 51.5
    when 2016 then 49.5
		end;

-- Display the entire table again.
select * from child_mortality;


