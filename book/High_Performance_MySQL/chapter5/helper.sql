select count(*) as cnt, city from city group by city order by cnt desc limit 10;

select count(*) as cnt, left(city,3) as perf from city group by perf order by cnt desc limit 10;

select count(*) as cnt, left(city,7) as perf from city group by perf order by cnt desc limit 10;

select count(distinct(city))/count(*)  from city ;

select count(distinct(left(city,3)))/count(*) as sel3, count(distinct(left(city,4)))/count(*) as sel4,count(distinct(left(city,5)))/count(*) as sel5, count(distinct(left(city,6)))/count(*) as sel6, count(distinct(left(city,7)))/count(*) as sel7,count(distinct(left(city,8)))/count(*) as sel8 from city ;

select sum(staff_id=2),sum(customer_id=584) from payment;

select count(*), sum(groupId=10137),sum(userId=1288826),sum(anonymous=0) from message;


EXPLAIN SELECT rental_id, staff_id FROM sakila.rental WHERE rental_date = '2005-05-25' ORDER BY inventory_id, customer_id\G;

EXPLAIN SELECT rental_id, staff_id FROM sakila.rental WHERE rental_date = '2005-05-25' ORDER BY return_date\G;

EXPLAIN SELECT rental_id, staff_id FROM sakila.rental WHERE rental_date = '2005-05-25' ORDER BY inventory_id DESC, customer_id ASC\G;

EXPLAIN SELECT rental_id, staff_id FROM sakila.rental WHERE rental_date = '2005-05-25' ORDER BY inventory_id , staff_id\G;

EXPLAIN SELECT rental_id, staff_id FROM sakila.rental WHERE rental_date > '2005-05-25' ORDER BY inventory_id , customer_id\G;

EXPLAIN SELECT rental_id, staff_id FROM sakila.rental WHERE rental_date = '2005-05-25' and inventory_id in(1,2) ORDER BY customer_id\G;

SELECT actor_id FROM sakila.actor WHERE actor_id < 5 AND actor_id <> 1 FOR UPDATE;

EXPLAIN SELECT * FROM film WHERE rental_rate = '2005-05-25'\G;
