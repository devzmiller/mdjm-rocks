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
    context "when user is not logged in" do
      it "redirects to new session path" do
        get :index
        expect(response).to redirect_to new_session_path
      end
    end
  end

  describe "#edit" do
    before(:each) { get :edit, params: {id: part.id} }
    it "assigns @part to current part" do
      expect(assigns[:part]).to eq(part)
    end

    it "renders :edit" do
      expect(response).to render_template(:edit)
    end
  end

  describe "#update" do
    context "valid input" do
      let(:change_part) { create(:part, max_quantity: 20) }
      before(:each) { put :update, params: {id: change_part.id, part: { part_number: change_part.part_number, max_quantity: 10 }}}
      it "updates attributes for a specific part" do
        expect(Part.find(change_part.id).max_quantity).to eq(10)
      end

      it "redirects to edit route" do
        expect(response).to redirect_to(edit_part_path(change_part))
      end

      it "doesn't populate @errors" do
        expect(assigns[:errors]).to eq(nil)
      end
    end

    context 'invalid input' do
      it 'populates @errors' do
        bad_part = create(:part)
        put :update, params: {id: bad_part.id, part: { part_number: "", max_quantity: 10 }}
        expect(assigns[:errors].length).to_not eq(0)
      end
    end
  end
end
