class Order < ApplicationRecord
  has_many :orders_parts
  has_many :parts, through: :orders_parts
  validates :orderer_id, :submitted, presence: true
end
