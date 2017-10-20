class User < ApplicationRecord

  validates :name, :employee_num, :password, :role, presence: true
  validates :employee_num, uniqueness: true
  belongs_to :warehouse
  has_secure_password

  
end
