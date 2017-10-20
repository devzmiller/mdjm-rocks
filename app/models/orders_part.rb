class OrdersPart < ApplicationRecord
  belongs_to :part
  belongs_to :order

  validates :part, :order, :quantity_ordered, presence: true
end
