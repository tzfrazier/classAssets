/* CREATING VIEWS
This tutorial covers creating a view in postgresql using sql commands
*/
CREATE OR REPLACE VIEW unassignedcontacts AS --Creates a view called unassignedcontacts. The AS serves to point the DBMS to what will be in the view
Select staff.S_fName, staff.S_lName, contacts.C_fName, contacts.c_lname -- Because the view will pull data from two tables we're using a select statement like what's used in join queries.
FROM staff LEFT JOIN assigned_contacts ON staff.id = assigned_contacts.Staff_id -- Joins staff to assigned_contacts
RIGHT JOIN contacts ON assigned_contacts.contact_id = contacts.id -- Joins contacts to assigned contacts so now the data between the two is bridged. The right join generates nulls where contacts aren't paired with staff members.
WHERE staff.S_fName IS NULL --filters out assigned pairs by only selecting data where the staff feilds are null, as the null is the result of their being a contact with out a staff memeber in the assigned_contacts relation.
ORDER BY staff.S_fName DESC -- actually exteranious. But
SELECT * FROM unassignedcontacts JOIN contacts ON unassignedcontacts.C_FNAME = contacts.C_Fname

/* Creating a view that summarizes data in a table */
CREATE OR REPLACE VIEW  staffcontactload AS --Creates teh view
SELECT staff.id, --Selects the id from staff. Because this is a primray key, there should only be one of each value
  count(contacts.id) AS count -- tells the DMBS to count each contact id
  /*Join statement*/
   FROM staff
     LEFT JOIN assigned_contacts ON staff.id::text = assigned_contacts.staff_id::text
     RIGHT JOIN contacts ON assigned_contacts.contact_id = contacts.id
  GROUP BY staff.id --This groups the data by each staff id, then the count command is run on that subset of the data
  ORDER BY (count(contacts.id)); --orders it so that ids are ranked by the count value.

/* Create a view that shows how much each staff member can bring in in terms of revenue. */
CREATE OR REPLACE VIEW  staffcontactvalue AS --Creates a view to see how much each staff member could bring in.
  SELECT staff.id,
   sum(contacts.value) AS sum -- this is functioning the same way as the above count. It is useful to note that this naming is a terrible, and another column name should probably be used.
   /*Join for view */
  FROM staff
    LEFT JOIN assigned_contacts ON staff.id::text = assigned_contacts.staff_id::text
    RIGHT JOIN contacts ON assigned_contacts.contact_id = contacts.id
 GROUP BY staff.id -- Again we are using a group by statement to break out each set of values related to a staff id, and then running math functions based on each subset.
 ORDER BY (sum(contacts.value));
/*A cool thing about views is that we can create dirivitives from views using joins in the same we do for relations*/
 /*Using the contact load and contact value to find out who's working with the highest value contacts.*/
 /* This will be made with a simple select, but can easily be used in creating another view, though we may want to create such a view from the relations rather than views if possible*/
 SELECT staffcontactvalue.id,
  staffcontactvalue.sum / staffcontactload.count  as avgValue -- This second clause is a math statement divides the number of contacts each staff has by the total value of those contacts and stores the results as
FROM staffcontactload
JOIN staffcontactvalue ON staffcontactload.id = staffcontactvalue.id -- simple join.
/* Because the data we are manipulating already is one tuple to one id value, we do not have to use a group by statement here.*/
ORDER BY avgValue
