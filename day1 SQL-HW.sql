-- 1. List alll customers who live in Texas(use JOINS)

select customer_id, store_id, email, first_name, last_name, address, district
from customer 
join address
on customer.address_id = address.address_id 
where district = 'Texas';

select *
from address
---2. Get all payments above $6.99 with the Customer's Full Name

select first_name || ' ' ||last_name as full_name, amount
from customer
join payment
on customer.customer_id = payment.customer_id
where amount > 6.99;


select *
from payment

--3. Show all customers names who have made payments over 175 bucks ( using subqueries)
select first_name || ' ' || last_name as full_name
from customer
where customer_id in (
	select customer_id
	from payment 
	group by customer_id
	having sum(amount) > 175
	);
--prt b. indy payment > 175
select first_name || ' ' || last_name as full_name
from customer
where customer_id in (
	select customer_id
	from payment 
	where amount > 175
);

--4. List all customers that live in Nepal (use the city table)
-- The same as the multijoin we did in class (except we're looking for customers in Nepal instead of angola)
select customer.customer_id, customer.first_name || ' ' || customer.last_name as full_name, address, city, country
from customer 
join address
on customer.address_id = address.address_id 
join city 
on address.city_id = city.city_id
join country  
on city.country_id = country.country_id 
where country = 'Nepal';

--It's Kevin Schuler!!

-- 5. Which staff has the most transactions?
--(use paymentsand subquery)

select *
from staff
where staff_id in (
	select staff_id
	from payment 
	group by staff_id
	order by count(staff_id) desc
	limit 1
);
--John Stephens 

-- 6. How many movies of each rating are there?

select rating, count(title)
from film 
group by rating;
--PG-13	223
--NC-17	209
--G	179
--PG	194
--R	195

-- 7. WHich customers have made payments over $6.99 (subqueries)
select * 
from customer 
where customer_id in (
	select customer_id 
	from payment
	where amount > 6.99
);

-- 8. How many free rentals did our stores give away?
select count(*)
from payment p 
where amount = 0;

--25