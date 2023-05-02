class RemoveUniqFromCity < ActiveRecord::Migration[7.0]
  def change
    remove_index :cities, :city
  end
end
