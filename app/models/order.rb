class Order < ApplicationRecord
  validates :orderer_id, :received_date, :receiver_id, :submitted,
      presence: true

end
