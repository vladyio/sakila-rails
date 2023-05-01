# == Schema Information
#
# Table name: addresses
#
#  id          :bigint           not null, primary key
#  address     :string(50)       not null
#  address2    :string(50)
#  district    :string(20)       not null
#  phone       :string(20)       not null
#  postal_code :string(10)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  city_id     :bigint           not null
#
# Indexes
#
#  index_addresses_on_city_id  (city_id)
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#
class Address < ApplicationRecord
  belongs_to :city
  has_many :customers

  validates :address, :district, :phone, presence: true
end
