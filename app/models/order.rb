class Order < ApplicationRecord
  validates :orderer_id, presence: true
  validate :submitted_cannot_be_nil
  has_many :orders_parts
  has_many :parts, through: :orders_parts
  belongs_to :orderer, class_name: 'User'
  belongs_to :receiver, class_name: 'User', optional: true

  def in_shipment?
    submitted
  end

  def submitted_cannot_be_nil
    if submitted == nil
      errors.add(:submitted, "cannot be nil")
    end
  end
end