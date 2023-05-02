class Staff < ApplicationRecord
  self.table_name = 'staff'

  belongs_to :address
  belongs_to :store

  validates :first_name, :last_name, presence: true, length: { maximum: 45 }
  validates :email, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 16 }
  validates :password, length: { maximum: 40 }
end
