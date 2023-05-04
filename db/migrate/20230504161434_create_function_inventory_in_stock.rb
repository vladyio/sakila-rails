class CreateFunctionInventoryInStock < ActiveRecord::Migration[7.0]
  def change
    create_function :inventory_in_stock
  end
end
