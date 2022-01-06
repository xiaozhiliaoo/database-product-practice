EXPLAIN
SELECT actor_id,
   (SELECT 1 FROM sakila.film_actor WHERE film_actor.actor_id =
      der_1.actor_id LIMIT 1)
FROM (
   SELECT actor_id
   FROM sakila.actor LIMIT 5
) AS der_1
UNION ALL
SELECT film_id,
   (SELECT @var1 FROM sakila.rental LIMIT 1)
FROM (
   SELECT film_id,
      (SELECT 1 FROM sakila.store LIMIT 1)
   FROM sakila.film LIMIT 5
) AS der_2;