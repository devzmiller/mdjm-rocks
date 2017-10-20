require 'rails_helper'

describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:warehouse) { create(:warehouse) }
  let!(:non_manager) { create(:non_manager) }

  describe 'users#new' do
    context "user is a manager" do
      it 'returns 200 status' do
        get :new, session: {user_id: user.id}
        expect(response.status).to eq 200
      end
      it 'renders a new user form' do
        get :new, session: {user_id: user.id}
        expect(response).to render_template(:new)
      end
    end

    context "user is not a manager" do
      it 'renders a 404 page' do
        get :new, session: {user_id: non_manager.id}
        expect(response).to render_template("shared/404")
      end
    end
  end

  describe 'users#create' do
    context 'successful user creation' do
      before(:each) { post :create, params: {user: { name: "Reginald", employee_num: 777, password: "ham", warehouse: "Seattle"}, role: "scientist"}, session: {user_id: user.id} }
      it 'redirects to parts_path' do
        expect(response).to redirect_to parts_path
      end
      it 'adds a new user' do
        expect(User.find_by(employee_num: 777)).to_not be nil
      end
      it 'assigns a warehouse variable' do
        expect(assigns[:warehouse]).to eq Warehouse.find_by(name: "Seattle")
      end
    end

    context 'unsuccessful user creation' do
      it 'assigns "needs warehouse" error' do
        post :create, params: {user: { name: "Reginald", employee_num: 777, password: "ham", warehouse: ""}, role: "scientist"}, session: {user_id: user.id}
        expect(assigns[:errors]).to include "Warehouse must exist"
      end
      it 'assigns "user already exists" error' do
        post :create, params: {user: { name: "Reginald", employee_num: user.employee_num, password: "ham", warehouse: "Seattle"}, role: "scientist"}, session: {user_id: user.id}
        expect(assigns[:errors]).to include "Employee num has already been taken"
      end
      it 'renders new form' do
        post :create, params: {user: { name: "Reginald", employee_num: user.employee_num, password: "ham", warehouse: "Seattle"}, role: "scientist"}, session: {user_id: user.id}
        expect(response).to render_template :new
      end
    end

    context "user is not a manager" do
      before(:each) { post :create, params: {user: { name: "Reginald", employee_num: 777, password: "ham", warehouse: "Seattle"}, role: "scientist"}, session: {user_id: non_manager.id} }

      it 'renders 404 page if a user is not a manager' do
        expect(response).to render_template("shared/404")
      end

    end
  end
end
