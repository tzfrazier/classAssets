-- Joins -- 
CREATE TABLE district_2020 (
    id integer CONSTRAINT id_key_2020 PRIMARY KEY,
    school_2020 text
);
--
CREATE TABLE district_2035 (
    id integer CONSTRAINT id_key_2035 PRIMARY KEY,
    school_2035 text
);

INSERT INTO district_2020 VALUES
    (1, 'Oak Street School'),
    (2, 'Roosevelt High School'),
    (5, 'Dover Middle School'),
    (6, 'Webutuck High School');

INSERT INTO district_2035 VALUES
    (1, 'Oak Street School'),
    (2, 'Roosevelt High School'),
    (3, 'Morrison Elementary'),
    (4, 'Chase Magnet Academy'),
    (6, 'Webutuck High School');

    -- Our First Join
    SELECT * -- selects all the columns from both tables
FROM district_2020 JOIN district_2035 -- Specifies that the select statement is a JOIN
ON district_2020.id = district_2035.id -- Specifies which column the join opperation occurs on
ORDER BY district_2020.id; -- Orders the resulting table

-- You notices that two schools are missing from the list? Why?
-- Hint using an inner join will produce the same results

SELECT *
FROM district_2020 JOIN district_2035
USING (id)
ORDER BY district_2020.id;
--Note: ON is more general than USING()

-- Using LEFT JOIN
-- A left join will include all values of the leftest table and produce NULL values where not in allignment
SELECT *
FROM district_2020 LEFT JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

-- Listing 7-7: Using RIGHT JOIN
-- A right join will include all values of the right most table and produce NULL values where not in allignment
SELECT *
FROM district_2020 RIGHT JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2035.id;

SELECT *
FROM district_2020 FULL OUTER JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

-- If we have time Lets do math
-- https://github.com/anthonydb/practical-sql-2/blob/main/Chapter_07
-- Our process 
    --1 Download CSV and put it where its usable
    --2 Create table
    --3 Upload data
    --4 write select statement


CREATE TABLE us_counties_pop_est_2010 (
    state_fips text,                         -- State FIPS code
    county_fips text,                        -- County FIPS code
    region smallint,                         -- Region
    state_name text,                         -- State name
    county_name text,                        -- County name
    estimates_base_2010 integer,             -- 4/1/2010 resident total population estimates base
    CONSTRAINT counties_2010_key PRIMARY KEY (state_fips, county_fips)
);

COPY us_counties_pop_est_2010
FROM 'C:\YourDirecSelectory\us_counties_pop_est_2010.csv'
WITH (FORMAT CSV, HEADER);

SELECT c2019.county_name,
       c2019.state_name,
       c2019.pop_est_2019 AS pop_2019,
       c2010.estimates_base_2010 AS pop_2010,
       c2019.pop_est_2019 - c2010.estimates_base_2010 AS raw_change,
       round( (c2019.pop_est_2019::numeric - c2010.estimates_base_2010)
           / c2010.estimates_base_2010 * 100, 1 ) AS pct_change
FROM us_counties_pop_est_2019 AS c2019
    JOIN us_counties_pop_est_2010 AS c2010
ON c2019.state_fips = c2010.state_fips
    AND c2019.county_fips = c2010.county_fips

ORDER BY pct_change DESC;

-- Code adapated from Anthony Deborros's, Practical SQL (2nd edition), No Starch Press, 2022