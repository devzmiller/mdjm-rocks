require 'rails_helper'

RSpec.describe OrdersPart, type: :model do
  describe "discrepancy" do
    it "calculates the difference between quantity ordered and received" do
      order_part = create(:ordersPart)
      expected_discrepancy = order_part.quantity_received - order_part.quantity_ordered
      expect(order_part.discrepancy).to eq(expected_discrepancy)
    end
  end
end
