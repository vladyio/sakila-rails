class AddOriginalLanguageIdToFilm < ActiveRecord::Migration[7.0]
  def change
    add_reference :films, :original_language_id, foreign_key: { to_table: :languages }
  end
end
