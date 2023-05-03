class AddCascadingFilm < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :films, :languages
    add_foreign_key :films, :languages, column: :language_id, null: false, index: true,
                                        on_delete: :restrict, on_update: :cascade

    remove_foreign_key :films, :languages, column: :original_language_id
    add_foreign_key :films, :languages, column: :original_language_id,
                                        index: true, on_delete: :restrict, on_update: :cascade
  end
end
