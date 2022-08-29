CREATE TABLE Offices (
	LOC_ID varchar(10),
	Street varchar(75),
	City varchar(50),
	State varchar(15),
	Zip varchar (6)
);
CREATE TABLE Staff (
	id varchar(10),
	Staff_F_Name varchar(25),
	Staff_L_Name varchar(50),
	Position varchar(75),
	Salary int,
	Office varchar (6)
);
CREATE TABLE AssignedContacts (
	Staff_ID varchar(5),
	Contact_IDSel varchar(5)
);
