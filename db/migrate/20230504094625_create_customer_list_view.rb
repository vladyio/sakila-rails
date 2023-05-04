class CreateCustomerListView < ActiveRecord::Migration[7.0]
  def change
    reversible do |direction|
      direction.up do
        execute <<~SQL
          CREATE VIEW public.customer_list AS
            SELECT
              cu.id AS id,
              (
                ((cu.first_name)::text || ' '::text) || (cu.last_name)::text
              ) AS name,
              a.address,
              a.postal_code AS "zip code",
              a.phone,
              cities.city,
              countries.country,
              CASE WHEN cu.active = 1 THEN 'active'::text ELSE ''::text END AS notes,
              cu.store_id AS sid
            FROM
              (
                (
                  (
                    customers cu
                    JOIN addresses a ON (cu.address_id = a.id)
                  ) JOIN cities ON (a.city_id = cities.id)
                ) JOIN countries ON (cities.country_id = countries.id)
              );
        SQL
      end

      direction.down do
        execute <<-SQL
          DROP VIEW IF EXISTS public.customer_list
        SQL
      end
    end
  end
end
