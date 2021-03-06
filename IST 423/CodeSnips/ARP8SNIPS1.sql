DROP TABLE offices;
DROP TABLE assigned_contacts;
DROP TABLE contacts;
DROP TABLE staff;

 --Drop all tables;
/*Adding new tables with constraints*/

CREATE TABLE contacts ( --Creates contact table
  ID bigserial PRIMARY KEY, --Sets attribute of ID as bigserial. Will autoassign after bulk load.
  C_fName varchar(50) NOT NULL, -- Sets value for contact first name, prevents nulls
  C_lName varchar(75) NOT NULL, -- Sets value for contact last name, prevents nulls
  C_email varchar(75) UNIQUE NOT NULL, -- Sets value for contact email, prents nulls, must be unique
  Gender varchar(20), -- Sets value for contact gender, no constraints because no lables
  Company varchar(100), -- Sets value for contact company
  City varchar(50) NOT NULL, --
  Value bigint NOT NULL,
  CONSTRAINT potential_value CHECK (Value > 0)
);

CREATE TABLE offices (
  ID varchar(5) PRIMARY KEY,
  Street varchar(75) UNIQUE NOT NULL,
  City varchar(50) NOT NULL,
  State Char(2) NOT NULL,
  Zip varchar(5) NOT NULL,
  CONSTRAINT zip CHECK (Length(Zip)>4)
);

CREATE TABLE staff (
  ID varchar(5) PRIMARY KEY,
  S_fName varchar(50) NOT NUll,
  S_lName varchar(75) NOT NULL,
  S_position varchar(75) NOT NULL,
  Salary bigint NOT NUll,
  Office varchar(5) REFERENCES offices (ID),
  CONSTRAINT payroll CHECK (Salary > 0)
);

CREATE TABLE assigned_contacts (
  Staff_id varchar(5) NOT NULL REFERENCES staff (ID),
  Contact_ID bigint NOT NULL REFERENCES contacts (ID)
);

COPY contacts
FROM 'C:\Users\Public\Mock_data.csv'
WITH (FORMAT CSV, HEADER);

COPY offices
FROM 'C:\Users\Public\DemoOffices.csv'
WITH (FORMAT CSV, HEADER);

COPY Staff
FROM 'C:\Users\Public\DemoStaff.csv'
WITH (FORMAT CSV, HEADER);

COPY assigned_contacts
FROM 'C:\Users\Public\Assigned_Contacts.csv'
WITH (FORMAT CSV, HEADER);
