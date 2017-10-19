require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of(:orderer_id) }
    it { should validate_presence_of(:received_date) }
    it { should validate_presence_of(:receiver_id) }
    it { should validate_presence_of(:submitted) }
  end
end
