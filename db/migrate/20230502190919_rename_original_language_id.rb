class RenameOriginalLanguageId < ActiveRecord::Migration[7.0]
  def change
    rename_column :films, :original_language_id_id, :original_language_id
  end
end
