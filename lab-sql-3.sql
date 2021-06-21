use sakila;

-- How many distinct (different) actors' last names are there?
select count(distinct last_name)
from actor;

-- In how many different languages where the films originally produced? (Use the column language_id from the film table)
select count(distinct language_id)
from film;

-- How many movies were released with "PG-13" rating?
select count(film_id)
from film
where rating = 'PG-13';

-- Get 10 the longest movies from 2006.
select film_id, title, length
from film
where release_year = '2006'
order by length desc
limit 10;

-- How many days has been the company operating (check DATEDIFF() function)?
select min(convert(rental_date, date)) as first_rental, max(convert(rental_date, date)) as most_recent_rental, 
	datediff(max(convert(rental_date, date)), min(convert(rental_date, date))) as operational_days
from rental;

-- Show rental info with additional columns month and weekday. Get 20.
select *, date_format(convert(rental_date, date), '%M') as rental_month, 
	dayname(convert(rental_date, date)) as rental_weekday
from rental
limit 20;

-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week. Check the CASE function.
select *,
case
when weekday(convert(rental_date, date)) >= 6 then 'weekend'
else 'workday' 
end as day_type
from rental
limit 20;

-- How many rentals were in the last month of activity?
select count(rental_id)
from rental
where rental_date >= (select max(rental_date) from rental) - interval 30 day;
