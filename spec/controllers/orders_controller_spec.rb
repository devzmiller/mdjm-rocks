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

  describe "#new" do
    before(:each) { get :new }

    it "returns 200" do
      expect(response).to be_ok
    end

    it "assigns empty Order to @order" do
      expect(assigns[:order]).to be_a(Order)
    end
  end

  describe "#create" do
    let(:part) { create :part }
    let(:user) { create :user }
    context "valid input" do
      before(:each) { post :create, params: {part_num: part.part_number, part: part.name, quantity: 10},
                                    session: {user_id: user.id}}
      it "creates a new order" do
        expect(assigns[:order]).to eq(Order.last)
      end

      it "Adds part to order" do
        order = assigns[:order]
        expect(Order.find(order.id).parts).to include(part)
      end
    end
    context "invalid input" do
      it "renders :new template when existing part number doesn't match part name" do
        post :create, params: {part_num: part.part_number, part: "wenis", quantity: 10},
                      session: {user_id: user.id}

        expect(response).to render_template(:new)
      end
      it "renders :new template when fields are omitted" do
        post :create, params: {part_num: "", part: "wenis", quantity: 10},
                      session: {user_id: user.id}

        expect(response).to render_template(:new)
      end
    end
  end
end
