require 'rails_helper'

describe WarehousesController, type: :controller do
  let!(:manager) {create(:user)}
  let!(:non_manager) {create(:non_manager)}
  describe '#new' do
    context "when user is a manager" do
      before(:each) do
        get :new, session: {user_id: manager.id}
      end
      it 'sets a warehouse instance variable' do
        expect(assigns[:warehouse]).to be_a Warehouse
      end
      it 'returns an OK status' do
        expect(response).to be_ok
      end
    end
    context "when user is not a manager" do
      it "renders 404 page" do
        get :new, session: {user_id: non_manager.id}
        expect(response).to render_template "shared/404"
      end
    end
  end

  describe '#create' do
    before(:each) do
      post :create, params: {warehouse: {name: "Seattle"}}, session: {user_id: manager.id}
    end
    context "when user is a manager" do
      it 'sets an instance variable of a warehouse' do
        expect(assigns[:warehouse].name).to eq "Seattle"
      end
      it 'returns an OK status' do
        expect(response).to be_ok
      end

      context 'when warehouse is valid' do
        it 'assigns a parts variable' do
          expect(assigns[:parts]).to be_a Array
        end
        it 'renders the parts index show page' do
          expect(response).to render_template("parts/index")
        end
      end

      context 'when warehouse is invalid' do
        before(:each) do
          post :create, params: {warehouse: {name: nil}}, session: {user_id: manager.id}
        end
        it 'assigns an errors variable' do
          expect(assigns[:errors]).to_not be_empty
        end
        it 'renders the new warehouse view' do
          expect(response).to render_template(:new)
        end
      end
    end

    context 'when user is not a manager' do
      it "renders 404 page" do
        post :create, params: {warehouse: {name: "Seattle"}}, session: {user_id: non_manager.id}
        expect(response).to render_template "shared/404"
      end
    end

  end
end
