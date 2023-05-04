class CreateNicerButSlowerFilmList < ActiveRecord::Migration[7.0]
  def change
    reversible do |direction|
      direction.up do
        execute <<~SQL
          CREATE VIEW public.nicer_but_slower_film_list
          AS
            SELECT films.id
                  AS fid,
                  films.title,
                  films.description,
                  categories.name AS category,
                  films.rental_rate AS price,
                  films.length,
                  films.rating,
                  group_concat(( ( ( upper("substring"(( actors.first_name )::text, 1, 1
                                            ))
                                      || lower("substring"(( actors.first_name )::text, 2
                                              ))
                                    )
                                    || upper("substring"(( actors.last_name )::text, 1, 1
                                            ))
                                  )
                                  || lower("substring"(( actors.last_name )::text, 2)) ))
                      AS actors
            FROM   ((((categories
                      LEFT JOIN film_categories
                              ON (categories.id = film_categories.category_id))
                      LEFT JOIN films
                            ON (film_categories.film_id = films.id))
                    JOIN film_actors
                      ON (films.id = film_actors.film_id))
                    JOIN actors
                      ON (film_actors.actor_id = actors.id))
            GROUP  BY films.id,
                      films.title,
                      films.description,
                      categories.name,
                      films.rental_rate,
                      films.length,
                      films.rating;

        SQL
      end

      direction.down do
        execute <<~SQL
          DROP VIEW IF EXISTS public.nicer_but_slower_film_list
        SQL
      end
    end
  end
end
