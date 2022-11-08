-- SQL Analysis
-- 1.
-- Retrieve number of projects for each outcome in descending order grouped by the outcome.
select outcome, count(outcome) number_of_projects from campaign
group by 1
order by count(outcome) desc;

-- 2. 
-- Display the percentage of the goal amount in descending order, along with the campaign outcome, 
-- the total goal and pledged amounts grouped by the campaign outcome.

select outcome, goal, pledged, round((pledged/goal)*100,2) || '%' percnt_of_goal from campaign
group by 1,2,3
order by (pledged/goal)*100 desc ; 

-- 3.
-- Display the percentage of the goal amount in descending order, along with the category name, 
-- the total goal and pledged amounts grouped by the category name.
select category_name, goal, pledged, round((pledged/goal)*100,2) || '%' percnt_of_goal from campaign cm
JOIN category ct
ON cm.category_id = ct.category_id
group by 1,2,3
order by (pledged/goal)*100 desc ;

-- 4.
-- Display the percentage of the goal amount in descending order, along with the subcategory name, 
-- the total goal and pledged amounts grouped by the subcategory name.

select category_name, goal, pledged, round((pledged/goal)*100,2) || '%' percnt_of_goal from campaign cm
JOIN category ct
ON cm.category_id = ct.category_id
group by 1,2,3
order by (pledged/goal)*100 desc ; 


-- 5. 
-- You need to send an email to the the contacts for all the "live" projects to let them know how much 
-- is left of their goal amount. Display the first and last name, and email address of each contact,
-- and the amount left to reach the goal for the "live" projects in descending order. 
CREATE TABLE live AS
select first_name,last_name, email, (goal - pledged) amt_left_to_goal, round((pledged/goal)*100,2) || '%' percnt_of_goal from campaign cm
JOIN contacts co
ON cm.contact_id = co.contact_id
where (pledged/goal)*100 < 100 AND outcome = 'live'
order by (goal - pledged) desc;

