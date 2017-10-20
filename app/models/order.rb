class Order < ApplicationRecord
  has_many :orders_parts
  has_many :parts, through: :orders_parts
  belongs_to :orderer, class_name: 'User'
  belongs_to :receiver, class_name: 'User', optional: true
  belongs_to :warehouse
  
  validate :submitted_cannot_be_nil
  validates :orderer_id, :warehouse, presence: true

  def in_shipment?
    submitted
  end

  def submitted_cannot_be_nil
    if submitted == nil
      errors.add(:submitted, "cannot be nil")
    end
  end
end
