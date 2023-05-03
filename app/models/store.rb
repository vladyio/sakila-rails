# == Schema Information
#
# Table name: stores
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  address_id       :bigint           not null
#  manager_staff_id :bigint
#
# Indexes
#
#  index_stores_on_address_id        (address_id)
#  index_stores_on_manager_staff_id  (manager_staff_id)
#
# Foreign Keys
#
#  fk_rails_...  (address_id => addresses.id)
#  fk_rails_...  (manager_staff_id => staff.id)
#
class Store < ApplicationRecord
  belongs_to :address
  belongs_to :manager_staff, class_name: 'Staff', foreign_key: :manager_staff_id
  has_many :staff
  has_many :customers
end
