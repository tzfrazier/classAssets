-- Code modiftied and adapted from DeBarros, Practical SQL 2nd Edition Github/book
--First we'll run through DeBarros's examples
-- Start bu creating a table that aligns with census data
CREATE TABLE us_counties_pop_est_2019 (
    state_fips text,                         -- State FIPS code
    county_fips text,                        -- County FIPS code
    region smallint,                         -- Region
    state_name text,                         -- State name	
    county_name text,                        -- County name
    area_land bigint,                        -- Area (Land) in square meters
    area_water bigint,                       -- Area (Water) in square meters
    internal_point_lat numeric(10,7),        -- Internal point (latitude)
    internal_point_lon numeric(10,7),        -- Internal point (longitude)
    pop_est_2018 integer,                    -- 2018-07-01 resident total population estimate
    pop_est_2019 integer,                    -- 2019-07-01 resident total population estimate
    births_2019 integer,                     -- Births from 2018-07-01 to 2019-06-30
    deaths_2019 integer,                     -- Deaths from 2018-07-01 to 2019-06-30
    international_migr_2019 integer,         -- Net international migration from 2018-07-01 to 2019-06-30
    domestic_migr_2019 integer,              -- Net domestic migration from 2018-07-01 to 2019-06-30
    residual_2019 integer,                   -- Residual for 2018-07-01 to 2019-06-30
    CONSTRAINT counties_2019_key PRIMARY KEY (state_fips, county_fips)	--!Pay Attention this line and these feilds when we check to make sure our table was created right!
);
--Let us see what that generated
SELECT * FROM us_counties_pop_est_2019;
--Notice State and county FIPS feilds are functioning as a combined primary key
--Download https://github.com/anthonydb/practical-sql-2/blob/main/Chapter_05/us_counties_pop_est_2019.csv
--Now we want to copy the data file in the database
-- We will use the COPY FROM WITH convention
--COPY tells the DBMS that something will be copied to an existing table FROM is the directions to that file and WITH allows us to give it more specific parameters to smooth the process out

COPY us_counties_pop_est_2019
FROM 'C:\YourDirectory\us_counties_pop_est_2019.csv' --This needs to be edited. Also Note the virtual machine give PGADMIN limited Read/write permissions so you will want to probably put this file as close to the C drive as possible
--ALT Google how to adjust permission structures and run though those steps. ALT NOTE: NOT SUPPORTED FOR CLASS
WITH (FORMAT CSV, HEADER);

--OK now run a select to see how the data has populated!
SELECT * FROM us_counties_pop_est_2019;
-- AS a Bonus we will see the top three counties that have the biggest land area
SELECT county_name, state_name, area_land -- Select the fields we are interested in
FROM us_counties_pop_est_2019 -- specify the table we are querying
ORDER BY area_land DESC -- orders the table by land area
LIMIT 3; -- shows only the top 3 results

----------------------------------------------------------------------------

-- PART 2--
--Now we will create a table in our project database.
--First step is to create the database. Go up to the top of the file tree in our PGADMIN explorer
--RIGHT CLICK > Select CREATE > Select Database > Create a Database BBBooks
-- If that works 2 thumbs way up!
-- Open a new query tool window targetting BBBooks
-- Download this file https://github.com/tzfrazier/classAssets/blob/main/IST423%20Spring%202024/Location.csv move it to where you move the other one 
-- If you are a superstar and googled and changed your permission levels for your download folder you can skip that last bit. 
-- Ok, now we'll look at the file, and create a table. 
CREATE TABLE locations (
LocID text,
LocType text,
Street text,
City text,
State text,
ZIP text,
CONSTRAINT loacations PRIMARY KEY (LocID));

--check it using a select
SELECT * FROM locations

-- Ok, now we'll upload the file from our data file we downloaded
COPY locations 
FROM C:\YourDirectory\location.csv
With (FORMAT csv, HEADER);


-- Run a select to check
SELECT * FROM locations

--if it works we're good to go!
