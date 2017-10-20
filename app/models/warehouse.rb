class Warehouse < ApplicationRecord
  validates :name, presence: true
  has_many :warehouses_parts
  has_many :users
  has_many :parts, through: :warehouses_parts
end
