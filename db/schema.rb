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

ActiveRecord::Schema[7.0].define(version: 2023_05_01_200917) do
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

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
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
    t.decimal "rantal_rate", precision: 4, scale: 2, null: false
    t.integer "length"
    t.decimal "replacement_cost", precision: 5, scale: 2, null: false
    t.enum "rating", default: "G", enum_type: "rating"
    t.string "special_features", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "language_id"
    t.index ["language_id"], name: "index_films_on_language_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_languages_on_name", unique: true
  end

  add_foreign_key "film_actors", "actors"
  add_foreign_key "film_actors", "films"
  add_foreign_key "film_categories", "categories"
  add_foreign_key "film_categories", "films"
  add_foreign_key "films", "languages"
end
