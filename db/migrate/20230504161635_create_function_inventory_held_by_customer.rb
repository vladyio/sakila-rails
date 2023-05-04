class CreateFunctionInventoryHeldByCustomer < ActiveRecord::Migration[7.0]
  def change
    create_function :inventory_held_by_customer
  end
end
