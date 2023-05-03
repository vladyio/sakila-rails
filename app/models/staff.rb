# == Schema Information
#
# Table name: staff
#
#  id         :bigint           not null, primary key
#  active     :boolean          not null
#  email      :string(50)
#  first_name :string(45)       not null
#  last_name  :string(45)       not null
#  password   :string(40)
#  username   :string(16)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  address_id :bigint           not null
#  store_id   :bigint           not null
#
# Indexes
#
#  index_staff_on_address_id  (address_id)
#  index_staff_on_store_id    (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (address_id => addresses.id)
#  fk_rails_...  (store_id => stores.id)
#
class Staff < ApplicationRecord
  self.table_name = 'staff'

  belongs_to :address
  belongs_to :store
  has_many :payments

  validates :first_name, :last_name, presence: true, length: { maximum: 45 }
  validates :email, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 16 }
  validates :password, length: { maximum: 40 }
end
