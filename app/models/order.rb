class Order < ApplicationRecord
  has_many :orders_parts
  has_many :parts, through: :orders_parts
  belongs_to :orderer, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  validates :orderer_id, :submitted, presence: true
end
