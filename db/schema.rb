# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_04_161635) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "rating", ["G", "PG", "PG-13", "R", "NC-17"]

  create_table "actors", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_name"], name: "index_actors_on_first_name"
    t.index ["last_name"], name: "index_actors_on_last_name"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "address", limit: 50, null: false
    t.string "address2", limit: 50
    t.string "district", limit: 20, null: false
    t.bigint "city_id", null: false
    t.string "postal_code", limit: 10
    t.string "phone", limit: 20, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_addresses_on_city_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "cities", force: :cascade do |t|
    t.string "city"
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_cities_on_country_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "country", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country"], name: "index_countries_on_country", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "first_name", limit: 45, null: false
    t.string "last_name", limit: 45, null: false
    t.string "email", limit: 50
    t.bigint "address_id", null: false
    t.integer "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "store_id"
    t.index ["address_id"], name: "index_customers_on_address_id"
    t.index ["store_id"], name: "index_customers_on_store_id"
  end

  create_table "film_actors", force: :cascade do |t|
    t.bigint "film_id", null: false
    t.bigint "actor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actor_id"], name: "index_film_actors_on_actor_id"
    t.index ["film_id"], name: "index_film_actors_on_film_id"
  end

  create_table "film_categories", force: :cascade do |t|
    t.bigint "film_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_film_categories_on_category_id"
    t.index ["film_id"], name: "index_film_categories_on_film_id"
  end

  create_table "films", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.date "release_year"
    t.integer "rental_duration", null: false
    t.decimal "rental_rate", precision: 4, scale: 2, null: false
    t.integer "length"
    t.decimal "replacement_cost", precision: 5, scale: 2, null: false
    t.enum "rating", default: "G", enum_type: "rating"
    t.string "special_features", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "language_id"
    t.bigint "original_language_id"
    t.index ["language_id"], name: "index_films_on_language_id"
    t.index ["original_language_id"], name: "index_films_on_original_language_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.bigint "film_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "store_id", null: false
    t.index ["film_id"], name: "index_inventories_on_film_id"
    t.index ["store_id"], name: "index_inventories_on_store_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_languages_on_name", unique: true
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "rental_id", null: false
    t.decimal "amount", precision: 5, scale: 2
    t.datetime "payment_date", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "staff_id", null: false
    t.index ["customer_id"], name: "index_payments_on_customer_id"
    t.index ["rental_id"], name: "index_payments_on_rental_id"
    t.index ["staff_id"], name: "index_payments_on_staff_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.datetime "rental_date", precision: nil, null: false
    t.bigint "inventory_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "return_date", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "staff_id", null: false
    t.index ["customer_id"], name: "index_rentals_on_customer_id"
    t.index ["inventory_id"], name: "index_rentals_on_inventory_id"
    t.index ["staff_id"], name: "index_rentals_on_staff_id"
  end

  create_table "staff", force: :cascade do |t|
    t.string "first_name", limit: 45, null: false
    t.string "last_name", limit: 45, null: false
    t.bigint "address_id", null: false
    t.string "email", limit: 50
    t.bigint "store_id", null: false
    t.boolean "active", null: false
    t.string "username", limit: 16, null: false
    t.string "password", limit: 40
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_staff_on_address_id"
    t.index ["store_id"], name: "index_staff_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.bigint "address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "manager_staff_id"
    t.index ["address_id"], name: "index_stores_on_address_id"
    t.index ["manager_staff_id"], name: "index_stores_on_manager_staff_id"
  end

  add_foreign_key "addresses", "cities", on_update: :cascade, on_delete: :restrict
  add_foreign_key "cities", "countries", on_update: :cascade, on_delete: :restrict
  add_foreign_key "customers", "addresses", on_update: :cascade, on_delete: :restrict
  add_foreign_key "customers", "stores", on_update: :cascade, on_delete: :restrict
  add_foreign_key "film_actors", "actors", on_update: :cascade, on_delete: :restrict
  add_foreign_key "film_actors", "films", on_update: :cascade, on_delete: :restrict
  add_foreign_key "film_categories", "categories", on_update: :cascade, on_delete: :restrict
  add_foreign_key "film_categories", "films", on_update: :cascade, on_delete: :restrict
  add_foreign_key "films", "languages", column: "original_language_id", on_update: :cascade, on_delete: :restrict
  add_foreign_key "films", "languages", on_update: :cascade, on_delete: :restrict
  add_foreign_key "inventories", "films", on_update: :cascade, on_delete: :restrict
  add_foreign_key "inventories", "stores", on_update: :cascade, on_delete: :restrict
  add_foreign_key "payments", "customers", on_update: :cascade, on_delete: :restrict
  add_foreign_key "payments", "rentals", on_update: :cascade, on_delete: :restrict
  add_foreign_key "payments", "staff", on_update: :cascade, on_delete: :restrict
  add_foreign_key "rentals", "customers", on_update: :cascade, on_delete: :restrict
  add_foreign_key "rentals", "inventories", on_update: :cascade, on_delete: :restrict
  add_foreign_key "rentals", "staff", on_update: :cascade, on_delete: :restrict
  add_foreign_key "staff", "addresses", on_update: :cascade, on_delete: :restrict
  add_foreign_key "staff", "stores", on_update: :cascade, on_delete: :restrict
  add_foreign_key "stores", "addresses", on_update: :cascade, on_delete: :restrict
  add_foreign_key "stores", "staff", column: "manager_staff_id", on_update: :cascade, on_delete: :restrict
  create_function :_group_concat, sql_definition: <<-'SQL'
      CREATE OR REPLACE FUNCTION public._group_concat(text, text)
       RETURNS text
       LANGUAGE sql
       IMMUTABLE
      AS $function$
      SELECT CASE
        WHEN $2 IS NULL THEN $1
        WHEN $1 IS NULL THEN $2
        ELSE $1 || ', ' || $2
      END
      $function$
  SQL
  create_function :inventory_in_stock, sql_definition: <<-'SQL'
      CREATE OR REPLACE FUNCTION public.inventory_in_stock(p_inventory_id integer)
       RETURNS boolean
       LANGUAGE plpgsql
      AS $function$
      DECLARE
          v_rentals INTEGER;
          v_out     INTEGER;
      BEGIN
          -- AN ITEM IS IN-STOCK IF THERE ARE EITHER NO ROWS IN THE rental TABLE
          -- FOR THE ITEM OR ALL ROWS HAVE return_date POPULATED

          SELECT count(*) INTO v_rentals
          FROM rentals
          WHERE inventory_id = p_inventory_id;

          IF v_rentals = 0 THEN
            RETURN TRUE;
          END IF;

          SELECT COUNT(rentals.id) INTO v_out
          FROM inventories LEFT JOIN rentals ON inventories.id = rentals.inventory_id
          WHERE inventories.id = p_inventory_id
          AND rentals.return_date IS NULL;

          IF v_out > 0 THEN
            RETURN FALSE;
          ELSE
            RETURN TRUE;
          END IF;
      END $function$
  SQL
  create_function :inventory_held_by_customer, sql_definition: <<-'SQL'
      CREATE OR REPLACE FUNCTION public.inventory_held_by_customer(p_inventory_id integer)
       RETURNS integer
       LANGUAGE plpgsql
      AS $function$
      DECLARE
          v_customer_id INTEGER;
      BEGIN

        SELECT customer_id INTO v_customer_id
        FROM rentals
        WHERE return_date IS NULL
        AND inventory_id = p_inventory_id;

        RETURN v_customer_id;
      END $function$
  SQL


  create_view "actor_info", sql_definition: <<-SQL
      SELECT a.id,
      a.first_name,
      a.last_name,
      group_concat(DISTINCT (((c.name)::text || ': '::text) || ( SELECT group_concat((f.title)::text) AS group_concat
             FROM ((films f
               JOIN film_categories fc_1 ON ((f.id = fc_1.film_id)))
               JOIN film_actors fa_1 ON ((f.id = fa_1.film_id)))
            WHERE ((fc_1.category_id = c.id) AND (fa_1.actor_id = a.id))
            GROUP BY fa_1.actor_id))) AS film_info
     FROM (((actors a
       LEFT JOIN film_actors fa ON ((a.id = fa.actor_id)))
       LEFT JOIN film_categories fc ON ((fa.film_id = fc.film_id)))
       LEFT JOIN categories c ON ((fc.category_id = c.id)))
    GROUP BY a.id, a.first_name, a.last_name;
  SQL
  create_view "customer_list", sql_definition: <<-SQL
      SELECT cu.id,
      (((cu.first_name)::text || ' '::text) || (cu.last_name)::text) AS name,
      a.address,
      a.postal_code AS zip_code,
      a.phone,
      cities.city,
      countries.country,
          CASE
              WHEN (cu.active = 1) THEN 'active'::text
              ELSE ''::text
          END AS notes,
      cu.store_id AS sid
     FROM (((customers cu
       JOIN addresses a ON ((cu.address_id = a.id)))
       JOIN cities ON ((a.city_id = cities.id)))
       JOIN countries ON ((cities.country_id = countries.id)));
  SQL
  create_view "film_list", sql_definition: <<-SQL
      SELECT films.id AS fid,
      films.title,
      films.description,
      categories.name AS category,
      films.rental_rate AS price,
      films.length,
      films.rating,
      group_concat((((actors.first_name)::text || ' '::text) || (actors.last_name)::text)) AS actors
     FROM ((((categories
       LEFT JOIN film_categories ON ((categories.id = film_categories.category_id)))
       LEFT JOIN films ON ((film_categories.film_id = films.id)))
       JOIN film_actors ON ((films.id = film_actors.film_id)))
       JOIN actors ON ((film_actors.actor_id = actors.id)))
    GROUP BY films.id, films.title, films.description, categories.name, films.rental_rate, films.length, films.rating;
  SQL
  create_view "nicer_but_slower_film_list", sql_definition: <<-SQL
      SELECT films.id AS fid,
      films.title,
      films.description,
      categories.name AS category,
      films.rental_rate AS price,
      films.length,
      films.rating,
      group_concat((((upper("substring"((actors.first_name)::text, 1, 1)) || lower("substring"((actors.first_name)::text, 2))) || upper("substring"((actors.last_name)::text, 1, 1))) || lower("substring"((actors.last_name)::text, 2)))) AS actors
     FROM ((((categories
       LEFT JOIN film_categories ON ((categories.id = film_categories.category_id)))
       LEFT JOIN films ON ((film_categories.film_id = films.id)))
       JOIN film_actors ON ((films.id = film_actors.film_id)))
       JOIN actors ON ((film_actors.actor_id = actors.id)))
    GROUP BY films.id, films.title, films.description, categories.name, films.rental_rate, films.length, films.rating;
  SQL
  create_view "sales_by_film_category", sql_definition: <<-SQL
      SELECT c.name AS category,
      sum(p.amount) AS total_sales
     FROM (((((payments p
       JOIN rentals r ON ((p.rental_id = r.id)))
       JOIN inventories i ON ((r.inventory_id = i.id)))
       JOIN films f ON ((i.film_id = f.id)))
       JOIN film_categories fc ON ((f.id = fc.film_id)))
       JOIN categories c ON ((fc.category_id = c.id)))
    GROUP BY c.name
    ORDER BY (sum(p.amount)) DESC;
  SQL
  create_view "sales_by_store", sql_definition: <<-SQL
      SELECT (((c.city)::text || ','::text) || (cy.country)::text) AS store,
      (((m.first_name)::text || ' '::text) || (m.last_name)::text) AS manager,
      sum(p.amount) AS total_sales
     FROM (((((((payments p
       JOIN rentals r ON ((p.rental_id = r.id)))
       JOIN inventories i ON ((r.inventory_id = i.id)))
       JOIN stores s ON ((i.store_id = s.id)))
       JOIN addresses a ON ((s.address_id = a.id)))
       JOIN cities c ON ((a.city_id = c.id)))
       JOIN countries cy ON ((c.country_id = cy.id)))
       JOIN staff m ON ((s.manager_staff_id = m.id)))
    GROUP BY cy.country, c.city, s.id, m.first_name, m.last_name
    ORDER BY cy.country, c.city;
  SQL
  create_view "staff_list", sql_definition: <<-SQL
      SELECT s.id,
      (((s.first_name)::text || ' '::text) || (s.last_name)::text) AS name,
      a.address,
      a.postal_code AS zip_code,
      a.phone,
      cities.city,
      countries.country,
      s.id AS sid
     FROM (((staff s
       JOIN addresses a ON ((s.address_id = a.id)))
       JOIN cities ON ((a.city_id = cities.id)))
       JOIN countries ON ((cities.country_id = countries.id)));
  SQL
end
