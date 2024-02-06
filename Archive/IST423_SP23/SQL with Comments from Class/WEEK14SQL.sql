CREATE OR REPLACE VIEW nevada_counties_pop_2019 AS
    SELECT county_name,
           state_fips,
           county_fips,
           pop_est_2019
    FROM us_counties_pop_est_2019
    WHERE state_name = 'Nevada';

-- Listing 17-2: Querying the nevada_counties_pop_2019 view

SELECT *
FROM nevada_counties_pop_2019
ORDER BY county_fips
LIMIT 5;

-- Listing 17-3: Creating a view showing population change for US counties

CREATE OR REPLACE VIEW county_pop_change_2019_2010 AS
    SELECT c2019.county_name,
           c2019.state_name,
           c2019.state_fips,
           c2019.county_fips,
           c2019.pop_est_2019 AS pop_2019,
           c2010.estimates_base_2010 AS pop_2010,
           round( (c2019.pop_est_2019::numeric - c2010.estimates_base_2010)
               / c2010.estimates_base_2010 * 100, 1 ) AS pct_change_2019_2010
    FROM us_counties_pop_est_2019 AS c2019
        JOIN us_counties_pop_est_2010 AS c2010
    ON c2019.state_fips = c2010.state_fips
        AND c2019.county_fips = c2010.county_fips;

-- Listing 17-4: Selecting columns from the county_pop_change_2019_2010 view

SELECT county_name,
       state_name,
       pop_2019,
       pct_change_2019_2010
FROM county_pop_change_2019_2010
WHERE state_name = 'Nevada'
ORDER BY county_fips
LIMIT 5;

-- Listing 17-5: Creating a materialized view

DROP VIEW nevada_counties_pop_2019;

CREATE MATERIALIZED VIEW nevada_counties_pop_2019 AS
    SELECT county_name,
           state_fips,
           county_fips,
           pop_est_2019
    FROM us_counties_pop_est_2019
    WHERE state_name = 'Nevada';

-- Listing 17-6: Refreshing a materialized view 

REFRESH MATERIALIZED VIEW nevada_counties_pop_2019;

-- Optionally add the CONCURRENTLY keyword to prevent locking out SELECTs
-- while the view refresh is in progress. To use CONCURRENTLY, the view must
-- have at least one UNIQUE index:

CREATE UNIQUE INDEX nevada_counties_pop_2019_fips_idx ON nevada_counties_pop_2019 (state_fips, county_fips);
REFRESH MATERIALIZED VIEW CONCURRENTLY nevada_counties_pop_2019;

-- To drop a materialized view, use:
-- DROP MATERIALIZED VIEW nevada_counties_pop_2019;

CREATE TABLE departments (
    dept_id integer,
    dept text,
    city text,
    CONSTRAINT dept_key PRIMARY KEY (dept_id),
    CONSTRAINT dept_city_unique UNIQUE (dept, city)
);

CREATE TABLE employees (
    emp_id integer,
    first_name text,
    last_name text,
    salary numeric(10,2),
    dept_id integer REFERENCES departments (dept_id),
    CONSTRAINT emp_key PRIMARY KEY (emp_id)
);

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


-- Listing 17-7: Creating a view on the employees table

-- Optional: Check the emplyees table:
SELECT * FROM employees ORDER BY emp_id;

-- Create view:
CREATE OR REPLACE VIEW employees_tax_dept WITH (security_barrier) AS
     SELECT emp_id,
            first_name,
            last_name,
            dept_id
     FROM employees
     WHERE dept_id = 1
     WITH LOCAL CHECK OPTION;

SELECT * FROM employees_tax_dept ORDER BY emp_id;

-- Listing 17-8: Successful and rejected inserts via the employees_tax_dept view

INSERT INTO employees_tax_dept (emp_id, first_name, last_name, dept_id)
VALUES (5, 'Suzanne', 'Legere', 1);

INSERT INTO employees_tax_dept (emp_id, first_name, last_name, dept_id)
VALUES (6, 'Jamil', 'White', 2);

SELECT * FROM employees_tax_dept ORDER BY emp_id;

SELECT * FROM employees ORDER BY emp_id;

-- Listing 17-9: Updating a row via the employees_tax_dept view

UPDATE employees_tax_dept
SET last_name = 'Le Gere'
WHERE emp_id = 5;

SELECT * FROM employees_tax_dept ORDER BY emp_id;

-- Bonus: This will fail because the salary column is not in the view
UPDATE employees_tax_dept
SET salary = 100000
WHERE emp_id = 5;

-- Listing 17-10: Deleting a row via the employees_tax_dept view

DELETE FROM employees_tax_dept
WHERE emp_id = 5;