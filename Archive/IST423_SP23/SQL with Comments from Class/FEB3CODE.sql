
--- If you haven't created a table in your database run
CREATE TABLE teachers (
    id bigserial,
    first_name varchar(25),
    last_name varchar(50),
    school varchar(50),
    hire_date date,
    salary numeric
);
-- Use the following to populate it
INSERT INTO teachers (first_name, last_name, school, hire_date, salary)
VALUES ('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000),
       ('Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500),
       ('Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200),
       ('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500),
       ('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500),
       ('James', 'Smith', 'Myers Middle School', '2012-10-22', 28500),
       ('Steven', 'Pusher', 'F.D. Roosevelt HS', '2010-10-22', 45752),
       ('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500),
       ('Kimberly', 'Watson', 'Myers Middle School', '2018-10-28', 95500),
       ('Kyle', 'Kavanaugh', 'Sleepy Bee Elementary School', '2023-01-01', 30155),
       ('Samantha', 'Clinton', 'Myers Middle School', '2019-10-30', 36200),
       ('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200);
--When you're done check it using this
 Select * from teachers
 --- if you feel like you've messed up you can destroy your table and start from scratch
    ---First
 drop table teachers
    ---then  
 CREATE TABLE teachers (
    id bigserial,
    first_name varchar(25),
    last_name varchar(50),
    school varchar(50),
    hire_date date,
    salary numeric
);
   --- after that do this
INSERT INTO teachers (first_name, last_name, school, hire_date, salary)
VALUES ('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000),
       ('Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500),
       ('Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200),
       ('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500),
       ('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500),
       ('James', 'Smith', 'Myers Middle School', '2012-10-22', 28500),
       ('Steven', 'Pusher', 'F.D. Roosevelt HS', '2010-10-22', 45752),
       ('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500),
       ('Kimberly', 'Watson', 'Myers Middle School', '2018-10-28', 95500),
       ('Kyle', 'Kavanaugh', 'Sleepy Bee Elementary School', '2023-01-01', 30155),
       ('Samantha', 'Clinton', 'Myers Middle School', '2019-10-30', 36200),
       ('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200);
       --- last check
SELECT * from teachers
---

--- Some basic selects
SELECT 5 from teachers --- selects just the attribute in the 5th column spot 

SELECT school from teachers --- selects just the school column

SELECT (last_name, salary) from teachers --- selects last-name and salary as a single value into a new attribute

SELECT last_name, salary from teachers --- selects the last_name AND salary attributes

SELECT last_name, salary from teachers --- selects the last_name AND salary attributes
ORDER BY salary DESC ---orders the results by salary in descending order
---same thing but with all data
SELECT * FROM teachers
ORDER BY salary DESC

--- We can also only call a limited number of tuples
select * from teachers
LIMIT 10


--- By adding DISTINCT we can generate a list of the valuse contained 
select DISTINCT school from teachers ---What would happen if we passed two columns instead of one here?
 
--- We cam also call tables that meet a certain condition (having a particular value) using WHERE 
select id, school, salary, hire_date from teachers
where school = 'F.D. Roosevelt HS'
order by salary desc


select id, school, salary, hire_date from teachers
where school ='Myers Middle School'
order by salary des


select id, school, salary, hire_date from teachers
where school <> 'Myers Middle School'
order by salary desc

--- We can use the like and ilike comparisons to find things that are fuzzy matches to what we want
select first_name, school from teachers
where first_name like 'Sam%'

select first_name, school from teachers
where first_name like 'Sam_'

select first_name, school from teachers
where first_name like 'Sam___'