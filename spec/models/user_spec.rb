require 'rails_helper'

describe User do
  let!(:user) {create(:user)}
  describe 'validations' do
    it 'must have a name' do
      user.name = ""
      expect(user).to_not be_valid
    end
    it 'must have an employee number' do
      user.employee_num = nil
      expect(user).to_not be_valid
    end
    it 'must have a unique employee number' do
      new_employee = build(:user)
      new_employee.employee_num = user.employee_num
      expect(new_employee).to_not be_valid
    end
    it 'must have a password' do
      user.password = nil
      expect(user).to_not be_valid
    end
    it 'must have a role' do
      user.role = ""
      expect(user).to_not be_valid
    end
  end
end
