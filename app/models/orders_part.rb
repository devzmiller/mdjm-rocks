class OrdersPart < ApplicationRecord
  belongs_to :part
  belongs_to :order

  validates :part, :order, presence: true
end
