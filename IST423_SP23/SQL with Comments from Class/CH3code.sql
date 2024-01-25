-- Create --
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
       ('Samantha', 'Clinton', 'Myers Middle School', '2011-10-30', 36200),
       ('James', 'Diaz', 'F.D. Roosevelt HS', '2004-07-12', 43500
-- Selects --

       -- ALL --
SELECT * FROM teachers;

-- Projections --
SELECT first_name, last_name FROM teachers;

-- Ordering --
SELECT last_name, school, hire_date
FROM teachers
ORDER By hire_date DESC;

-- Selections --
SELECT lastname, school, salary
FROM teachers
WHERE salary <= 40000;
