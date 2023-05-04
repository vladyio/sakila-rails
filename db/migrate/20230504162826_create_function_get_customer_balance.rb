class CreateFunctionGetCustomerBalance < ActiveRecord::Migration[7.0]
  def change
    create_function :get_customer_balance
  end
end
