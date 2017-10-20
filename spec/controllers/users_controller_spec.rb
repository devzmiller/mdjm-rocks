require 'rails_helper'

describe UsersController, type: :controller do
  let!(:user) { create(:user) }

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

end
