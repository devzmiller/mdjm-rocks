require 'rails_helper'

describe PartsController, type: :controller do
  let!(:warehouse) {create(:warehouse)}
  let!(:part) {create(:part)}
  describe "parts#index" do
    context "when user is a manager" do
      let!(:user) {create(:user)}
      before(:each) { get :index, session: {user_id: user.id}}
      it 'returns ok status' do
        expect(response).to be_ok
      end
      it 'renders index view' do
        expect(response).to render_template :index
      end
      context "when a specific warehouse's parts are requested" do
        before(:each) { get :index, params: {name: "Seattle"} }
        it 'creates a @warehouse instance variable' do
          expect(assigns[:warehouse]).to eq warehouse
        end
        it "creates a parts instance variable which includes only single warehouse's parts" do
          expect(assigns[:parts]).to eq warehouse.parts.uniq
        end
      end
      context "when a nonexistent warehouse is requested" do
        before(:each) { get :index, params: {name: nil}}
        it 'sets an errors instance variable' do
          expect(assigns[:errors]).to include "Warehouse doesn't exist"
        end
        it 'sets a parts instance variable' do
          expect(assigns[:parts]).to eq Part.all
        end
      end
      context "when companywide parts are requested" do
        it 'creates a @parts index variable which includes all parts' do
          expect(assigns[:parts]).to eq Part.all
        end
      end
    end
    context "when user is not a manager" do
      let!(:nonmanager) {create(:non_manager)}
      before(:each) { get :index, session: {user_id: nonmanager.id}}
      it "creates a warehouse instance variable reflecting the user's warehouse" do
        expect(assigns[:warehouse]).to eq nonmanager.warehouse
      end
      it "creates a parts instance variable which reflects the users's warehouse's parts" do
        expect(assigns[:parts]).to eq nonmanager.warehouse.parts.uniq
      end
    end
  end
end
