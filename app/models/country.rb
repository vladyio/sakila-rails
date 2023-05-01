# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  country    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_countries_on_country  (country) UNIQUE
#
class Country < ApplicationRecord
  has_many :cities

  validates :country, presence: true, uniqueness: true
end
