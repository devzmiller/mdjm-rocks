require 'rails_helper'

describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:warehouse) { create(:warehouse) }

  describe 'users#new' do
    it 'returns 200 status' do
      get :new
      expect(response.status).to eq 200
    end
    it 'renders a new user form' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'users#create' do
    context 'successful user creation' do
      before(:each) { post :create, params: {user: { name: "Reginald", employee_num: 777, password: "ham", warehouse: "Seattle"}, role: "scientist"} }
      it 'redirects to parts_path' do
        expect(response).to redirect_to parts_path
      end
    end

    context 'unsuccessful user creation' do
      it 'assigns "needs warehouse" error' do
        post :create, params: {user: { name: "Reginald", employee_num: 777, password: "ham", warehouse: ""}, role: "scientist"}
        expect(assigns[:errors]).to include "Warehouse must exist"
      end
      it 'assigns "user already exists" error' do
        post :create, params: {user: { name: "Reginald", employee_num: user.employee_num, password: "ham", warehouse: "Seattle"}, role: "scientist"}
        expect(assigns[:errors]).to include "Employee num has already been taken"
      end
    end
  end


end
