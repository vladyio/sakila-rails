SELECT c.name AS category, SUM(p.amount) AS total_sales
FROM   (((((payments p
            JOIN rentals r
              ON (p.rental_id = r.id))
          JOIN inventories i
            ON (r.inventory_id = i.id))
          JOIN films f
            ON (i.film_id = f.id))
        JOIN film_categories fc
          ON (f.id = fc.film_id))
        JOIN categories c
          ON (fc.category_id = c.id))
GROUP BY c.name
ORDER BY SUM(p.amount) DESC;
