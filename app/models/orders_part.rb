class OrdersPart < ApplicationRecord
  belongs_to :part
  belongs_to :order

  validates :part, :order, :quantity_ordered, presence: true
  validates :quantity_ordered, :quantity_received, numericality: { greater_than: 0 }
end
