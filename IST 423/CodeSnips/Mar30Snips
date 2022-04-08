/*A Simple join*/ -- We started with a simple join query
SELECT * --SElECT all statement to pull all the combined records
FROM staff JOIN offices -- Joins staff and offices together
on staff.office = offices.loc_id -- Specifies the fields to join. Because these aren't coded yet as PK/FK, there's some room for inconcruence here. We will fix that later.

/* Selecting attributes in a join a join */ -- A slightly more complex JOIN
SELECT staff.staff_f_name, staff.staff_l_name, staff.position, offices.street, offices.state, offices.zip -- Notice that relation.attribute convention for each of these feilds. Beccause we're selecting from more than one relation we need to have
FROM staff JOIN offices -- Selects the tables we want to join.
ON staff.office = offices.loc_id -- specifies the point of the join.
/*One could use the above join to generate a staff directory*/
/*Joining more than one table*/
SELECT staff.staff_f_name, staff.staff_l_name, staff.position, offices.street, offices.state, offices.zip, contacts.l_name -- Selects fields from all three tables
FROM staff JOIN offices ON staff.office = offices.loc_id -- First join
JOIN contacts ON offices.city = contacts.city -- Second join. Not that
-- This query returns essentially a junk table which shows why we need to have some constraints and
/*
At this point we added FK and PK using the pgAdmin 4 GUI
*/
/* Looking at value using a join*/
-- Let's see if we can figure out which staff are making the most in each office
/* Joining the contacts table to the staff table*/
-- Start by writing a query that takes the three relations and connects them
SELECT * --this will have all the rows, we can do more targeted selects later
FROM staff -- Select the statff table
JOIN assigned_contacts ON staff.ID = ASSIGNED_Contacts.Staff_id --connects staff to assigned_contacts table
RIGHT JOIN contacts on ASSIGNED_Contacts.Contact_ID = contactS.id  --joins the contacts to that join. I have used a right join here beccasue it will include any contacts that aren't assigned to a staff member. Using join would only generate a list of assigned contacts. One flaw with previous join, is that if any staff members don't have an assigned contacts they won't be in the end result, but we can probably do something to catch that as another query.
/* Select data for an office*/
SELECT * --Selects all attributes
FROM staff
JOIN assigned_contacts ON staff.ID = ASSIGNED_Contacts.Staff_id
RIGHT JOIN contacts on ASSIGNED_Contacts.Contact_ID = contactS.id
WHERE city = 'Auburn' -- Activates a filter with teh condiction where the city attribute has the value Auburn. Technically this pulls from the contacts relation side of the join. But because there's only one city field after the join anyway, it doesn't have to be specified. contacts.city could also be used for city if you did a big join with the offices table joined in as well. That way you would still pull nulls.
/*

?*
/*Joining some feilds*/ -- Here we attempt to pull specific feilds and make the resulting queiry
SELECT staff.staff_f_name, staff.staff_l_name, staff.position, contacts.company, contacts.value --Selects the staffs first and last name, and also the company of the contact they work with and the value of that company's business.
FROM staff
JOIN assigned_contacts ON staff.ID = ASSIGNED_Contacts.Staff_id
RIGHT JOIN contacts on ASSIGNED_Contacts.Contact_ID = contactS.id -- Same as the other ones
WHERE city = 'Auburn'
Order by Staff.ID Desc -- This line sorts the queries results so we can see more visually who is doing what
