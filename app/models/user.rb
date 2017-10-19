class User < ApplicationRecord

  validates :name, :employee_num, :password, :role, presence: true
  validates :employee_num, uniqueness: true
  has_secure_password
end
