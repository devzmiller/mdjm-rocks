require 'rails_helper'

RSpec.feature "Users", type: :feature do
  scenario 'user logs in' do
    user = create(:user)
    visit '/'
    fill_in 'Employee Number', with: user.employee_num
    fill_in 'Password', with: user.password
    click_button 'Login'
    expect(page.current_path).to eq parts_path
  end
end
