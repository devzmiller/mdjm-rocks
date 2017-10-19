require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:user) {create(:user)}
  describe "validations" do
    it { should validate_presence_of(:orderer_id) }
    it { should validate_presence_of(:submitted) }
    # it { should validate_absence_of(:receiver_id) }
  end
  describe "associations" do
    it { should have_many(:orders_parts) }
    it { should have_many(:parts) }
    it { should belong_to(:receiver) }
    it { should belong_to(:orderer) }
  end
end
