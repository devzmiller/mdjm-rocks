require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create :user }
  describe "index" do
    before(:each) { get :index }
    it "returns 200 status code" do
      expect(response).to be_ok
    end

    it "assigns all orders to be @orders" do
      user = create :user
      5.times do
        create(:order, orderer: user)
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

  describe "#show" do
    let (:order) { create :order }
    before(:each) { get :show, params: {id: order.id},
                              session: {user_id: user.id}}
    it "returns 200" do
      expect(response).to be_ok
    end

    it "assigns @order to current order" do
      expect(assigns[:order]).to eq(Order.find(order.id))
    end
  end

  describe "#update" do
    let (:order) { create :order }
    let(:part) { create :part }

    context "valid input" do
      before(:each) { put :update, params: {id: order.id, part_num: part.part_number, part: part.name, quantity: 10},
                                  session: {user_id: user.id}}

      it "redirects back to order show page" do
        expect(response).to redirect_to(order_path(order))
      end
    end

  end
end
