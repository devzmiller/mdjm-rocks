class OrdersPart < ApplicationRecord
  belongs_to :part
  belongs_to :order

  validates :part, :order, :quantity_ordered, presence: true
  validates :quantity_ordered, numericality: { greater_than: 0 }

  def discrepancy
    (quantity_received || 0) - quantity_ordered
  end
end
