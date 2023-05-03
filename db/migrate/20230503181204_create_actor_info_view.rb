class CreateActorInfoView < ActiveRecord::Migration[7.0]
  def change
    reversible do |direction|
      direction.up do
        execute <<-SQL
          CREATE OR REPLACE VIEW public.actor_info AS
          SELECT a.id,
                a.first_name,
                a.last_name,
                group_concat(DISTINCT (((c.name)::text || ': '::text) ||
                                          (SELECT group_concat((f.title)::text) AS group_concat
                                          FROM ((films f
                                                  JOIN film_categories fc ON ((f.id = fc.film_id)))
                                                JOIN film_actors fa ON ((f.id = fa.film_id)))
                                          WHERE ((fc.category_id = c.id)
                                                  AND (fa.actor_id = a.id))
                                          GROUP BY fa.actor_id))) AS film_info
          FROM (((actors a
                LEFT JOIN film_actors fa ON ((a.id = fa.actor_id)))
                LEFT JOIN film_categories fc ON ((fa.film_id = fc.film_id)))
                LEFT JOIN categories c ON ((fc.category_id = c.id)))
          GROUP BY a.id,
                   a.first_name,
                   a.last_name;
        SQL
      end

      direction.down do
        execute <<-SQL
          DROP VIEW IF EXISTS public.actor_info
        SQL
      end
    end
  end
end
