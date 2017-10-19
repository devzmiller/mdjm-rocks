class Order < ApplicationRecord
  validates :orderer_id, :submitted, presence: true

end
