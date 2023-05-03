# == Schema Information
#
# Table name: rentals
#
#  id           :bigint           not null, primary key
#  rental_date  :datetime         not null
#  return_date  :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  customer_id  :bigint           not null
#  inventory_id :bigint           not null
#  staff_id     :bigint           not null
#
# Indexes
#
#  index_rentals_on_customer_id   (customer_id)
#  index_rentals_on_inventory_id  (inventory_id)
#  index_rentals_on_staff_id      (staff_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id) ON DELETE => restrict ON UPDATE => cascade
#  fk_rails_...  (inventory_id => inventories.id) ON DELETE => restrict ON UPDATE => cascade
#  fk_rails_...  (staff_id => staff.id) ON DELETE => restrict ON UPDATE => cascade
#
class Rental < ApplicationRecord
  belongs_to :inventory
  belongs_to :customer
  belongs_to :staff
  has_many :payments

  validates :rental_date, presence: true
end
