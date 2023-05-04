class CreateCustomerList < ActiveRecord::Migration[7.0]
  def change
    create_view :customer_list
  end
end
