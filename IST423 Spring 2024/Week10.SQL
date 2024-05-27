-- We will start by creating the example tables from the Debarros book
-- Table one creates a relation to track data related to departments
CREATE TABLE departments (
    dept_id integer,
    dept text,
    city text,
    CONSTRAINT dept_key PRIMARY KEY (dept_id),
    CONSTRAINT dept_city_unique UNIQUE (dept, city)
);
--notice the use of constraint and primary key
--Table is an employee relation
CREATE TABLE employees (
    emp_id integer,
    first_name text,
    last_name text,
    salary numeric(10,2),
    dept_id integer REFERENCES departments (dept_id),
    CONSTRAINT emp_key PRIMARY KEY (emp_id)
);
-- In line 17 notice the REFERENCE parameter. What do you think would happen if we created the employee table first?
-- Next we'll add some values. I will paste this into chat, but if you miss it.
INSERT INTO departments
VALUES
    (1, 'Tax', 'Atlanta'),
    (2, 'IT', 'Boston');

INSERT INTO employees
VALUES
    (1, 'Julia', 'Reyes', 115300, 1),
    (2, 'Janet', 'King', 98000, 1),
    (3, 'Arthur', 'Pappas', 72700, 2),
    (4, 'Michael', 'Taylor', 89500, 2);

--Let's try to add a 5th employee into employees with a unique value for their dept_id
INSERT INTO employees
VALUES
(
  5, 'Steve', 'Furiori', 11530, 3
);
--But what we are doing today is joins.
--TO return a staff list for the each location, lets join the tables together.
SELECT *
FROM employees JOIN departments
ON employees.dept_id = departments.dept_id
ORDER BY employees.dept_id;


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
