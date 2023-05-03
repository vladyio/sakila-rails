class AddCascadingToFilmCategory < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :film_categories, :films
    add_foreign_key :film_categories, :films, null: false, index: true, on_delete: :restrict,
                                              on_update: :cascade

    remove_foreign_key :film_categories, :categories
    add_foreign_key :film_categories, :categories, null: false, index: true, on_delete: :restrict,
                                                   on_update: :cascade
  end
end
