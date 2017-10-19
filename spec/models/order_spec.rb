require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "validations" do
    it { should validate_presence_of(:orderer_id) }
    it { should validate_presence_of(:submitted) }
  end
  describe "associations" do
    it { should have_many(:orders_parts) }
    it { should have_many(:parts) }
  end
end
