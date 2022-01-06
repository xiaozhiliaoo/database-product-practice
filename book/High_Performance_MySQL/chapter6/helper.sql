

SELECT actor.first_name, actor.last_name, COUNT(*) FROM sakila.film_actor INNER JOIN sakila.actor USING(actor_id) GROUP BY actor.first_name, actor.last_name;

SELECT actor.first_name, actor.last_name, COUNT(*) FROM sakila.film_actor INNER JOIN sakila.actor USING(actor_id) GROUP BY film_actor.actor_id;

SELECT film_id, description FROM sakila.film ORDER BY title LIMIT 50, 5;

SELECT film.film_id, film.description FROM sakila.film INNER JOIN ( SELECT film_id FROM sakila.film ORDER BY title LIMIT 50, 5) AS lim USING(film_id);