SELECT film_id, title, RIGHT(description, 25),
    MATCH(title, description) AGAINST('factory casualties') AS relevance
FROM sakila.film_text
WHERE MATCH(title, description) AGAINST('factory casualties');

SELECT film_id, RIGHT(description, 25),
ROUND(MATCH(title, description) AGAINST('factory casualties'), 3)
  AS full_rel,
ROUND(MATCH(title) AGAINST('factory casualties'), 3) AS title_rel
FROM sakila.film_text
WHERE MATCH(title, description) AGAINST('factory casualties')
ORDER BY (2 * MATCH(title) AGAINST('factory casualties'))
  + MATCH(title, description) AGAINST('factory casualties') DESC;

SELECT film_id, title, RIGHT(description, 25)
FROM sakila.film_text
WHERE MATCH(title, description)
   AGAINST('+factory +casualties' IN BOOLEAN MODE);

SELECT film_id, title, RIGHT(description, 25)
FROM sakila.film_text
WHERE MATCH(title, description)
   AGAINST('"spirited casualties"' IN BOOLEAN MODE);