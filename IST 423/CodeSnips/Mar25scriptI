/*Delete old tables */
DROP TABLE contacts; --Deletes the assigned contact table from database
DROP TABLE assignedcontacts; --Deletes the contacts TABLE
/* Create tables to load data into */
CREATE TABLE contacts (  -- Creates table
  id varchar(5), -- Creates ID feilds
  f_name varchar(75), -- Create field for fist names
  l_name varchar(75), -- Create field for last names
  email varchar(175), -- Create email field
  gender varchar(50), -- Create gender field
  company varchar(100), -- Create company name field
  City varchar(75), -- Create City field
  Value int -- Create contact value feild
);

CREATE TABLE assigned_contacts ( -- Creates table
  Staff_ID varchar(5),
  Contact_ID Varchar(5)
) ;

COPY assigned_contacts
FROM 'C:\Users\Public\Assigned_Contacts.csv'
WITH (FORMAT CSV, HEADER);
