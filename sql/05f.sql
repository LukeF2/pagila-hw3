/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
SELECT title
FROM film
WHERE title in (
	SELECT f2.title
	FROM film f
	JOIN film_category fc1 USING (film_id)
	JOIN film_category fc2 USING (category_id)
	JOIN film f2 ON fc2.film_id = f2.film_id
	WHERE f.title = 'AMERICAN CIRCUS'
	GROUP BY f2.title
	HAVING count(f2.title) >= 2
	ORDER BY f2.title
) AND title in(
	SELECT title
	FROM film
	JOIN film_actor USING (film_id)
		WHERE actor_id IN (
    		SELECT actor_id
    		FROM film_actor
    		JOIN film USING (film_id)
    		WHERE title = 'AMERICAN CIRCUS'
	)
	ORDER BY title
)
ORDER BY title;
