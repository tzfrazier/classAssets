/* Which staff members work with which contacts? */
-- Will use a join to create a list
SELECT staff.S_fName, staff.S_lName, contacts.C_fName , contacts.C_lname --Select the fields neeed to make a human readable list
FROM staff JOIN assigned_contacts on staff.id = assigned_contacts.Staff_ID -- Joins staff relation to the assigned contacts relation
JOIN contacts on assigned_contacts.Contact_ID = contacts.id -- Joins contacts to the previous join, allowing for contact first and last names to be present
order by staff.S_lName asc --The result of the previous join is slightly messy. adding in the ordering statement makes it easier to read

/* Which staff don't have an assigned contact? */
-- We can answer this question by changing our first joint to a left join. this will include all instances of the first relation in the select table.
SELECT staff.S_fName, staff.S_lName, contacts.C_fName , contacts.C_lname --Select the fields neeed to make a human readable list
FROM staff LEFT JOIN assigned_contacts on staff.id = assigned_contacts.Staff_ID -- Joins staff relation to the assigned contacts relation
JOIN contacts on assigned_contacts.Contact_ID = contacts.id -- Joins contacts to the previous join, allowing for contact first and last names to be present
WHERE  contacts.C_fName = null -- Selects only instances where no contact value is present.

/* Which contacts don't have an assigned staff?*/
--similar to the above, but will reverse the direcionality making the left join a normal join, and the second join a right join. asls well chage the where
SELECT staff.S_fName, staff.S_lName, contacts.C_fName , contacts.C_lname --Select the fields neeed to make a human readable list
FROM staff JOIN assigned_contacts on staff.id = assigned_contacts.Staff_ID -- Joins staff relation to the assigned contacts relation
RIGHT JOIN contacts on assigned_contacts.Contact_ID = contacts.id -- Joins contacts to the previous join, allowing for contact first and last names to be present
WHERE staff.S_fName = null -- Selects only instances where no contact value is present.

/* What is the total potential value of each offices? */
-- For this we only need to select one table. Since it's apparent that each city for contacts has an office, we can simply select by city using a group by
SELECT city, sum(value) --selects the city attribute, and adds the value of the value cells together
FROM contacts --specifies the relation
GROUP BY City --the group by statement groups the tuples together by the value of the field before the math is run, this each city has a sum for the values of that city
ORDER BY sum desc -- This orders them by highest to lowest values
