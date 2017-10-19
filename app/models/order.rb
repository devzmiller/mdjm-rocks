class Order < ApplicationRecord
  validates :orderer_id, :submitted, presence: true
  has_many :orders_parts
  has_many :parts, through: :orders_parts
  belongs_to :orderer, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
end
