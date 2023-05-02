# == Schema Information
#
# Table name: payments
#
#  id           :bigint           not null, primary key
#  amount       :decimal(5, 2)
#  payment_date :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  customer_id  :bigint           not null
#  rental_id    :bigint           not null
#
# Indexes
#
#  index_payments_on_customer_id  (customer_id)
#  index_payments_on_rental_id    (rental_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (rental_id => rentals.id)
#
class Payment < ApplicationRecord
  belongs_to :customer
  belongs_to :rental

  validates :amount, :payment_date, presence: true
end