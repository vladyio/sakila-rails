# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  active     :integer
#  email      :string(50)
#  first_name :string(45)       not null
#  last_name  :string(45)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  address_id :bigint           not null
#
# Indexes
#
#  index_customers_on_address_id  (address_id)
#
# Foreign Keys
#
#  fk_rails_...  (address_id => addresses.id)
#
class Customer < ApplicationRecord
  belongs_to :address
  has_many :payments

  validates :first_name, :last_name, presence: true
  validates :email, length: { maximum: 50 }
end
