SELECT s.id AS id,
(((s.first_name)::text || ' '::text) || (s.last_name)::text) AS name,
a.address,
a.postal_code AS zip_code,
a.phone,
cities.city,
countries.country,
s.id AS sid
FROM   (((staff s
          JOIN addresses a
            ON (s.address_id = a.id))
        JOIN cities
          ON (a.city_id = cities.id))
        JOIN countries
          ON (cities.country_id = countries.id));
