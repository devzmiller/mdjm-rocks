require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe "index" do
    before(:each) { get :index }
    it "returns 200 status code" do
      expect(response).to be_ok
    end

    it "assigns all orders to be @orders" do
      5.times do
        create(:order)
      end
      expect(assigns[:orders]).to eq(Order.all)
    end
  end
end
