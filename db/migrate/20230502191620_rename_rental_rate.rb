class RenameRentalRate < ActiveRecord::Migration[7.0]
  def change
    rename_column :films, :rantal_rate, :rental_rate
  end
end
