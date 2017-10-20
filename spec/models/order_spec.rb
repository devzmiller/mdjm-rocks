require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:user) {create(:user)}
  let(:order) { create(:order) }
  describe "validations" do
    it { should validate_presence_of(:orderer_id) }
    it "submitted cannot be nil" do
      order.submitted = nil
      expect(order).to_not be_valid
    end
  end
  describe "associations" do
    it { should have_many(:orders_parts) }
    it { should have_many(:parts) }
    it { should belong_to(:receiver) }
    it { should belong_to(:orderer) }
  end
end
