class CreateViewSalesByStore < ActiveRecord::Migration[7.0]
  def change
    reversible do |direction|
      direction.up do
        execute <<~SQL
          CREATE VIEW sales_by_store AS
          SELECT   (((c.city)::text || ','::text) || (cy.country)::text) AS store,
                   (((m.first_name)::text || ' '::text) || (m.last_name)::text) AS manager,
                   SUM(p.amount) AS total_sales
          FROM     (((((((payments p
          JOIN     rentals r
          ON       (p.rental_id = r.id))
          JOIN     inventories i
          ON       (r.inventory_id = i.id))
          JOIN     stores s
          ON       (i.store_id = s.id))
          JOIN     addresses a
          ON       (s.address_id = a.id))
          JOIN     cities c
          ON       (a.city_id = c.id))
          JOIN     countries cy
          ON       (c.country_id = cy.id))
          JOIN     staff m
          ON       (s.manager_staff_id = m.id))
          GROUP BY cy.country,
                  c.city,
                  s.id,
                  m.first_name,
                  m.last_name
          ORDER BY cy.country,
                  c.city;

        SQL
      end

      direction.down do
        execute <<~SQL
          DROP VIEW IF EXISTS public.sales_by_store
        SQL
      end
    end
  end
end
