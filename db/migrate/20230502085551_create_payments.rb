class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :rental, null: false, foreign_key: true
      t.decimal :amount, precision: 5, scale: 2
      t.timestamp :payment_date

      t.timestamps
    end
  end
end
