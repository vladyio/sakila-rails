class AddLanguageToFilm < ActiveRecord::Migration[7.0]
  def change
    add_reference :films, :language, foreign_key: true
  end
end
