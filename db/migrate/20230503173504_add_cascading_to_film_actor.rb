class AddCascadingToFilmActor < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :film_actors, :actors
    add_foreign_key :film_actors, :actors, null: false, index: true, on_delete: :restrict,
                                           on_update: :cascade

    remove_foreign_key :film_actors, :films
    add_foreign_key :film_actors, :films, null: false, index: true, on_delete: :restrict,
                                          on_update: :cascade
  end
end
