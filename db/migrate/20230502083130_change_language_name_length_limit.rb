class ChangeLanguageNameLengthLimit < ActiveRecord::Migration[7.0]
  def change
    change_column :languages, :name, :string, limit: 20
  end
end
