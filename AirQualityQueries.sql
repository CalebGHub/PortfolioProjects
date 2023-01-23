/*What city is in hazardous air quality condition */

select country, city, AQIValue, AQICategory
FROM airpollution
where AQICategory is "Hazardous"
order by AQIValue DESC

/* Among the countries, how many city have hazardous air quality */

/* Found there are 158 hazardous cities in India and 13 in pakistan which is the 2 leading countries */

select country, count(distinct(city)) as NumberOfHazardousCities, round(avg(AQIValue),2) as Average_AQIValue
from airpollution
where AQICategory is "Hazardous"
group by Country
order by count(distinct(city)) DESC


/* What country has the worst air quality (not good indicator because too few data on some countries) */

Select Country, round(avg(AQIValue),2) as Average_AQIValue, count(distinct(city)) as NumberOfCities
from airpollution
group by Country
order by Average_AQIValue DESC


/* What 5 Cities in the United States have the lowest AQIValue */

SELECT country, City, AQIValue
From airpollution
WHERE Country like "%States%"
order by AQIValue
Limit 5;

/* What 5 Cities in the United States have the highest AQIValue */

SELECT *
From airpollution
WHERE Country like "%States%"
order by AQIValue DESC
Limit 5;

/* What country is most exposed to ozone depletion*/
/* found india, USA, China, Germany, Italy is among the highest */

SELECT country, count(city) as NumberOfCity, round(sum(OzoneAQIValue),2) as AvgOzone
From airpollution
group by Country
order by AvgOzone DESC




