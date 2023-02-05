-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

select distinct (backers_count) backers_count,
cf_id,
outcome
from campaign
where outcome = 'live'
order by backers_count desc;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.

select count (backer_id)
cf_id
from backers
group by cf_id
order by cf_id desc;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

create table email_contacts_remaining_goal_amount as
select first_name,
last_name,
email,
sum(goal - pledged) as Remaining_Goal_Amount
from contacts
left join campaign on campaign.contact_id = contacts.contact_id
where campaign.outcome = 'live'
group by contacts.contact_id
order by Remaining_Goal_Amount desc;

-- Check the table
select * from email_contacts_remaining_goal_amount

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
create table email_backers_remaining_goal_amount as
select email,
first_name,
last_name,
backers.cf_id,
campany_name,
description,
end_date,
sum(goal - pledged) as Left_of_Goal
from backers
right join campaign on campaign.cf_id = backers.cf_id
where campaign.outcome = 'live'
Group by email,
first_name,
last_name,
backers.cf_id,
campany_name,
description,
end_date
order by last_name asc;
-- Lesson said 'email desc' but in order to match image it said to match I had to use 'last_name asc'

-- Check the table
select * from email_backers_remaining_goal_amount

