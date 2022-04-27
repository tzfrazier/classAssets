
# April 8, 2022
For class we have been using a series of tables today, after adding in some of the constraints we've talked about in class, we started to look at the types of questions we can answer from the data.
The relevant flat files we're importing from can be found in [the class repos flat files](https://github.com/tzfrazier/classAssets/blob/main/IST%20423/Flatfiles).
These files include tables with the following values:
### tables
#### MOCK_DATA
| id | first_name | last_name | email | gender | Company | City | Value |
| -- | ---------- | --------- | ----- | ------ | ------- | ----| ----- |
| Primary Key | Contact's First Name | Contact's Last Name |Contacts'Email| Company | City | Value of Contacts business |
#### DemoStaff
| Staff_No | Staff_F_Name | Staff_L_Name | Position | Salary | Office |
| -------- | ------------ | ------------ | --------| ------ | ------ |
| Primary Key | Staff's First Name| Staff's Last Name | Staff's Position | Staff's Salary | Office ID as a foreign Key |
#### DemoOffices
| LOC_ID | STREET | City | State | Zip |
| ------ | ------ | ---- | ----- | --- |
| Primary Key | Street Address | City | State code | zip |
#### ASSIGNED_Contacts
| Staff_ID | Contact_IDSel |
| -------- | ------------- |
| Staff_No from DemoStaff| id from MOCK_DATA |

## Interrogating the database
From this data set and the database set up in pgAdmin 4 using the scripts found [here](https://github.com/tzfrazier/classAssets/blob/main/IST%20423/CodeSnips/ARP8SNIPS1)  we decided to attempt to offer answers to the following questions that might be relevant to a commercial property management firm using such a data set (see flat files link above).

# April 14, 2022
Created views. These views answer questions about individual members, but could be used to create data which would answer the broader questions we seek to answer.
